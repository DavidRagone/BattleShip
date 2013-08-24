module BattleShip
  class << self
    def read(namespace, uid)
      value = cache.read(namespaced(namespace, uid))
      increment_hit_or_miss(namespace, value)
      value
    end

    def write(namespace, uid, value, options = nil)
      cache.write(namespaced(namespace, uid), value, options)
    end

    def fetch(namespace, uid, options = nil)
      # http://mudge.name/2011/01/26/passing-blocks-in-ruby-without-block.html
      namespaced = namespaced(namespace, uid)
      increment_hit_or_miss(namespace, cache.read(namespaced))
      if block_given?
        cache.fetch(namespaced, options, &Proc.new)
      else
        cache.fetch(namespaced, options)
      end
    end

    def decrement(namespace, uid, amount = 1, options = nil)
      cache.decrement(namespaced(namespace, uid), amount, options)
    end

    def delete(namespace, uid, options = nil)
      cache.delete(namespaced(namespace, uid), options)
    end

    def exist?(namespace, uid, options = nil)
      cache.exist?(namespaced(namespace, uid), options)
    end

    def increment(namespace, uid, amount = 1, options = nil)
      cache.increment(namespaced(namespace, uid), amount, options)
    end

    private
    def increment_hit_or_miss(namespace, value, amount = 1, options = nil)
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
