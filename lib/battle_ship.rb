require "battle_ship/version"

module BattleShip
  class << self
    def read(namespace, uid)
      value = Rails.cache.read(namespace.to_s << '_' << uid.to_s)
      if value
        increment(namespace)
      end
      value
    end

    private
    def increment(namespace, amount = 1, options = {})
      Rails.cache.increment(name, amount, options)
    end
  end
end
