class User < ActiveRecord::Base

  USERNAME_FORMAT = /\A[a-zA-Z0-9]+\z/
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  
  mount_uploader :avatar, AvatarUploader
  has_secure_password

  validates :username, uniqueness: { case_sensitive: false},
                       allow_nil: true, 
                       allow_blank: true,
                       length: { maximum: 15 },
                       format: { with: USERNAME_FORMAT }

  validates :email, presence: true,
                    uniqueness: true, on: :create,
                    format: { with: EMAIL_FORMAT},
                    unless:   :from_omniauth?


  validates :first_name,
            :password, presence: true, on: :create

  validates :last_name, presence: true,
            unless:   :from_omniauth?


  private

  def self.find_from_omniauth(omniauth_data)
    User.where(provider: omniauth_data["provider"],
               uid:      omniauth_data["uid"]).first
  end

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data["info"]["name"].split
    User.create(uid:                      omniauth_data["uid"],
                provider:                 omniauth_data["provider"],
                email:                    omniauth_data["info"]['email'],
                first_name:               full_name[0],
                last_name:                full_name[1],
                password:                 SecureRandom.hex(16)
                )
  end

  def from_omniauth?
    uid.present? && provider.present?
  end

  def full_name
    "#{first_name} #{last_name}".titleize
  end
  
end
