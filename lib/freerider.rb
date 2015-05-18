require 'freerider/version'
require 'caruby2go'

##
# Process values from car2go API calls
class Freerider
  TC = 'twincities'

  def initialize(location,
                 consumer_key = ENV['CONSUMER_KEY'],
                 from_location = ENV['FROM_LOCATION'])
    @car2go = Caruby2go.new(consumer_key, default_if_empty(location, TC))
    @geolocutor = Geolocutor.new(from_location)
  end

  def find_vehicles(upper_fuel_threshold = 25, radius = 100)
    upper_fuel_threshold = default_if_empty(upper_fuel_threshold, 25)
    radius = default_if_empty(radius, 100)
    (@car2go.vehicles.select do |vehicle|
      within_fuel_range(vehicle, upper_fuel_threshold) && within_radius(vehicle, radius)
     end
    ).compact
  end

  private

  def within_fuel_range(vehicle, upper_fuel_threshold)
    vehicle['fuel'] < upper_fuel_threshold
  end

  def within_radius(vehicle, radius)
    @geolocutor.distance_from_here(vehicle) <= radius
  end

  def default_if_empty(value, default)
    if !value || (value.respond_to?('empty?') && value.empty?)
      default
    else
      value
    end
  end
end
