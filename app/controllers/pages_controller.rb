class PagesController < ApplicationController
#to show home page
	def home
		render("home")
	end
#to show add user page
	def add
		render("add")
	end
end