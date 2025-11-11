class GeolocationService
  include HTTParty
  base_uri 'http://api.openweathermap.org/geo/1.0'

  def initialize(address)
    @address = sanitize_address(address)
  end

  def call
    response = self.class.get("/direct", query: { q: @address, limit: 1, appid: ENV['OPENWEATHER_API_KEY'] })
    data = response.parsed_response&.first
    return nil unless data["lon"] && data["lat"]

    { lat: data["lat"], lon: data["lon"], location_name: data["name"] }
  rescue StandardError
    nil
  end

  private

  def sanitize_address(address)
    address.to_s.strip.gsub(/[^a-zA-Z0-9\s]/, " ").squeeze(" ")
  end
end
