# Weather Forecast App

A minimal **Ruby on Rails** application that retrieves and displays current weather forecasts based on a provided city.

The app integrates with the **OpenWeather API**, supports simple city/state or city/country inputs (e.g. `"Denver, CO"` or `"London, GB"`), and **caches forecasts for 30 minutes** by location to improve performance.

---

## Features

- Accepts a "city" "city, state", or "city, country"
- Retrieves current temperature, high, and low
- Displays whether data came from the cache or API
- Caches results for 30 minutes using Rails cache
- Fully styled with **Tailwind CSS**
- Tested with **RSpec** and **WebMock**

---

## Setup

### 1. Clone, install deps, and configure DB
```bash
git clone https://github.com/<your-username>/weather_forecast.git
cd weather_forecast
bundle install
rails db:create db:migrate
```

### 2. Set up API key
(using dotenv)
For simplicity I will include the api key here. It is a free version and is rate limited.

`OPENWEATHER_API_KEY=f7529addb78cbf2aab7b43eb0527c87f`

### 3. Run the app
Start the Rails server (with Tailwind watcher):
```
bin/dev
```

Visit http://localhost:3000


### Testing
RSpec tests
```
bundle exec rspec
```

### Tech stack
* Ruby on Rails 7.x
* Postgres
* HTTParty
* Tailwind CSS
* Dotenv
* RSpec + WebMock