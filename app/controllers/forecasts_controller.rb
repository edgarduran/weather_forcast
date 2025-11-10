class ForecastsController < ApplicationController
  def new; end

  def create
    address = address_params[:address]
  end

  private

  def address_params
    params.permit(:address)
  end
end
