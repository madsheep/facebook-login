class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates_presence_of :email
  mount_uploader :image, ImageUploader
  has_many :authorizations

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.random_password
    Devise.friendly_token[0,10]
  end

  def self.from_omniauth(auth, current_user)
    authorization = Authorization.find_for_auth(auth)
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = new_from_auth(auth)
        user.save
      end
      authorization.username = auth['info']['nickname']
      authorization.user_id = user.id
      authorization.save
    end
    authorization.user
  end
end
