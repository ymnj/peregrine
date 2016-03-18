class User < ActiveRecord::Base

  USERNAME_FORMAT = /\A[a-zA-Z0-9]+\z/
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password

  validates :username, uniqueness: { case_sensitive: false },
                       length: { maximum: 15 },
                       format: { with: USERNAME_FORMAT }

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_FORMAT }


  validates :first_name,
            :last_name,
            :password, presence: true


  private

  def full_name
    "#{first_name} #{last_name}".titleize
  end
  
end
