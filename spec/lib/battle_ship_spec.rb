require 'spec_helper'

class User
  def initialize(options)
    @name = options[:name]
    @age  = options[:age]
  end
end

class ActiveSupport::Cache::Something < ActiveSupport::Cache::Store
  protected
  def read_entry(key, options)
    @value
  end

  def write_entry(key, entry, options)
    @value = entry
  end
end

describe ActiveSupport::Cache::Something do
  let(:cache) { ActiveSupport::Cache::Something.new }
  let(:user) { User.new(name: 'Bob', age: 'old') }

  context ".read" do
    it "increments the related counter on hits" do
      cache.should_receive(:increment).with("User_hits")
      cache.write("user_1", user)
      cache.read("user_1").should eq user
    end

    it "increments the related counter on misses" do
      cache.should_receive(:increment).with("User_misses")
      cache.read("user_1").should eq nil
    end
  end
end
