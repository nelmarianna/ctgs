class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:loginID]

#relationship with other tables
has_many :application

#types of users in the system
TYPES = %w( Staff Supervisor Requester)
  before_save :set_type
  validates :type, presence: true, :inclusion => { :in => TYPES }

  def set_type
    raiser "You must override this method in each model inheriting from User!"
  end

end
