require 'spec_helper'
# Read up on this to address deprecation warnings
# http://stackoverflow.com/questions/20275510/how-to-avoid-deprecation-warning-for-stub-chain-in-rspec-3-0

describe Freerider do
  subject { Freerider.new('fake_key')}
  let (:vehicles_json) {'{"placemarks":[{"address":"Grand Ave 1600, 55105 St Paul","coordinates":[-93.16789,44.93999,0],"engineType":"CE","exterior":"GOOD","fuel":26,"interior":"GOOD","name":"AB6860","smartPhoneRequired":false,"vin":"AAAAA0AA0AA000000"},{"address":"West Kellogg Boulevard 15, 55102 St Paul","coordinates":[-93.093654,44.943895,0],"engineType":"CE","exterior":"GOOD","fuel":25,"interior":"GOOD","name":"AB6860","smartPhoneRequired":false,"vin":"AAAAA1AA1AA111111"},{"address":"South 5th Street 350, 55415 Minneapolis","coordinates":[-93.265769,44.976851,0],"engineType":"CE","exterior":"GOOD","fuel":24,"interior":"GOOD","name":"AB6860","smartPhoneRequired":false,"vin":"AAAAA2AA2AA222222"}]}'}
  
  describe '#build_uri' do
    puts :vehicles_json
    it 'properly builds an URI' do
      expect(subject.build_uri('something')).to eq "https://www.car2go.com/api/v2.1/something?loc=minneapolis&oauth_consumer_key=fake_key&format=json" 
    end
  end

  describe '#get_vehicles' do
    it 'should return json for all vehicles in the city' do
      subject.stub_chain(:open).and_return(vehicles_json)
      vehicles = subject.get_vehicles
    end
  end

  describe '#get_low_fuel_vehicles' do
    it 'returns only cars with less than twenty-five percent fuel' do
      subject.stub_chain(:open).and_return(vehicles_json)
      vehicles = subject.get_low_fuel_vehicles
      expect(vehicles.size).to eq 1
    end
  end

end