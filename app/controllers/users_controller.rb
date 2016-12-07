class UsersController < ApplicationController
#shows the users profile. 
	def show
		@users = User.find(current_user.user_id)
	end
#USE CASE: ADD USER
#this method is for when the FGPS is adding a new user to the CTGS
	 def new
	 	@user = User.new
	 	#get the type of user being created based on what button was clicked
		@type = params[:type]

		#produce a list of supervisors
		@sups = User.where(type: Supervisor)

		render("new")
	 end

#this method is used to initalize the new user being created
	def create
		#get the type of user being created based on what button was clicked
		@type =  params[:user][:type]

		if(@type== "Requester")
			new_user_params = params.require(:user).permit(:type, :sup_id, :firstName,:lastName, :loginID, :password, :email, :academicUnit, :studNumb, :program, :sessionNumber, :thesisTopic, :bankAccNumb)
		elsif(@type =="Supervisor")
			new_user_params = params.require(:user).permit(:type, :firstName,:lastName, :loginID, :password, :email, :employeeNumb, :grantAccNumb)
		end
		#create a new user
		@user = User.new(new_user_params)

		 if (@type=="Requester") && (@user.sup_id).present? && (@user.firstName).present? && (@user.lastName).present?&& (@user.loginID).present? && (@user.password).present?&& (@user.email).present? && (@user.academicUnit).present? && (@user.studNumb).present? && (@user.program).present? && (@user.sessionNumber).present? && (@user.thesisTopic).present? && (@user.bankAccNumb).present?
			@user.save
			#put message on screen.
			flash[:success] = "Requester created successfully"
			redirect_to "/home"
		 elsif((@type=="Supervisor") && (@user.firstName).present? && (@user.lastName).present?)
			@user.save
		 	redirect_to "/home"
		 	#put message on screen
		 	flash[:success] = "Supervisor successfully created"
		 else 	
		 	#put message on screen
			flash[:error] = "User not created"
			render("new")
		 end

	end
end
