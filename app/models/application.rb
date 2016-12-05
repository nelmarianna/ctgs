class Application < ActiveRecord::Base

	has_one :conferences
	has_one :user
end
