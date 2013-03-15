class User < ActiveRecord::Base
  attr_accessible :nickname, :provider_hash, :twitter_uid
  
  has_many :videos
end
