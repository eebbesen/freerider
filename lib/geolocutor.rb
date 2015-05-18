require 'geocoder'

##
# Wrap Geocoder gem to calculate relative distances
class Geolocutor
  include Geocoder

  attr_reader :coordinates

  def initialize(location, metric = false)
    @coordinates = coordinatize(location)
    @metric = metric
  end

  def distance_from_here(there)
    there = coordinatize(extract_coordinates(there))
    distance = Geocoder::Calculations.distance_between(@coordinates, there)

    return Geocoder::Calculations.to_kilometers(distance) if @metric
    Geocoder::Calculations.to_miles(distance)
  end

  private

  def coordinatize(location)
    fail(ArgumentError, 'You must supply coordinates, and address or a location name') if location.nil?
    Geocoder.coordinates(location)
  end

  # car2go reverses the lat/long
  # and also includes an accuracy value which must be removed
  def extract_coordinates(vehicle_json)
    coordinates = vehicle_json['coordinates']
    coordinates.pop
    coordinates.reverse
  end
end
