class PhotosController < ApplicationController

  def index
    @photos = current_trip.photos.all
    @photo = Photo.new
  end

  def new
    current_trip
    @photo = Photo.new
  end

  def create
    @photos = current_trip.photos.all
    @photo = Photo.create photo_params
    @photo.trip_id = current_trip.id

    if @photo.save
      redirect_to trip_photos_path
    else
      render :new
    end

  end


  private

  def current_trip
    @trip = Trip.find(params[:trip_id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :location, :trip_photo, :trip_photo_cache)
  end
end
