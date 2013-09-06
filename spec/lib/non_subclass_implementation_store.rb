require 'spec_helper'

describe Cache do
  # see spec_helper for class definition (defined before loading BattleShip)
  it "should have BattleShip methods" do
    Rails.cache.should respond_to :hits
  end
end
