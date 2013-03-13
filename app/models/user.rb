class User < ActiveRecord::Base
  attr_accessible :nickname, :provider_hash, :twitter_uid
end
