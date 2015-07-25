require 'spec_helper'

describe Geolocutor do
  let(:vehicle) { '{"address":"Grand Ave 1600, 55105 St Paul","coordinates":[-93.16789,44.93999,0],"engineType":"CE","exterior":"GOOD","fuel":26,"interior":"GOOD","name":"AB0000","smartPhoneRequired":false,"vin":"AAAAA0AA0AA000000"}' }
  let(:vehicle_2) { '{"address":"10th & Park   park spot","coordinates":[-93.26529,44.97035,0],"engineType":"CE","exterior":"GOOD","fuel":18,"interior":"GOOD","name":"AB1111","smartPhoneRequired":false,"vin":"BAAAA0AA0AA000000"}' }
  let(:vehicle_3) { '{"address":"Dr Justus Ohage Blvd, 55107 St Paul","coordinates":[-93.09774,44.93669,0],"engineType":"CE","exterior":"GOOD","fuel":100,"interior":"GOOD","name":"AB2222","smartPhoneRequired":false,"vin":"BAAAA0AA0AA000001"}' }
  let(:vehicle_4) { '{"address":"Abbot Parkspot","coordinates":[-93.27623,44.96604,0],"engineType":"CE","exterior":"BAD","fuel":1,"interior":"GOOD","name":"AB3333","smartPhoneRequired":false,"vin":"BAAAA0AA0AA000003"}' }

  describe '#initialize' do
    it 'should create coordinates from address' do
      geolocutor = Geolocutor.new('1600 Grand Ave, Saint Paul, MN')

      expect(geolocutor.coordinates).to eq([44.9397631, -93.1687294])
    end

    it 'should preserve passed-in coordinates' do
      geolocutor = Geolocutor.new [44.93999, -93.16789]
      expect(geolocutor.coordinates).to eq([44.9397631, -93.1687294])
    end

    it 'should raise an error if no location passed in' do
      expect { Geolocutor.new nil }.to raise_error(ArgumentError, 'You must supply coordinates, and address or a location name')
    end
  end

  describe '#extract_coordinates' do
    it 'should grab coordinates from vehicle JSON' do
      geolocutor = Geolocutor.new('1600 Grand Ave, Saint Paul, MN')
      coordinates = geolocutor.send(:extract_coordinates, JSON.parse(vehicle))
      expect(coordinates).to eq([44.93999, -93.16789])
    end
  end

  describe '#distance_from_here' do
    before do
      @geolocutor = Geolocutor.new('1600 Grand Ave, Saint Paul, MN')
      # avoid rate limiting errors
      puts 'Avoid rate limiting errors on Geolocutor by sleeping 3 seconds...'
      sleep 3
      puts '...done sleeping'
    end

    it 'should return zero when the from and to are the same' do
      distance = @geolocutor.distance_from_here(JSON.parse(vehicle))
      expect(distance).to eq 0
    end

    context 'when looking for the disance in miles' do
      it 'should return the proper value' do
        distance = @geolocutor.distance_from_here(JSON.parse(vehicle_2))
        expect(distance).to eq 3.215852550959139
      end
    end

    context 'when looking for the disance in kilometers' do
      it 'should return the proper value' do
        geolocutor = Geolocutor.new('1600 Grand Ave, Saint Paul, MN', true)
        distance = geolocutor.distance_from_here(JSON.parse(vehicle_2))
        expect(distance).to eq 8.329019877940437
      end
    end
  end
end
