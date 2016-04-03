class PhotosController < ApplicationController

  def index
    @trip = current_trip
    @photos = @trip.photos.all
  end

  def new
    @trip = current_trip
    @photo = Photo.new
  end

  def create
    @photo = Photo.new photo_params
    @photo.trip = current_trip

    if @photo.save
      redirect_to trip_photos_path(current_trip)
    else
      render :new
    end
  end





  private

  def current_trip
    Trip.find(params[:trip_id])
  end

   def photo_params
      params.require(:photo).permit(:caption, :location, :trip_photo)
   end
end
