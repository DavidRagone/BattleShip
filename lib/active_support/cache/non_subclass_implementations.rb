if defined?(Rails) && defined?(Rails.cache) && !(Rails.cache.respond_to?(:hits))
  Rails.cache.class.class_eval("prepend BattleShip")
end
