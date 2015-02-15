# Freerider

freerider identifies car2go vehicles in your area which you can refuel for free minutes!


### What?
freerider is a gem that leverages [exising geolocation applications](http://apple.stackexchange.com/questions/60152/is-there-a-way-to-access-a-macs-geolocationfrom-terminal) and [the car2go api](https://code.google.com/p/car2go/wiki/index_v2_1) to locate local car2go vehicles that are less than 25 percent fueled.

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

## Usage

After packaging you can run
    $ bin/freerider <your_car2go_consumer_key>

## Dependencies
I have specified Ruby 2.2.0 in the Gemfile, but you can probably get away with any version 2.0.0 or greater.  Ruby 1.9.3 will not work.

## Contributing

1. Fork it ( https://github.com/eebbesen/freerider/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## Helpful tools
### Get geocode for address
http://www.gpsvisualizer.com/geocode
I use this to generate geocode for addresses for testing