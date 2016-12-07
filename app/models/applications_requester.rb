class ApplicationsRequester< ActiveRecord::Base
#relationship with other tables
	belongs_to :application
	belongs_to :user
end