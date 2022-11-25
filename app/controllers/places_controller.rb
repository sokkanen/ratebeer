class PlacesController < ApplicationController
  def index
  end

  def show
    get_place(params[:id])
    return unless @place.nil?

    redirect_to places_path
  end

  def search
    Rails.cache.write('latest_city', params[:city])
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index, status: 418
    end
  end

  def get_place(place_id)
    latest = Rails.cache.read('latest_city')
    @place = BeermappingApi.places_in(latest).find { |p| p[:id] == place_id.to_s }
  end
end
