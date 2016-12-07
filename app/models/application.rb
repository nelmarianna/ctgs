class Application < ActiveRecord::Base
#relationship with other tables
	has_one :conferences
	has_one :user
end
