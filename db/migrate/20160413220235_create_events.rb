class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string 	   :description
    	t.string 	   :name
    	t.datetime     :start_time
    	t.string 	   :facebook_id
    	t.string 	   :location_name
    	t.string       :location_address
    	t.string	   :latitude
    	t.string       :longitude
    	t.string       :image_url
    	t.integer	   :attending_count
    	t.timestamps
    end
  end
end
