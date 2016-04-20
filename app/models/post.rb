class Post < ActiveRecord::Base
	validates :facebook_id, uniqueness: true

	def self.facebook_load
		@graph = Koala::Facebook::API.new(ENV["APP_TOKEN"]+"|"+ENV["APP_SECRET"])
		connection = @graph.get_connection(814804005201022, "posts", limit: 100)
		until connection.count == 0 do
			connection.each do |post|
				attachment = @graph.get_connections(post["id"], "attachments")[0]
				if attachment 
					link_url = attachment["url"]
					attachment = attachment["subattachments"]["data"][0] if attachment["subattachments"]
					image_url = attachment["media"]["image"]["src"] if attachment["media"]
					Event.facebook_load(attachment["target"]["id"]) if attachment["type"] == "event"
				end
				params = {
					message:          post["message"], 
					facebook_id: 			post["id"], 
					created_at:       DateTime.parse(post["created_time"]),
					title:            post["story"],
					link_url:         link_url || "https://www.facebook.com/"+post["id"],
					image_url: 				image_url
				}
				Post.create(params)
			end
			connection = connection.next_page
		end
	end

	def short_message
		string = self.message
		string = string.split("http")[0] #stop before a URL
		return string if string.length < 70
		base = string[0..50]
		bonus = string[51..70].split(".!?")[0]+"..."
		return base + bonus
		
	end

end