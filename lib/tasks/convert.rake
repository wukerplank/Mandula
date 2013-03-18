def resize_image(image, target)
  remove = (image[:height] - (image[:width] / 1.7777777777777777777777777777777777777777777777)).floor
  
  image.crop "#{image[:width]}x#{image[:height]-remove}+0+#{(remove / 2).floor}"
  
  image.resize(target)
  
  return image
end

desc "Converts Videos"
task :convert => :environment do
  client = Bunny.new("amqp://#{ENV['RABBIT_MQ_USER']}:#{ENV['RABBIT_MQ_PASSWORD']}@#{ENV['RABBIT_MQ_HOST']}:#{ENV['RABBIT_MQ_PORT']}")
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

      client = Bunny.new("amqp://#{ENV['RABBIT_MQ_USER']}:#{ENV['RABBIT_MQ_PASSWORD']}@#{ENV['RABBIT_MQ_HOST']}:#{ENV['RABBIT_MQ_PORT']}")
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
  
  client.close
  
end