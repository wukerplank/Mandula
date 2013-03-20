class User < ActiveRecord::Base
  attr_accessible :nickname, :provider_hash, :twitter_uid
  
  has_many :videos
  
  before_validation :generate_auth_token
  
  def generate_auth_token
    self.auth_token = Digest::MD5.hexdigest("--#{rand}--#{rand}--#{rand}--")
  end
  
  def generate_new_auth_token!
    self.generate_auth_token
    self.save
    return self.auth_token
  end
end
