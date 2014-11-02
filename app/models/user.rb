class User < ActiveRecord::Base
	has_many :professions, through: :professionals
	has_many :tickets
	has_many :professionals
	# validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
	# validates :email, uniqueness: true
	# validates :password, length: { minimum: 4 }
	# has_secure_password

	def pro?
		self.professions.length > 0
	end

	def self.create_with_omniauth(auth)  
		create! do |user|  
			user.provider = auth["provider"]  
			user.uid = auth["uid"]  
			user.name = auth["info"]["name"]  
		end  
	end  

end
