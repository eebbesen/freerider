require 'freerider/version'
require 'open-uri'
require 'json'

class Freerider
  CAR2GO_URI = 'https://www.car2go.com/api/v2.1'
  MPLS = 'minneapolis'

  def initialize(consumer_key)
    @consumer_key = consumer_key
  end

  def get_low_fuel_vehicles
    all_vehicles = get_vehicles
    vehicle_json = JSON.parse(all_vehicles)['placemarks']
    (vehicle_json.collect { |vehicle| vehicle if vehicle['fuel'] < 25 }).compact
  end

  def get_vehicles
    open(build_uri('vehicles'))
  end

  def build_uri(endpoint)
    "#{CAR2GO_URI}/#{endpoint}?loc=#{MPLS}&oauth_consumer_key=#{@consumer_key}&format=json"
  end

end
