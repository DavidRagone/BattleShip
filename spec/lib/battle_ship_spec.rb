require 'spec_helper'

class Rails
  def self.cache
    Cache
  end
end

class Cache
  def read(value)
  end
end

describe BattleShip do
  before do
    # setup
  end

  describe ".read" do
    shared_examples_for :read do
      let(:cache_double) { double }

      it "retrieves value from Rails.cache.read" do
        Rails.should_receive(:cache) { cache_double }
        cache_double.should_receive(:read).with("namespace_#{uniqueid}")

        BattleShip.read(:namespace, uniqueid)
      end

      it "returns value from Rails.cache.read" do
        Rails.stub_chain(:cache, :read) { 'a value' }

        BattleShip.read(:foo, :bar).should eq 'a value'
      end

      it "increments namespace counter when value is non-nil" do
        incrementer = double increment: 5
        # How stub same object with two differen tmethods, expect both be called?
        Rails.stub(:cache) { double :cache, read: 'a value' }
        Rails.stub(:cache) { incrementer }
        incrementer.should_receive(:increment)

        BattleShip.read(:foo, :bar)
      end
    end

    context 'when uniqueid is a symbol' do
      let(:uniqueid) { :foo }

      it_behaves_like :read
    end

    context 'when uniqueid is a string' do
      let(:uniqueid) { 'foo' }

      it_behaves_like :read
    end

    context 'when uniqueid is a number' do
      let(:uniqueid) { 4 }

      it_behaves_like :read
    end
  end
end
