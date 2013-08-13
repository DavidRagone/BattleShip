# BattleShip

### Keep track of your cache hits & misses

#### Description
If you make use of Rails.cache methods (e.g. #fetch, #read, #write), you may be
curious what your success is with your caching strategies. Perhaps you cache
some user objects, sessions, etc. How do you know whether it's working? What if
it's mostly misses?

BattleShip provides an api that wraps Rails.cache methods. It takes a namespace
by which it will aggregate data on your cache hits and misses.

#### Warnings, Caveats, etc.
Battleship is a gem that expects there to be a class called __Rails__ with a .cache
method. This .cache method must implement the following:
  - fetch
  - read
  - write
  - increment

This cache must also be able to complete atomic increment operations with the #increment method

Currently the only such Cache::Store that I know of that does this is
RedisStore. You can get this by using the (redis-rails
gem)[https://github.com/jodosha/redis-store/tree/master/redis-rails].


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

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
