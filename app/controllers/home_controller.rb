class HomeController < ApplicationController
	def index
		@posts = Post.all
		@upcoming = Event.where("start_time >= ?", DateTime.now).order(start_time: :asc)
		@past = Event.where("start_time < ?", DateTime.now).order(start_time: :desc)
	end
end