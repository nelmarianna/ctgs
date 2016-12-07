class Requester < User
#subclass of User
#relationship with other tables
	def set_type
  		  self.type = 'Requester'
	 end
end
