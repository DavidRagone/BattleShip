module BattleShip
  def hits(key)
    read(key.to_s.camelize << '_hits', skip_increment: true, raw: true)
  end

  def misses(key)
    read(key.to_s.camelize << '_misses', skip_increment: true, raw: true)
  end

  def read_entry(key, options) # :nodoc:
    entry = super(key, options)
    return entry if options[:skip_increment]
    if entry
      increment("#{entry.value.class}_hits", 1)
    else
      increment("#{namespace(key, options)}_misses", 1)
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
