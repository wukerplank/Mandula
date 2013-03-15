class Video < ActiveRecord::Base
  attr_accessible :description, :title, :video
  
  mount_uploader :video, VideoUploader
  
  def original_path
    self.video.path
  end  

  def converted_path
    File.join Rails.root, 'public', self.video.store_dir, 'converted.mp4'
  end
  
  def converted_url
    File.join self.video.store_dir, 'converted.mp4'
  end
  
  def screenshot_small_path
    File.join Rails.root, 'public', self.video.store_dir, 'small.png'
  end
  
  def screenshot_small_url
    File.join self.video.store_dir, 'small.png'
  end
  
  def screenshot_large_path
    File.join Rails.root, 'public', self.video.store_dir, 'large.png'
  end
  
  def screenshot_large_url
    File.join self.video.store_dir, 'large.png'
  end
  
end
