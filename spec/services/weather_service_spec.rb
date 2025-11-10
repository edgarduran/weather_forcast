require 'rails_helper'

RSpec.describe WeatherService do
  it 'returns forecast data for valid coordinates' do
    stub_request(:get, /api.openweathermap.org/).to_return(
      body: {
        main: { temp: 75, temp_min: 70, temp_max: 80 },
        weather: [{ description: "clear sky" }],
        name: "Boulder"
      }.to_json
    )

    result = described_class.new(40.0, -105.0).call
    expect(result[:temp]).to eq(75)
    expect(result[:description]).to eq("clear sky")
  end
end
