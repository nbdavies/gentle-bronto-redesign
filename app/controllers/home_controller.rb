class HomeController < ApplicationController
	def index
		Post.facebook_load if Post.maximum("created_at").to_date < Date.today
		@posts = Post.all
		@upcoming = Event.where("start_time >= ?", DateTime.now).order(start_time: :asc)
		@past = Event.where("start_time < ?", DateTime.now).order(start_time: :desc)
		@tracks = Track.get([{id: "231855265", name: "Soft Things"},
							 	  {id: "231855261", name: "Rabbit Test"},
							    {id: "231855255", name: "Snacks on a Plane"},
							    {id: "231855251", name: "Eleanor at the End of the World"},
							    {id: "231855248", name: "Isonone"},
							    {id: "231855247", name: "Million Dollar Light Bulb"},
							    {id: "231855246", name: "Carrion Birds"},
							    {id: "231855243", name: "Bruce Willis"},
							    {id: "231855242", name: "Caroline"},
							    {id: "231855240", name: "KFC"},
							    {id: "231855238", name: "Stay"}])
	end
end