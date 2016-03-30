class TripsController < ApplicationController

  def index
    @trips = current_user.trips.page(params[:page]).per(5)
    @trips_all = current_user.trips

    @geojson = Array.new

    @trips_all.each do |trip|
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [trip.longitude, trip.latitude]
        },
        properties: {
          name: trip.title,
          address: trip.trip_location,
          :'marker-color' => '#00607d',
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
        }
      }
    end
   
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

  def build_geojson(trips, geojson)
    trips.each do |trip|
      geojson << GeojsonBuilder.build_trip(trip)
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
