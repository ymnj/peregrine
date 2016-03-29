class TripsController < ApplicationController

  def index
    @trips = current_user.trips.limit(4)

    respond_to do |format|
      format.html { render :index }
      format.js { render "return_map"}
    end

  end

  def new
    @trip = Trip.new

    respond_to do |format|
      format.html { render :index }
      format.js { render "success_trip" }
    end
  end


  def create
    @trips = current_user.trips
    @trip = Trip.new trip_params
    @trip.user = current_user

    respond_to do |format|
      if @trip.save
        format.html { render :index }
        format.js { render "success_trip_added" }
        # format.js { render js: "window.location='#{user_trips_path(@trips)}'" }
      else
        format.html { render :index }
        format.js { render "fail_trip" }
      end
    end
  end


  private

  def trip_params
    params.require(:trip).permit(:title, 
                                 :country, 
                                 :city, 
                                 :start_date, 
                                 :end_date,
                                 :body)   
  end

end
