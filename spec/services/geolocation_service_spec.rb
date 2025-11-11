require "rails_helper"

RSpec.describe GeolocationService do
  it "returns coordinates for a valid address" do
    stub_request(:get, /api.openweathermap.org/).to_return(
      body: [{ "lat" => 40.0, "lon" => -105.0, "name" => "Boulder" }].to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    result = described_class.new("Boulder, CO").call
    expect(result).to include(lat: 40.0, lon: -105.0, location_name: "Boulder")
  end

  it "returns nil for invalid address" do
    stub_request(:get, /api.openweathermap.org/).to_return(
      body: [].to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    result = described_class.new("Invalid Place").call
    expect(result).to be_nil
  end

  it "returns nil if missing lat/lon" do
    stub_request(:get, /api.openweathermap.org/).to_return(
      body: [{ "name" => "Nowhere" }].to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

    result = described_class.new("Nowhere").call
    expect(result).to be_nil
  end

  it "removes punctuation and commas from address" do
    service = GeolocationService.new("  Denver, CO ")
    cleaned = service.instance_variable_get(:@address)
    expect(cleaned).to eq("Denver CO")
  end
end
