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

This cache must also be able to complete _atomic increment_ operations with the #increment method

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

Instead of calling Rails.cache, call BattleShip. Instead of passing a key, pass
in both a namespace (e.g., sessions or users) and a unique id (e.g. auth_token
or user.id).

After adding to your Gemfile, use BattleShip where you would previously have
used Rails.cache.
* Caching User objects? Call ```BattleShip.write("user", user.id, user)``` for a
  given user object
* This will store the user object just as if you had called ```Rails.cache.write("user_#{user.id}", user)```
* The benefit comes when you call read: ```BattleShip.read("user", 1)```
* If you have a value cached, BattleShip will increment the key at "user_hit" by
  1 (hence the need for atomic increment operations)
* If there is no value found, BattleShip will increment the key at "user_miss"


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do

1. Add accessors for the _hit and _miss values
2. Add config method with any necessary config
3. Create specs specifically using redis-store and memcache-store.
4. Document the above
