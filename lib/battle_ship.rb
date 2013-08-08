require "battle_ship/version"

module BattleShip
  class << self
    def read(namespace, uid)
      value = Rails.cache.read(namespace.to_s << '_' << uid.to_s)
    end
  end
end
