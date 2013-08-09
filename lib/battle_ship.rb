require "battle_ship/version"

module BattleShip
  class << self
    def read(namespace, uid)
      value = cache.read(namespaced(namespace, uid))
      increment_hit_or_miss(namespace, value)
      value
    end

    def write(namespace, uid, value, options = {})
      cache.write(namespaced(namespace, uid), value, options)
    end

    private
    def increment_hit_or_miss(namespace, value, amount = 1, options = {})
      hit_or_miss = value.nil? ? '_miss' : '_hit'
      cache.increment(namespace.to_s << hit_or_miss, amount, options)
    end

    def namespaced(namespace, uid)
      namespace.to_s << '_' << uid.to_s
    end

    def cache
      Rails.cache
    end
  end
end
