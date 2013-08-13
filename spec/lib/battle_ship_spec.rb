require 'spec_helper'

class Rails
  def self.cache
    Cache
  end
end
class Cache
  def self.read(k)
  end
  def self.increment(k,a=1,o=nil)
  end
  def self.fetch(k,o=nil)
    if block_given?
      yield
    end
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
        Cache.should_receive(:increment).with('foo_hit', 1, nil)
        BattleShip.read(:foo, :bar)
      end

      it "increments namespace miss counter when value is nil" do
        Cache.stub(:read) { nil }
        Cache.should_receive(:increment).with('foo_miss', 1, nil)
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
        Cache.should_receive(:write).with("namespace_#{uniqueid}", value, nil)
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
    shared_examples_for :fetch do
      it "retrieves value from Rails.cache.fetch" do
        Cache.should_receive(:fetch)
        subject
      end

      it "returns value from Rails.cache.fetch" do
        Cache.stub(:fetch) { 'a value' }
        subject.should eq 'a value'
      end

      it "increments namespace hit counter when value is non-nil" do
        Cache.stub(:fetch) { 'a value' }
        Cache.stub(:read) { 'a value' }
        Cache.should_receive(:increment).with('foo_hit', 1, nil)
        subject
      end

      it "increments namespace miss counter when value is nil" do
        Cache.stub(:fetch) { nil }
        Cache.should_receive(:increment).with('foo_miss', 1, nil)
        subject
      end
    end
    context "when block given" do
      subject { described_class.fetch(:foo, :bar) { 'a different value' } }
      it_behaves_like :fetch

      context "when value absent" do
        it "should set the value" do
          subject
          subject.should eq 'a different value'
        end
      end
    end

    context "when block absent" do
      subject { described_class.fetch(:foo, :bar) }
      it_behaves_like :fetch
    end
  end

  describe ".cleanup" do
    let(:options) { { } }
    it "passes to underlying" do
      Cache.should_receive(:cleanup).with(options)
      BattleShip.cleanup(options)
    end

    it "does not require options" do
      Cache.should_receive(:cleanup).with(nil)
      BattleShip.cleanup
    end
  end

  describe ".clear" do
    let(:options) { { } }
    it "passes to underlying" do
      Cache.should_receive(:clear).with(options)
      BattleShip.clear(options)
    end

    it "does not require options" do
      Cache.should_receive(:clear).with(nil)
      BattleShip.clear
    end
  end

  describe ".decrement" do
    let(:options) { { } }
    let(:namespace) { 'name' }
    let(:uid) { '1' }
    let(:amount) { 2 }
    it "passes to underlying" do
      Cache.should_receive(:decrement).with('name_1', amount, options)
      BattleShip.decrement(namespace, uid, amount, options)
    end

    it "defaults amount to 1" do
      Cache.should_receive(:decrement).with('name_1', 3, options)
      BattleShip.decrement(namespace, uid, 3, options)
    end

    it "does not require options" do
      Cache.should_receive(:decrement).with('name_1', 1, nil)
      BattleShip.decrement(namespace, uid)
    end
  end

  describe ".delete" do
    let(:namespace) { 'name' }
    let(:uid) { 1 }
    let(:options) { { } }
    it "passes to underlying" do
      Cache.should_receive(:delete).with('name_1', options)
      BattleShip.delete(namespace, uid, options)
    end

    it "does not require options" do
      Cache.should_receive(:delete).with('name_1', nil)
      BattleShip.delete(namespace, uid)
    end
  end

  describe ".delete_matched" do
    let(:matcher) { 'something*' }
    let(:options) { { } }
    it "passes to underlying" do
      Cache.should_receive(:delete_matched).with(matcher, options)
      BattleShip.delete_matched(matcher, options)
    end

    it "does not require options" do
      Cache.should_receive(:delete_matched).with(matcher, nil)
      BattleShip.delete_matched(matcher)
    end
  end

  describe ".exist?" do
    let(:namespace) { 'name' }
    let(:uid) { 1 }
    let(:options) { { } }
    it "passes to underlying" do
      Cache.should_receive(:exist?).with('name_1', options)
      BattleShip.exist?(namespace, uid, options)
    end

    it "does not require options" do
      Cache.should_receive(:exist?).with('name_1', nil)
      BattleShip.exist?(namespace, uid)
    end
  end

  describe ".increment" do
    let(:options) { { } }
    let(:namespace) { 'name' }
    let(:uid) { '1' }
    let(:amount) { 2 }
    it "passes to underlying" do
      Cache.should_receive(:increment).with('name_1', amount, options)
      BattleShip.increment(namespace, uid, amount, options)
    end

    it "defaults amount to 1" do
      Cache.should_receive(:increment).with('name_1', 3, options)
      BattleShip.increment(namespace, uid, 3, options)
    end

    it "does not require options" do
      Cache.should_receive(:increment).with('name_1', 1, nil)
      BattleShip.increment(namespace, uid)
    end
  end

  describe ".mute" do
    it "passes to underlying" do
      Cache.should_receive(:mute)
      BattleShip.mute
    end
  end

  describe ".read_multi" do
    # *names - options is last
    let(:names) { ['1', '2', '3'] }
    it "passes to underlying" do
      Cache.should_receive(:read_multi).with(names)
      BattleShip.read_multi(names)
    end
  end

  describe ".silence!" do
    it "passes to underlying" do
      Cache.should_receive(:silence!)
      BattleShip.silence!
    end
  end
end
