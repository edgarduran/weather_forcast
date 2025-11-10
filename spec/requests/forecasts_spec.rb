require "rails_helper"

RSpec.describe "Forecasts", type: :request do
  before { Rails.cache.clear }

  let(:address) { "London" }

  let(:location_data) do
    { lat: 51.5085, lon: -0.1257, location_name: "London" }
  end

  let(:forecast_data) do
    {
      temp: 70,
      temp_min: 65,
      temp_max: 75,
      description: "clear sky",
      location: "London"
    }
  end

  it "caches the forecast after first request" do
    # Stub services
    allow_any_instance_of(GeolocationService)
      .to receive(:call)
      .and_return(location_data)

    allow_any_instance_of(WeatherService)
      .to receive(:call)
      .and_return(forecast_data)

    # First request → should call services and populate cache
    post forecasts_path, params: { address: address }
    expect(response).to have_http_status(:ok)

    cache_key = "forecast_#{location_data[:location_name].parameterize}"
    expect(Rails.cache.exist?(cache_key)).to be true

    # Second request → should use cache instead of calling WeatherService
    allow_any_instance_of(WeatherService)
      .to receive(:call)
      .and_raise("Should not be called again")

    post forecasts_path, params: { address: address }
    expect(response.body).to include("Loaded from cache")
  end
end
