require "battle_ship/version"

module BattleShip
  class << self
    def read(namespace, uid)
      value = Rails.cache.read(namespace.to_s << '_' << uid.to_s)
      increment("#{namespace}_#{value.nil? ? 'miss' : 'hit'}")
      value
    end

    private
    def increment(key, amount = 1, options = {})
      Rails.cache.increment(key, amount, options)
    end
  end
end
