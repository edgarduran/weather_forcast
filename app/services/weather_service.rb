class WeatherService
  include HTTParty
  base_uri "https://api.openweathermap.org/data/2.5"

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
  end

  def call
    response = self.class.get("/weather",
      query: { lat: @lat, lon: @lon, units: "imperial", appid: ENV["OPENWEATHER_API_KEY"] })

    data = response.parsed_response
    {
      temp: data.dig("main", "temp"),
      temp_min: data.dig("main", "temp_min"),
      temp_max: data.dig("main", "temp_max"),
      description: data["weather"].first["description"],
      location: data["name"]
    }
  rescue StandardError
    nil
  end
end
