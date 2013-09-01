# BattleShip

### Keep track of your cache hits & misses

#### Description
If you make use of Rails.cache methods (e.g. #fetch, #read, #write), you may be
curious what your success is with your caching strategies. Perhaps you cache
some user objects, sessions, etc. How do you know whether it's working? What if
it's mostly misses?

BattleShip updates ActiveSupport::Cache::Store (and all its subclasses, so
you're covered if you use RedisStore or MemcachedStore) to increment a counter
for each cache hit and miss

#### Warnings, Caveats, etc.
BattleShip works by updating ActiveSupport::Cache::Store, so requires this class
to exist.

This cache must also be able to complete _atomic increment_ operations with the #increment method.

This is early development days for BattleShip. Please feel free to open an issue
here with either questions or suggestions. And, of course, contributions are
welcome.

## Installation

Add this line to your application's Gemfile:

    gem 'battle_ship'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install battle_ship

## Usage

Just keep on using Rails.cache methods like you do today. BattleShip makes
certain assumptions that you should be aware of:
* When there's a cache hit, it will increment the value of the returned object's
  class name plus the string "\_hits" (e.g. a User object's hits will be stored
in the cache at key ```"User_hits"```)
* When there's a cache miss, BattleShip doesn't know exactly the class you were
  expecting, so it assumes that you either: (1) Passed in a namespace key in
the options hash, or (2) Named your key such that the first underscore occurs
after the name of the class (e.g. "User_123").
* Access the hits by calling ```#hits``` on your particular cache implementation (e.g.
  ```Rails.cache.hits```) and passing in the namespace, e.g. User (either the string
or the classname).
* Same deal with misses, but call ```#misses``` instead


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do

1. Add performance measurements
2. Add rails example app
3. Add config option for turning on/off
4. Add config option for setting time-frame of hits/misses
