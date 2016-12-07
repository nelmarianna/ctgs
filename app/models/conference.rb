class Conference< ActiveRecord::Base
#relationship with other tables
	has_many :applicationsConferences
	has_many :applications, :through => :applicationsConferences
end
