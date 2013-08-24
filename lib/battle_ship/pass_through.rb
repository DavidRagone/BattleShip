module BattleShip
  class << self
    def cleanup(options = nil)
      cache.cleanup(options)
    end

    def clear(options = nil)
      cache.clear(options)
    end

    def delete_matched(matcher, options = nil)
      cache.delete_matched(matcher, options)
    end

    def mute
      cache.mute
    end

    def read_multi(*names)
      cache.read_multi(*names)
    end

    def silence!
      cache.silence!
    end
  end
end
