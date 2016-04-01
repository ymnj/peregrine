class PhotosController < ApplicationController

  def index
    @trip = Trip.find(params[:trip_id])
  end

  
end
