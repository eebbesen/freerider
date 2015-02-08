require 'spec_helper'

describe Formatter do
  let (:vehicle) {'{"address":"Grand Ave 1600, 55105 St Paul","coordinates":[-93.16789,44.93999,0],"engineType":"CE","exterior":"GOOD","fuel":26,"interior":"GOOD","name":"AB6860","smartPhoneRequired":false,"vin":"AAAAA0AA0AA000000"}'}

  describe '#format_vehicle' do
    it 'should return a formatted representation of a vehicle' do
      expect(Formatter.format_vehicle(vehicle)).to eq "1600 Grand Ave, St Paul <<FUEL: 26>> AB6860\nhttps://www.google.com/maps/place/@44.93999,-93.16789,17z"
    end
  end

  describe '#format_address' do
    it "should return a formatted representation of the vehicle's street address location" do
      expect(Formatter.format_address(vehicle)).to eq '1600 Grand Ave, St Paul'
    end
  end

  describe '#format_maps_uri' do
    it "should return a google maps uri of the vehicle's street address location" do
      expect(Formatter.format_maps_uri(vehicle)).to eq 'https://www.google.com/maps/place/@44.93999,-93.16789,17z'
    end
  end

  describe '#format_status' do
    it ' should display the fuel leve and license plate of the vehicle' do
      expect(Formatter.format_status(vehicle)).to eq "<<FUEL: 26>> AB6860"
    end
  end
end
