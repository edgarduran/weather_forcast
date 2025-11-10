class ForecastsController < ApplicationController
  def new; end

  def create
    address = address_params[:address]
    redirect_to root_path, alert: "Please enter an address." and return if address.blank?

    location = GeolocationService.new(address).call
    redirect_to root_path, alert: "Unable to find address." and return if location.blank?


    @forecast = WeatherService.new(location[:lat], location[:lon]).call
    # binding.pry
    render :show
  end

  private

  def address_params
    params.permit(:address)
  end
end
