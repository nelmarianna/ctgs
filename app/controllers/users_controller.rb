class UsersController < ApplicationController

	def show
		@users = User.find(current_user.user_id)
	end

	 def new
	 	@user = User.new
		@type = params[:type]

		@sups = User.where(type: Supervisor)
		Rails.logger.debug("My object: #{@sups.inspect}")
		render("new")
	 end

	def create
		@type =  params[:user][:type]

		if(@type== "Requester")
			#np = params[:user_session]
			new_user_params = params.require(:user).permit(:type, :sup_id, :firstName,:lastName, :loginID, :password, :email, :academicUnit, :studNumb, :program, :sessionNumber, :thesisTopic, :bankAccNumb)
		elsif(@type =="Supervisor")
			new_user_params = params.require(:user).permit(:type, :firstName,:lastName, :loginID, :password, :email, :employeeNumb, :grantAccNumb)
		end

		@user = User.new(new_user_params)

		 if ((@type=="Requester") && (@user.firstName).present? && (@user.lastName).present?)
			@user.save
		# 	      flash[:notice] = "Country created successfully"

			redirect_to "/home"
		 elsif((@type=="Supervisor") && (@user.firstName).present? && (@user.lastName).present?)
			@user.save
		 	redirect_to "/home"
		 else 
		# 	      flash[:notice] = "CHAHAHAHAHlly"

			render("new")
		 end
		Rails.logger.debug(@type)
		Rails.logger.debug("My object: #{@type.inspect}")


		Rails.logger.info(@user.errors.inspect) 
		# if @user.save
		# 	   flash[:success] = "Created successfully"

		# 	redirect_to "/home"
		# else
		# 	render("new")
		# end
	end
end
