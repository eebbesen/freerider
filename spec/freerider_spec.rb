require 'spec_helper'
# Read up on this to address deprecation warnings
# http://stackoverflow.com/questions/20275510/how-to-avoid-deprecation-warning-for-stub-chain-in-rspec-3-0

VEHICLES_JSON = '[{"address": "Grand Ave 1600, 55105 St Paul", "coordinates": [-93.16789, 44.93999, 0], "engineType": "CE", "exterior": "GOOD", "fuel": 26, "interior": "GOOD", "name": "AB1111", "smartPhoneRequired": false, "vin": "AAAAA0AA0AA000000" }, { "address": "West Kellogg Boulevard 15, 55102 St Paul", "coordinates": [-93.093654, 44.943895, 0], "engineType": "CE", "exterior": "GOOD", "fuel": 25, "interior": "GOOD", "name": "AB6860", "smartPhoneRequired": false, "vin": "AAAAA1AA1AA111111" }, { "address": "South 5th Street 350, 55415 Minneapolis", "coordinates": [-93.265769, 44.976851, 0], "engineType": "CE", "exterior": "GOOD", "fuel": 24, "interior": "GOOD", "name": "AB0000", "smartPhoneRequired": false, "vin": "AAAAA2AA2AA222222"}]'

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
end

##
# Add accessor for Caruby2go instance to Freerider
class Freerider
  attr_reader :car2go
end

describe Freerider do
  subject { Freerider.new('twincities', 'fake_key') }

  describe '#find_vehicles' do
    it 'should return json for all vehicles below 25 by default' do
      vehicles = subject.find_vehicles
      expect(vehicles.size).to eq 1
      expect(subject.car2go.location).to eq 'twincities'
    end

    it 'should return json for all vehicles below specified threshold' do
      vehicles = subject.find_vehicles(26)
      expect(vehicles.size).to eq 2
      expect(subject.car2go.location).to eq 'twincities'
    end
  end
end
