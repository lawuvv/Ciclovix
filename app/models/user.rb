class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

	#has_many :ponto_interesses, dependent: :destroy
	has_many :credibilidade_pontos, dependent: :destroy
	has_many :denuncias, dependent: :destroy

 	validates_presence_of :name

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0,20]
			user.name = auth.info.name
			user.locale = auth.info.location
			user.gender = auth.extra.raw_info.gender
			user.remember_me = true
		end
	end

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.name = data["name"] if user.name.blank?
				user.email = data["email"] if user.email.blank?
				user.locale = data["location"] if user.locale.blank?
				user.gender = data["gender"] if user.gender.blank?
				user.remember_me = true
			end
		end
	end


end
