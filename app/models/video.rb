class Video < ActiveRecord::Base
  attr_accessible :description, :title, :video
  
  mount_uploader :video, VideoUploader
end
