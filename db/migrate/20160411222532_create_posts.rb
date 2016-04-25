class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :message
    	t.string :facebook_id
    	t.string :title
    	t.string :image_url
    	t.string :link_url
    	t.timestamps
    end
  end
end
