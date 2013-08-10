require 'spec_helper'

class Rails
  def self.cache
    Cache
  end
end
class Cache
  def self.increment(n,a=1,o={})
  end
end

describe BattleShip do
  describe ".read" do
    shared_examples_for :read do
      it "retrieves value from Rails.cache.read" do
        Cache.should_receive(:read).with("namespace_#{uniqueid}")

        BattleShip.read(:namespace, uniqueid)
      end

      it "returns value from Rails.cache.read" do
        Cache.stub(:read) { 'a value' }

        BattleShip.read(:foo, :bar).should eq 'a value'
      end

      it "increments namespace hit counter when value is non-nil" do
        Cache.stub(:read) { 'a value' }
        Cache.should_receive(:increment).with('foo_hit', 1, {})

        BattleShip.read(:foo, :bar)
      end

      it "increments namespace miss counter when value is nil" do
        Cache.stub(:read) { nil }
        Cache.should_receive(:increment).with('foo_miss', 1, {})

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

  describe ".write" do
    shared_examples_for :write do
      it "writes value to Rails.cache.write using given key" do
        Cache.should_receive(:write).with("namespace_#{uniqueid}", value, {})

        BattleShip.write(:namespace, uniqueid, value)
      end
    end

    context 'when uniqueid is a symbol' do
      let(:uniqueid) { :foo }
      let(:value) { :bar }

      it_behaves_like :write
    end

    context 'when uniqueid is a string' do
      let(:uniqueid) { 'foo' }
      let(:value) { 'bar' }

      it_behaves_like :write
    end

    context 'when uniqueid is a number' do
      let(:uniqueid) { 4 }
      let(:value) { 5 }

      it_behaves_like :write
    end
  end

  describe ".fetch" do
    # name, options = nil
    pending
    shared_examples_for :fetch do
    end
    context "when block given" do
      context "when value found" do
      end

      context "when value absent" do
      end
    end

    context "when block absent" do
      context "when value found" do
      end

      context "when value absent" do
      end
    end
  end

  describe ".cleanup" do
    # options = nil
    pending
  end

  describe ".clear" do
    # options = nil
    pending
  end

  describe ".decrement" do
    # name, amount = 1, options = nil
    pending
  end

  describe ".delete" do
    # name, options
    pending
  end

  describe ".delete_matched" do
    # matcher, options = nil
    pending
  end

  describe ".exist?" do
    # name, options = nil
    pending
  end

  describe ".increment" do
    # name, amount = 1, options = nil
    pending
  end

  describe ".mute" do
    pending
  end

  describe ".read_multi" do
    # *names - options is last
    pending
  end

  describe ".silence!" do
    pending
  end
end
