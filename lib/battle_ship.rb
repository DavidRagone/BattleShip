require "battle_ship/version"

module BattleShip
  class << self
    def read(namespace, uid)
      value = Rails.cache.read(namespaced(namespace, uid))
      increment("#{namespace}_#{value.nil? ? 'miss' : 'hit'}")
      value
    end

    def write(namespace, uid, value, options = {})
      Rails.cache.write(namespaced(namespace, uid), value, options)
    end

    private
    def increment(key, amount = 1, options = {})
      Rails.cache.increment(key, amount, options)
    end

    def namespaced(namespace, uid)
      namespace.to_s << '_' << uid.to_s
    end
  end
end
