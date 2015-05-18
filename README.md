# Freerider

freerider identifies car2go vehicles in your area which you can refuel for free minutes!


### What?
freerider is a gem that uses [the car2go api](https://code.google.com/p/car2go/wiki/index_v2_1) to locate local car2go vehicles that are less than a specified percent fueled.

You need to [get your own consumer key from car2go](https://www.car2go.com/en/austin/car2go-apps/).

### Why?
car2go offers 20 minutes of free time when you refuel a vehicle that is less than 25 percent fueled.  See the Parking and refueling section of [this page](https://www.car2go.com/en/minneapolis/how-does-car2go-work/) for details.


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

    $ export CONSUMER_KEY=conkey bin/freerider v -l kobenhavn -f 20 -r 3
will use your consumer key and retrieve all vehicles in Copenhagen that are 20 or less fueled

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
