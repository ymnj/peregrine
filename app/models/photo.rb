class Photo < ActiveRecord::Base
  belongs_to :trip
  mount_uploader :trip_photo, TripPhotoUploader
end
