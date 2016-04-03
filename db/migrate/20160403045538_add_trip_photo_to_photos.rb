class AddTripPhotoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :trip_photo, :string
  end
end
