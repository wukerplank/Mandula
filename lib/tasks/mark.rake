desc "connects to rabbitmq and marks videos as failed or finished"
task :mark => :environment do
  
  client = Bunny.new("amqp://#{ENV['RABBIT_MQ_USER']}:#{ENV['RABBIT_MQ_PASSWORD']}@#{ENV['RABBIT_MQ_HOST']}:#{ENV['RABBIT_MQ_PORT']}")
  client.start
  
  channel  = client.create_channel
  
  finished_exchange = channel.fanout('mandula.videos.finished')
  queue = channel.queue("mandula.videos.mark").bind(finished_exchange).subscribe do |delivery_info, metadata, payload|
    json = JSON.parse(payload)
    
    puts "received: #{json.inspect}"
    
    video = Video.find(json['video_id'])
    video.mark_as(json['status'])
  end
  
  loop do
    # wait until this process gets killed
  end
  
  client.close
  
end
