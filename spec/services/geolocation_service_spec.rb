require 'rails_helper'

RSpec.describe GeolocationService do
  it 'returns coordinates for a valid address' do
    stub_request(:get, /api.openweathermap.org/).to_return(
      body: [{ "lat" => 40.0, "lon" => -105.0, "name" => "Boulder" }].to_json
    )

    result = described_class.new("Boulder, CO").call
    expect(result).to include(lat: 40.0, lon: -105.0, zip: "Boulder")
  end

  it 'returns nil for invalid address' do
    stub_request(:get, /api.openweathermap.org/).to_return(body: [].to_json)
    result = described_class.new("Invalid Place").call
    expect(result).to be_nil
  end
end
