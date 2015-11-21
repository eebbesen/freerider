require 'spec_helper'

VEHICLES_JSON = '[{"address": "Grand Ave 1600, 55105 St Paul", "coordinates": [-93.16789, 44.93999, 0], "engineType": "CE", "exterior": "GOOD", "fuel": 26, "interior": "GOOD", "name": "AB1111", "smartPhoneRequired": false, "vin": "AAAAA0AA0AA000000" }, 
{ "address": "West Kellogg Boulevard 15, 55102 St Paul", "coordinates": [-93.093654, 44.943895, 0], "engineType": "CE", "exterior": "GOOD", "fuel": 25, "interior": "GOOD", "name": "AB0011", "smartPhoneRequired": false, "vin": "AAAAA1AA1AA111111" }, 
{ "address": "South 5th Street 350, 55415 Minneapolis", "coordinates": [-93.265769, 44.976851, 0], "engineType": "CE", "exterior": "GOOD", "fuel": 24, "interior": "GOOD", "name": "AB0000", "smartPhoneRequired": false, "vin": "AAAAA2AA2AA222222"}]'
LOCATIONS_JSON = '[{"countryCode":"US", "defaultLanguage":"en", "locationId":29, "locationName":"Twin Cities", "mapSection":{"center":{"latitude":44.983333, "longitude":-93.266667}, "lowerRight":{"latitude":44.723591, "longitude":-92.856746}, "upperLeft":{"latitude":45.159339, "longitude":-93.549185}}, "timezone":"America/Chicago"},
{"countryCode":"US", "defaultLanguage":"en", "locationId":34, "locationName":"New York City", "mapSection":{"center":{"latitude":40.66256953199935, "longitude":-73.9884574151643}, "lowerRight":{"latitude":40.535865, "longitude":-73.867414}, "upperLeft":{"latitude":40.74428, "longitude":-74.094694}}, "timezone":"America/New_York"},
{"countryCode":"DK", "defaultLanguage":"da", "locationId":35, "locationName":"København", "mapSection":{"center":{"latitude":55.668679, "longitude":12.546387}, "lowerRight":{"latitude":55.597893, "longitude":12.709122}, "upperLeft":{"latitude":55.738854, "longitude":12.459183}}, "timezone":"Europe/Copenhagen"}]'
##
# Test stub for Caruby2go
class Caruby2go
  attr_accessor :key
  attr_accessor :location

  def initialize(key, location)
    @key = key
    @location = location
  end

  def vehicles
    JSON.parse VEHICLES_JSON
  end

  def locations
    JSON.parse LOCATIONS_JSON
  end
end

##
# Add accessor for Caruby2go instance to Freerider
class Freerider
  attr_reader :car2go
end

describe Freerider do
  subject { Freerider.new('twincities', 'fake_key', 'Grand Ave 1600, 55105 St Paul') }

  describe '#find_vehicles' do
    it 'should return json for all vehicles below 25 by default' do
      expect(subject.find_vehicles.size).to eq 1
      expect(subject.car2go.location).to eq 'twincities'
    end

    it 'should return json for all vehicles below specified threshold' do
      expect(subject.find_vehicles(26).size).to eq 2
      expect(subject.car2go.location).to eq 'twincities'
    end

    it 'should return json for all vehicles within the given radius' do
      expect(subject.find_vehicles(100, 1).size).to eq 1
    end
  end

  describe '#list_locations' do
    it 'should return a list of all valid location (city) identifiers' do
      expect(subject.list_locations.size).to eq 3
    end
  end
end
