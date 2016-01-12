class User < ActiveRecord::Base
	def self.find_or_create_from_auth_hash(auth_hash)
		user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
		user.update(
			name: auth_hash.info.name,
			image: auth_hash.info.image,
			provider_uid: auth_hash.uid
			)
		user
	end
	validates :email, presence: true, uniqueness: true, unless: :provider_uid?
	validates :name, presence: true, on: :create
	validates :password, presence: true, length: { minimum: 4}, unless: :provider_uid?
	has_many :tasks
end
