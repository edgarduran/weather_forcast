class ForecastsController < ApplicationController
  def new; end

  def create
    address = address_params[:address]
    redirect_to root_path, alert: "Please enter an address." and return if address.blank?

    location = GeolocationService.new(address).call
    redirect_to root_path, alert: "Unable to find address." and return if location.blank?

    cache_key = "forecast_#{location[:location_name].parameterize}"

    @from_cache = Rails.cache.exist?(cache_key)
    @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      WeatherService.new(location[:lat], location[:lon]).call
    end

    render :show
  end

  private

  def address_params
    params.permit(:address)
  end
end
