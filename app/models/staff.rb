class Staff < User
#subclass of User
#relationship with other tables
	def set_type
    		self.type = 'Staff'
  	end
end
