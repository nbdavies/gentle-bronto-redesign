class HomeController < ApplicationController
	def index
		Post.facebook_load if Post.maximum("created_at").to_date < Date.today
		@posts = Post.all
		@upcoming = Event.where("start_time >= ?", DateTime.now).order(start_time: :asc)
		@past = Event.where("start_time < ?", DateTime.now).order(start_time: :desc)
	end
end