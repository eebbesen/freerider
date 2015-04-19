class Formatter
  def self.format_vehicle(vehicle)
    address = self.format_address vehicle
    maps_uri = self.format_maps_uri vehicle
    stats = self.format_status vehicle

    "#{address}\n#{stats}\n#{maps_uri}"
  end

  def self.format_address(vehicle)
    address_parts = (JSON.parse vehicle)['address'].split ','

    street_address = address_parts[0].split ' '
    number = street_address.pop
    street_address = street_address.join ' '
    display_address = "#{number} #{street_address}"
    if address_parts[1]
      ciudad = address_parts[1].split ' '
      ciudad.shift
      display_address += ", #{ciudad.join ' '}"
    end

    display_address
  end

  def self.format_maps_uri(vehicle)
    geocode = (JSON.parse vehicle)['coordinates']
    latitude = geocode[0]
    longitude = geocode[1]
    accuracy = geocode[2]

    "https://www.google.com/maps/preview?q=#{longitude},#{latitude}"
  end

  def self.format_status(vehicle)
    fuel_level = (JSON.parse vehicle)['fuel']
    license_plate = (JSON.parse vehicle)['name']
    
    "<<FUEL: #{fuel_level}>> #{license_plate}"
  end
end
