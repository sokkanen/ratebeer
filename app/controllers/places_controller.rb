class PlacesController < ApplicationController
  def index
  end

  def show
    read_latest_city
    get_place(params[:id])
    return unless @place.nil?

    redirect_to places_path
  end

  def search
    Rails.cache.write('latest_city', params[:city])
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherstackApi.weather_in(params[:city])
    puts @weather
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      read_latest_city
      render :index, status: 418
    end
  end

  def read_latest_city
    @latest = Rails.cache.read('latest_city')
  end

  def get_place(place_id)
    @place = BeermappingApi.places_in(@latest).find { |p| p[:id] == place_id.to_s }
  end
end
