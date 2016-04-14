class Post < ActiveRecord::Base
	validates :facebook_post_id, uniqueness: true

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
					facebook_post_id: post["id"], 
					created_at:       DateTime.parse(post["created_time"]),
					title:            post["story"] || post["message"][0..140],
					link_url:         link_url || "https://www.facebook.com/"+post["id"],
					image_url: 				image_url
				}
				Post.create(params)
			end
			connection = connection.next_page
		end
	end

end