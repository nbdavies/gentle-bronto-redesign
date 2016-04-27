class Track < ActiveRecord::Base
	# Not planning to store the tracks in a database, just separating the Soundcloud API logic from controller logic
	# In future, I could store tracks in database, or query Soundcloud to get the list

	# input: array of track IDs (in string form)
	def self.get(tracks)
		client = SoundCloud.new(:client_id => ENV["SOUNDCLOUD_CLIENT_ID"])
		tracks.map! do |track|
			response = client.get('/tracks/'+track[:id]+"/streams")
			track[:url] = response["http_mp3_128_url"]
			track
		end
	end
end