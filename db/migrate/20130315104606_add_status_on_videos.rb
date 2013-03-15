class AddStatusOnVideos < ActiveRecord::Migration
  def change
    
    add_column :videos, :status, :string, :default=>'new', :after=>:user_id
    add_index :videos, :status
    
  end
end
