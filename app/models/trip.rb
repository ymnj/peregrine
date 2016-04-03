class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos

  #Geocoder
  geocoded_by :trip_location   
  after_validation :geocode, on: :create
  
  geocoded_by :trip_location, on: :update

  validates :title, presence: true,
                    uniqueness: { scope: :user_id },
                    length: { maximum: 50 }

  validates :country,
            :start_date,
            :end_date, presence: true

  validates :body, length: { maximum: 140 }


  def country_name
    country_iso = ISO3166::Country[country]
    country_iso.translations[I18n.locale.to_s] || country_iso.name
  end



  def trip_location
    "#{city} #{country_name}"
  end
  
end
