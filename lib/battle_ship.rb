module BattleShip
  def read_entry(key, options) # :nodoc:
    entry = super(key, options)
    if entry
      increment("#{entry.value.class}_hits")
    else
      increment("#{namespace(key, options)}_misses")
    end
    entry
  end

  private
  def namespace(key, options)
    (options[:namespace] || key_up_to_first_underscore(key)).camelize
  end

  def key_up_to_first_underscore(key)
    key[0..(key.index('_') -1)]
  end
end

require "battle_ship/version"
require "active_support/cache/store"
