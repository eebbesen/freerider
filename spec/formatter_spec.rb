require 'spec_helper'

describe Formatter do
  let(:vehicle) { '{"address":"Grand Ave 1600, 55105 St Paul","coordinates":[-93.16789,44.93999,0],"engineType":"CE","exterior":"GOOD","fuel":26,"interior":"GOOD","name":"AB0000","smartPhoneRequired":false,"vin":"AAAAA0AA0AA000000"}' }
  let(:vehicle_2) { '{"address":"10th & Park   park spot","coordinates":[-93.26529,44.97035,0],"engineType":"CE","exterior":"GOOD","fuel":18,"interior":"GOOD","name":"AB1111","smartPhoneRequired":false,"vin":"BAAAA0AA0AA000000"}' }
  let(:vehicle_3) { '{"address":"Dr Justus Ohage Blvd, 55107 St Paul","coordinates":[-93.09774,44.93669,0],"engineType":"CE","exterior":"GOOD","fuel":100,"interior":"GOOD","name":"AB2222","smartPhoneRequired":false,"vin":"BAAAA0AA0AA000001"}' }

  describe '#format_vehicle' do
    it 'should return a formatted representation of a vehicle' do
      expect(Formatter.format_vehicle(vehicle)).to eq "1600 Grand Ave, St Paul\n<<FUEL: 26>> AB0000\nhttps://www.google.com/maps/preview?q=44.93999,-93.16789"
      expect(Formatter.format_vehicle(vehicle_2)).to eq "10th & Park   park spot\n<<FUEL: 18>> AB1111\nhttps://www.google.com/maps/preview?q=44.97035,-93.26529"
      expect(Formatter.format_vehicle(vehicle_3)).to eq "Dr Justus Ohage Blvd, St Paul\n<<FUEL: 100>> AB2222\nhttps://www.google.com/maps/preview?q=44.93669,-93.09774"
    end
  end

  describe '#format_address' do
    it "should return a formatted representation of the vehicle's street address location" do
      expect(Formatter.format_address(vehicle)).to eq '1600 Grand Ave, St Paul'
      expect(Formatter.format_address(vehicle_2)).to eq '10th & Park   park spot'
      expect(Formatter.format_address(vehicle_3)).to eq 'Dr Justus Ohage Blvd, St Paul'
    end
  end

  describe '#format_maps_uri' do
    it "should return a google maps uri of the vehicle's street address location" do
      expect(Formatter.format_maps_uri(vehicle)).to eq 'https://www.google.com/maps/preview?q=44.93999,-93.16789'
    end
  end

  describe '#format_status' do
    it ' should display the fuel leve and license plate of the vehicle' do
      expect(Formatter.format_status(vehicle)).to eq '<<FUEL: 26>> AB0000'
    end
  end
end
