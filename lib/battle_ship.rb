require "battle_ship/version"

module BattleShip
  class << self
    def read(namespace, uid)
      value = cache.read(namespaced(namespace, uid))
      increment("#{namespace}_#{value.nil? ? 'miss' : 'hit'}")
      value
    end

    def write(namespace, uid, value, options = {})
      cache.write(namespaced(namespace, uid), value, options)
    end

    private
    def increment(key, amount = 1, options = {})
      cache.increment(key, amount, options)
    end

    def namespaced(namespace, uid)
      namespace.to_s << '_' << uid.to_s
    end

    def cache
      Rails.cache
    end
  end
end
