class PagesController < ApplicationController

	def home
		render("home")
	end
	
	def add
		render("add")
	end
end