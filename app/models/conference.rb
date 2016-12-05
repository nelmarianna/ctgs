class Conference< ActiveRecord::Base

	has_many :applicationsConferences
	has_many :applications, :through => :applicationsConferences
end
