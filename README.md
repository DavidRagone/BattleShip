# BattleShip

[![Code
Climate](https://codeclimate.com/github/DavidRagone/BattleShip.png)](https://codeclimate.com/github/DavidRagone/BattleShip)

#### Description
The BattleShip gem answers the question "What is my cache hit rate?"

It does this by adding an increment to every cache read operation,
counting each read as either a hit (returned non-nil value) or miss (returned
nil). It stores the resulting numbers of hits and misses in the cache itself.

BattleShip assumes you are caching objects (such as a User or Session object). On a hit, it
will see the class name and increment the hit count at
```"#{returned_object.class}_hits"```, where returned_object is the object that
the cache call returns. On a miss, BattleShip assumes that the key represents
the class name (e.g. you called Rails.cache.read("user_1")), and increments the
miss counter accordingly (e.g. at "user_misses"). If you pass in a ```:namespace``` key in the options
hash, it will use that instead.

## Usage

Cache things just liek you do with Rails.cache methods already.

Access the hits by calling ```#hits``` on your particular cache implementation (e.g.
  ```Rails.cache.hits```) and passing in the namespace, e.g. User (either the string
or the classname).
Same deal with misses, but call ```#misses``` instead

#### Installation

Add this line to your application's Gemfile:

    gem 'battle_ship'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install battle_ship


#### Warnings, Caveats, etc.
If you are using a cache store that does not subclass ActiveSupport::Cache::Store, please add an initializer file in ```config/initializers``` that calls ```BattleShip.include!```

BattleShip uses Module.prepend, so it requires Ruby-2.0.0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do

1. Add performance measurements
3. Add config option for turning on/off
4. Add config option for setting time-frame of hits/misses
