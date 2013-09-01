module ActiveSupport
  module Cache
    class Store
      def self.inherited(subclass)
        subclass.class_eval("prepend BattleShip")
      end
    end
  end
end
