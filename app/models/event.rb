class Event < ActiveRecord::Base
	validates :facebook_id, uniqueness: true

	def self.facebook_load(facebook_id)
		@graph = Koala::Facebook::API.new(ENV["APP_TOKEN"]+"|"+ENV["APP_SECRET"])
		request_fields = "attending_count,declined_count,interested_count,cover,maybe_count,description,name,noreply_count,place,start_time"
		event = @graph.get_object(facebook_id, fields: request_fields)
		start_time = DateTime.parse(event["start_time"])
		attending_count = event["attending_count"] if start_time < DateTime.now
		image_url = event["cover"]["source"] if event["cover"]
		if event["place"]
			place_name = event["place"]["name"]
			location = event["place"]["location"]
			if location
				address_string = location["street"] + location["city"] + location["state"] + location["zip"]
				latitude = location["latitude"]
				longitude = location["longitude"]
			end
		end
		params = {
			facebook_id:   		facebook_id,
			description:   		event["description"],
			name: 			   		event["name"],
			start_time:  	 		start_time,
			location_name: 		place_name,
			location_address: address_string,
			latitude:         latitude,
			longitude: 				longitude,
			image_url: 				image_url,
			attending_count: 	attending_count
		}
		Event.create(params)
	end

end