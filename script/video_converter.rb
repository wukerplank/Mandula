#!/usr/bin/env ruby -w
# encoding: utf-8

require 'rubygems'
require 'json'
require 'bunny'
require 'open4'

def rabbit_url
  "amqp://#{ENV['RABBIT_MQ_USER']}:#{ENV['RABBIT_MQ_PASSWORD']}@#{ENV['RABBIT_MQ_HOST']}:#{ENV['RABBIT_MQ_PORT']}"
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
    
    json = JSON.parse(payload)
    
    puts "Received: #{json.inspect}"
    
    command = "#{ENV['FFMPEG_PATH']} -i \"#{json['original_path']}\" -vcodec libx264 -strict -2 -acodec aac \"#{json['converted_path']}\""
    puts command
    # system(command)
    pid, stdin, stdout, stderr = Open4::popen4 command
    
    Process::waitpid2 pid
    
    command = "#{ENV['FFMPEG_PATH']} -ss 00:00:30.0 -i \"#{json['original_path']}\" -y -vf 'select=eq(pict_type\\,I)' -r 1 -vframes 1 #{json['screenshot_large_path']}"
    puts command
    # system(command)
    pid, stdin, stdout, stderr = Open4::popen4 command
    Process::waitpid2 pid
    
    client = Bunny.new(rabbit_url)
    client.start
    
    channel  = client.create_channel
    queue    = channel.queue("mandula.videos.new_video")
    exchange = channel.default_exchange
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
