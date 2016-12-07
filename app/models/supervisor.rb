class Supervisor < User
#subclass of User
#relationship with other tables
	def set_type
    		self.type = 'Supervisor'
 	 end
end
