class PhotosController < ApplicationController

  def index
    @photos = current_trip.photos.all
    @photo = Photo.new
  end

  def new
    current_trip
    @photo = Photo.new

    respond_to do |format|
      format.html { render :new }
      format.js { render :js => "window.location.href='"+trip_photos_url(current_trip())+"'" }
      # format.js { render "success_photo_added" }
    end
  end

  def create
    @photos = current_trip.photos.all
    @photo = Photo.new photo_params
    @photo.trip_id = current_trip.id

    if @photo.save
      respond_to do |format|
        format.json{ render :json => @photo }
      end
    else
      render :new
    end
  end

  def edit

  end

  private

  def current_trip
    @trip = Trip.find(params[:trip_id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :location, :trip_photo, :trip_photo_cache)
  end
end

