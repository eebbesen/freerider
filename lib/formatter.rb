##
# Addresses don't always have
# * a city
# * a zip code
# * a numeric component of the street address
class Formatter
  def self.format_vehicle(vehicle)
    address = format_address vehicle
    maps_uri = format_maps_uri vehicle
    stats = format_status vehicle

    "#{address}\n#{stats}\n#{maps_uri}"
  end

  def self.format_address(vehicle)
    address_parts = (JSON.parse vehicle)['address'].split ','
    return address_parts[0] if address_parts.size == 1

    street_address = address_parts[0].split ' '

    # Prepend with number if address has number part
    display_address = if (street_address.last =~ /\d/).nil?
                        street_address.join ' '
                      else
                        number = street_address.pop
                        street_address = street_address.join ' '
                        "#{number} #{street_address}"
                      end

    # Add city if address has city part
    if address_parts[1]
      ciudad = address_parts[1].split ' '
      ciudad.shift unless (ciudad.first =~ /\d/).nil? # zipcode
      display_address += ", #{ciudad.join ' '}"
    end

    display_address
  end

  def self.format_maps_uri(vehicle)
    geocode = (JSON.parse vehicle)['coordinates']
    latitude = geocode[0]
    longitude = geocode[1]
    # accuracy = geocode[2]

    "https://www.google.com/maps/preview?q=#{longitude},#{latitude}"
  end

  def self.format_status(vehicle)
    fuel_level = (JSON.parse vehicle)['fuel']
    license_plate = (JSON.parse vehicle)['name']

    "<<FUEL: #{fuel_level}>> #{license_plate}"
  end
end
