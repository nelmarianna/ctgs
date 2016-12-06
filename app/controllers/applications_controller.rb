class ApplicationsController < ApplicationController

	def new
	 	@application = Application.new
	 	@conference = Conference.new 
		render("new")
	 end

	 def create
	 	application_params =params.require(:application).permit(:status, :transportation, :registration, :accommodation, :meals, :presentationTitle, :presentationType)
	 	conference_params = params.require(:conference).permit(:startDate, :endDate, :website, :location)
	 #	userID =  params[:application][:user_id]
	 	@app = Application.new(application_params)
	 	@conf = Conference.new(conference_params)


	 	 if params[:commit] == 'Submit Application'
		        # submitted
		        	@app.status ="pending"
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
		 	#notify supervisor if submitted
	 		@sup = User.where(sup_id: current_user.sup_id)

	 		#redirect to home pg with msg
	 		redirect_to "/home"
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
		 	redirect_to "/home"
    		end
	 end

	 def index
	 		
	 		if(current_user.type == "Requester")
	 			#show all applications related to curr user
	 			@applications = []
	 			@appReq = ApplicationsRequester.where(requester_id: current_user.user_id).to_a
	 			
	 			#	Rails.logger.debug("MYYYYYYY OBJECTOOOO: #{@appReq.inspect}")
	 			@appReq.each do |ar|
	 				newApp = Application.where(application_id: ar.application_id)
	 				@applications += newApp if newApp
	 			end

	 		elsif(current_user.type == "Supervisor")
	 			#show all applicaions connected to the supervisor
	 			@appReqs = []
	 			@applications = []

	 			@requesters = User.where(sup_id:  current_user.user_id)
Rails.logger.debug("MYYYYYYY requsssss: #{@requesters.inspect}")
	 			@requesters.each do |r|
	 				newReq = ApplicationsRequester.where(requester_id: r.user_id)
	 				@appReqs += newReq if newReq
	 			end
	 			@appReqs.each do |ar|
	 				newApp = Application.where(application_id: ar.application_id)
	 				@applications += newApp if newApp
	 			end
	 		end
	 end

	 def show
	 	#for req, render the application they just saved
	 	#for sup, allow them to refuse or allow
		@conference = []

	 	@application = Application.find(params[:application_id])
#	 	 Rails.logger.debug("BRUHHHHHHHHHHHHHHHHONE #{@application.inspect}")

	 	@appConf = ApplicationsConference.where(application_id: params[:application_id]).to_a
	#  Rails.logger.debug("BRUHHHHHHHHHHHHHHHHtwoo#{@appConf.inspect}")

	  	@appConf.each do |c|
	 		newConf = Conference.where(conference_id: c.conference_id)
	 		@conference += newConf if newConf
	 	end

	 	if params[:commit] == 'Approve Application'

	 	elsif params[:commit] == 'Refuse Application'

	 	elsif params[:commit] == 'Request Change'

	 	end

	 	render("show")

	 end
end