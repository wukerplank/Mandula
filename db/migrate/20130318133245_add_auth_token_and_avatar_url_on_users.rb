class AddAuthTokenAndAvatarUrlOnUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string, :limit=>32, :after=>:nickname
    add_index  :users, :auth_token
    
    add_column :users, :avatar_url, :string, :after=>:nickname
  end
end
