class Trip < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true

  validates :title, presence: true,
                    uniqueness: { scope: :user_id },
                    length: { maximum: 50 }

  validates :country,
            :start_date,
            :end_date, presence: true

  validates :body, length: { maximum: 1000 }
  
end
