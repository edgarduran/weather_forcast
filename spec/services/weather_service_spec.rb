require "rails_helper"

RSpec.describe WeatherService do
  let(:query) do
    {
      lat: 40.0,
      lon: -105.0,
      units: "imperial",
      appid: ENV["OPENWEATHER_API_KEY"]
    }
  end

  it "returns forecast data for valid coordinates" do
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather")
      .with(query: query)
      .to_return(
        body: {
          main: { temp: 75, temp_min: 70, temp_max: 80 },
          weather: [{ description: "clear sky" }],
          name: "Boulder"
        }.to_json,
        headers: { "Content-Type" => "application/json" }
      )

    result = described_class.new(40.0, -105.0).call

    expect(result).not_to be_nil
    expect(result[:temp]).to eq(75)
    expect(result[:description]).to eq("clear sky")
    expect(result[:location]).to eq("Boulder")
  end

  it "returns nil when the response is invalid" do
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather")
      .with(query: query)
      .to_return(
        body: "{}",
        headers: { "Content-Type" => "application/json" }
      )

    result = described_class.new(40.0, -105.0).call
    expect(result).to be_nil
  end
end
