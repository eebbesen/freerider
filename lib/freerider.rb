require 'freerider/version'
require 'open-uri'
require 'json'

class Freerider
  CAR2GO_URI = 'https://www.car2go.com/api/v2.1'
  TC = 'twincities'

  def initialize(consumer_key, location = TC)
    @consumer_key = consumer_key
    @location = if location && !location.empty?
                  location
                else
                  TC
    end
  end

  def get_low_fuel_vehicles
    all_vehicles = get_vehicles
    vehicle_json = JSON.parse(all_vehicles)['placemarks']
    (vehicle_json.select { |vehicle| vehicle['fuel'] < 25 }).compact
  end

  def get_vehicles
    open(build_uri('vehicles')).read
  end

  def build_uri(endpoint)
    "#{CAR2GO_URI}/#{endpoint}?loc=#{@location}&oauth_consumer_key=#{@consumer_key}&format=json"
  end

  attr_reader :location
end
