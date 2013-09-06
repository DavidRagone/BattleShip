class Cache
end
class Rails
  def self.cache
    Cache
  end
end

require 'spec_helper'

describe Cache do
  it "should now have BattleShip methods" do
    Cache.should respond_to :hits
  end
end
