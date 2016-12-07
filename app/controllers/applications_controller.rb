class ApplicationsController < ApplicationController

#this method is used when a requester selects to create a new applicaion. A new conference is also created
	def new
	 	@application = Application.new
	 	@conference = Conference.new
		render("new")
	end
#USE CASE: CREATE APPLICATION
#this method initalizes the variables for the new application created. It gets the parameters through the form.
	def create
	 	application_params =params.require(:application).permit(:status, :transportation, :registration, :accommodation, :meals, :presentationTitle, :presentationType)
	 	conference_params = params.require(:conference).permit(:startDate, :endDate, :website, :location)
	 	
	 	@app = Application.new(application_params)
	 	@conf = Conference.new(conference_params)

#if the user clicked to submit the application
	 	if params[:commit] == 'Submit Application'
     		# submitted
    			@app.status ="pending"
			@app.save
		 	@conf.save
		 	#a new row in the join table for application and requester is made and IDs entered
		 	@appReq = ApplicationsRequester.new
		 	@appReq.requester_id = current_user.user_id
		 	@appReq.application_id = @app.application_id
		 	@appReq.save

		 	#a new row in the join table for application and conference is made and IDs entered
		 	@appConf = ApplicationsConference.new
		 	@appConf.conference_id = @conf.conference_id
		 	@appConf.application_id = @app.application_id
		 	@appConf.save

		 	#notify supervisor if submitted
	 		@sup = User.find current_user.sup_id
			NotificationMailer.application_pending_email(@sup, @app).deliver

	 		#redirect to home pg with msg
	 		flash[:success] = "Application submitted! Supervisor notified"
	 		redirect_to "/home"

#if the user clicked to save and exit		
		elsif params[:commit] == 'Save and Exit'
			#save and exit
			    	@app.status ="draft"
			    	@app.save
		 	@conf.save
		 	@appReq = ApplicationsRequester.new
		 	@appReq.requester_id = current_user.user_id
		 	@appReq.application_id = @app.application_id
		 	@appReq.save

		 	@appConf = ApplicationsConference.new
		 	@appConf.conference_id = @conf.conference_id
		 	@appConf.application_id = @app.application_id
		 	@appConf.save

		 	#redirect to home pg with msg
		 	flash[:success] = "Draft application saved"
		 	redirect_to "/home"
		end
	end

# this method is used to show all applications related to the current user
	 def index
	 		#if  the current user is a requester
	 		if(current_user.type == "Requester")
	 			#create an empty array for the applications
	 			@applications = []
	 			#find the applications related to the current user through the join table
	 			@appReq = ApplicationsRequester.where(requester_id: current_user.user_id).to_a

	 			#for each appllication found, add that application into the array holding the users applications
	 			@appReq.each do |ar|
	 				newApp = Application.where(application_id: ar.application_id)
	 				@applications += newApp if newApp
	 			end
	 		#if the current user is a supervisor
	 		elsif(current_user.type == "Supervisor")
	 			#create an empty arrays for the jrows where the requester has an application and all the applications 
	 			@appReqs = []
	 			@applications = []
	 			#find all requesters, that have the current user as their supervisor
	 			@requesters = User.where(sup_id:  current_user.user_id)
	 			
	 			#for each requester found, add the row of the join table in order to find the application
	 			@requesters.each do |r|
	 				newReq = ApplicationsRequester.where(requester_id: r.user_id)
	 				@appReqs += newReq if newReq
	 			end
	 	 		#for each appllication found, add that application into the array holding the users applications
	 			@appReqs.each do |ar|
	 				newApp = Application.where(application_id: ar.application_id)
	 				@applications += newApp if newApp
	 			end
	 		end
	 end

#this method shows the information for the selected application
	 def show
	 	#create an array that will hold the conference found
		@conference = []
		#find the application with the ID parameter that was passed in 
		@application = Application.find(params[:application_id])

		#find the rows in the join table that are associated with this application
		@appConf = ApplicationsConference.where(application_id: params[:application_id]).to_a

		#for each conference found, add it into the conference array
	  	@appConf.each do |c|
	 		newConf = Conference.where(conference_id: c.conference_id)
	 		@conference += newConf if newConf
	 	end

	 	render("show")
	 end

#this method is used when supervisors choose to review an application
	 def edit
		@app = Application.find(params[:application_id])
		render("edit")
	end

#USE CASE: MAKE RECCOMMENDATION
#this method is used to update the status on an application depending on what the supervisor chooses
	def update
		#find the current application 
		@app = Application.find(params[:application_id])

		appreq = ApplicationsRequester.where(application_id: @app.id).first
		req = User.find(appreq.requester_id)
		staff = User.where(type: Staff).first

		#if the supervisor chooses to approve the application
		if params[:commit] == 'Approve Application'
			#change the applications status
	 		if @app.update_attribute(:status, "pending faculty evaluation")
	 			#put notice on screen
	 			flash[:success] = "Application approved !! Requester and FGPS Staff notified"

	 			#send email to requester and FGPS Staff
		#		NotificationMailer.application_faculty_pending_email(req, @app).deliver
		#		NotificationMailer.application_pending_email(staff, @app).deliver

	 			redirect_to "/home"
	 		else
	 			render("edit")
	 		end
	 	#if the supervisor chooses to refuse the application
	 	elsif params[:commit] == 'Refuse Application'
	 		#change the application status
			if @app.update_attribute(:status, "refused")
				#put notice on screen
				flash[:success] = "Application refused. Requester has been notified"

				#send email to requester
		#		NotificationMailer.application_refused_email(req, @app).deliver

				redirect_to "/home"
			else
				render("edit")
			end
		#if the supervisor chooses to request changes
		elsif params[:commit] == 'Request Changes'
			change_param = params[:reqChange]
				#change the application status and include the reason of change
				if (@app.update_attribute(:status, "incomplete") && @app.update_attribute(:reqChange,  change_param))
					#put notice on screen
					lash[:success] = "Application requires modification. Requester has been notified"
					#send email to requester
		#			NotificationMailer.application_change_email(req, @app).deliver

					redirect_to "/home"
				else
					render("edit")
				end
	 	end
	end

end
