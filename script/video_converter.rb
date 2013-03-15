#!/usr/bin/env ruby -w
# encoding: utf-8

require 'rubygems'
require 'json'
require 'bunny'
require 'open4'
require 'mini_magick'

def rabbit_url
  "amqp://#{ENV['RABBIT_MQ_USER']}:#{ENV['RABBIT_MQ_PASSWORD']}@#{ENV['RABBIT_MQ_HOST']}:#{ENV['RABBIT_MQ_PORT']}"
end

def resize_image(image, target)
  remove = (image[:height] - (image[:width] / 1.7777777777777777777777777777777777777777777777)).floor
  
  image.crop "#{image[:width]}x#{image[:height]-remove}+0+#{(remove / 2).floor}"
  
  image.resize(target)
  
  return image
end


client = Bunny.new(rabbit_url)
client.start

channel  = client.create_channel
queue    = channel.queue("mandula.videos.new_video")
exchange = channel.default_exchange

loop do
  _, _, payload = queue.pop
  
  if payload
    client.stop
    
    begin
      json = JSON.parse(payload)
    
      puts "Received: #{json.inspect}"
    
      command = "#{ENV['FFMPEG_PATH']} -i \"#{json['original_path']}\" -vcodec libx264 -strict -2 -acodec aac \"#{json['converted_path']}\""
      puts command
      # system(command)
      pid, stdin, stdout, stderr = Open4::popen4 command
    
      Process::waitpid2 pid
    
      command = "#{ENV['FFMPEG_PATH']} -ss 00:00:01.0 -i \"#{json['original_path']}\" -y -vf 'select=eq(pict_type\\,I)' -r 1 -vframes 1 #{json['screenshot_large_path']}"
      puts command
      # system(command)
      pid, stdin, stdout, stderr = Open4::popen4 command
      Process::waitpid2 pid
    
      image = MiniMagick::Image.open(json['screenshot_large_path'])
    
      resize_image(image, "852x480")
      image.write json['screenshot_large_path']
    
      resize_image(image, "274x154")
      image.write json['screenshot_small_path']
      
      status = 'success'
    rescue Exception => e
      puts "Exception:"
      puts "----------------------------"
      puts e
      puts "----------------------------"
      
      
      status = 'error'
    end
    
    client = Bunny.new(rabbit_url)
    client.start
    
    channel  = client.create_channel
    queue    = channel.queue("mandula.videos.new_video")
    exchange = channel.default_exchange
    
    finished_exchange = channel.fanout('mandula.videos.finished')
    finished_exchange.publish({
      'video_id' => json['video_id'],
      'status'   => status
    }.to_json)
  end
  
end

# queue.subscribe do |delivery_info, metadata, payload|
#   json = JSON.parse(payload)
#   
#   puts "Received: #{json.inspect}"
#   
#   # ffmpeg -i test_video.avi -vcodec libx264 -strict -2 -acodec aac converted.mp4
#   command = "#{ENV['FFMPEG_PATH']} -i \"#{json['original_path']}\" -vcodec libx264 -strict -2 -acodec aac \"#{json['converted_path']}\""
#   puts command
#   # system(command)
#   pid, stdin, stdout, stderr = Open4::popen4 command
#   Process::waitpid2 pid
#   
#   command = "#{ENV['FFMPEG_PATH']} -ss 00:00:30.0 -i \"#{json['original_path']}\" -y -vf 'select=eq(pict_type\\,I)' -r 1 -vframes 1 #{json['screenshot_large_path']}"
#   puts command
#   # system(command)
#   pid, stdin, stdout, stderr = Open4::popen4 command
#   Process::waitpid2 pid
#   
# end
# 
# loop do
#   # wait until this process gets killed
# end

client.close
