[![Circle CI](https://circleci.com/gh/eebbesen/freerider.svg?style=shield)](https://circleci.com/gh/eebbesen/freerider)

# Freerider

freerider identifies Car2Go vehicles in your area

[_Previously_ Car2Go offerred 20 minutes of free time to drivers who refueled vehicles with a fuel level under 25%.](https://www.car2go.com/en/minneapolis/how-does-car2go-work/
)  

This is no longer the case (at least in the Twin Cities).  However you _can_get credit by moving Car2Go vehicles that are in violation of snow emergency restrictions (you need to email Car2Go with start/stop vehicle location and time of move.)
http://minneapolis.car2go.com/minneapolis-car2go-faqs/

So maybe you can use this to make sure you find a car that you don't have to refuel out of your own pocket.

### Requirements
freerider is a gem that uses [the car2go api](https://code.google.com/p/car2go/wiki/index_v2_1) to locate local car2go vehicles that are less than a specified percent fueled.

You need to [get your own consumer key from car2go](https://www.car2go.com/en/austin/car2go-apps/) to use this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'freerider'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install freerider

## Packaging
`rake build`

or run

`./build`

to build _and_ install the gem

## Usage

After packaging you can run

    $ CONSUMER_KEY=<your_car2go_consumer_key> FROM_LOCATION='<address_or_place_name>' bin/freerider [-l <location>] [-f <fuel_threshold>] [-r <radius>]
or

    $ export CONSUMER_KEY=<your_car2go_consumer_key> 
    $ bin/freerider [-l <location>] [-f <fuel_threshold>] [-r <radius>]

For example

    $ export CONSUMER_KEY=conkey bin/freerider v -l twincities -f 20 -r 3
will use your consumer key and retrieve all vehicles withing three miles of a point in Minnesota's Twin Cities that are 20 percent or less fueled

`location` will default to `twincities` (represent!).
`fuel_threshold` will default to `25`.

## Dependencies
I work/test using Ruby 2.2.x but any version 2.0.0 or greater will work.  Ruby 1.9.3 is right out.

## Contributing

1. Fork it ( https://github.com/eebbesen/freerider/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Helpful tools
### Geocoder gem
#### Get geocode for address or business name

    Geocoder.coordinates("Fasika, Saint Paul, MN")

#### Distance calculation

    geo_distance = Geocoder::Calculations.distance_between([-93.09774, 44.93669],[-93.17795, 44.94289])
    Geocoder::Calculations.to_miles(geo_distance)
