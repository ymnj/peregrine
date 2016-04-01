class TripsController < ApplicationController

  def index
    @trips = current_user.trips.order(created_at: :desc)
    @trips_all = current_user.trips

    @geojson = Array.new
    geobuilder(@trips_all, current_user)
   
    respond_to do |format|
      format.html { render :index }
      format.js { render "return_map" }
      format.json { render json: @geojson }
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
      else
        format.html { render :index }
        format.js { render "fail_trip" }
      end
    end
  end


  private

  def geobuilder(trips, user)
    trips.each do |trip|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [trip.longitude, trip.latitude]
        },
        properties: {
          title: trip.title,
          id: trip.id,
          url: trip_photos_url(trip.id),
          description: trip.trip_location,
          icon: {
              iconUrl: avatar(user), 
              iconSize: [40, 40], # size of the icon
              iconAnchor: [20, 20], # point of the icon which will correspond to marker's location
              popupAnchor: [0, -25], # point from which the popup should open relative to the iconAnchor
              className: "marker-icon"
              }
        }
      }
    end
  end


  def trip_params
    params.require(:trip).permit(:title, 
                                 :country, 
                                 :city, 
                                 :start_date, 
                                 :end_date, 
                                 :body)   
  end

end
