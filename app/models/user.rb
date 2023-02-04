class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :registerable, :confirmable, :lockable, :trackable, :timeoutable,
         :omniauthable
          # :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
    end
  end
  
  # def self.from_omniauth(response)
  #   User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
  #     u.email = response[:info][:email]
  #     u.password = SecureRandom.hex
  #     u.name = response[:info][:name]
  #     u.skip_confirmation!
  #   end
  # end
end
