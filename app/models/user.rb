class User < ActiveRecord::Base
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true, on: :create
	validates :password, presence: true, length: { minimum: 4}, unless: :provider_uid?
	has_many :tasks
end
