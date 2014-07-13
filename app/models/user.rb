class User < ActiveRecord::Base
	validates :name, :facebook_link, presence: true
end
