require 'freerider/version'
require 'caruby2go'

##
# Process values from car2go API calls
class Freerider
  TC = 'twincities'

  def initialize(location, consumer_key = ENV['CONSUMER_KEY'])
    @car2go = Caruby2go.new(consumer_key, default_if_empty(location, TC))
  end

  def find_vehicles(upper_fuel_threshold = 25)
    upper_fuel_threshold = default_if_empty(upper_fuel_threshold, 25)
    (@car2go.vehicles.select do |vehicle|
       vehicle['fuel'] < upper_fuel_threshold
     end
    ).compact
  end

  private

  def default_if_empty(value, default)
    if !value || (value.respond_to?('empty?') && value.empty?)
      default
    else
      value
    end
  end
end
