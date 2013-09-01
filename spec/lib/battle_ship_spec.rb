require 'spec_helper'

# For tests of #read_entry, see spec/lib/active_support_cache_subclass_spec.rb
describe BattleShip do
  let(:dummy) { Class.new { prepend(BattleShip) }.new }

  describe "#namespace" do
    subject { dummy.send(:namespace, key, options) }
    context "when options includes namespace" do
      let(:key) { 'Key' }
      let(:options) { { namespace: 'NameSpace' } }
      it "returns the option's namespace" do
        subject.should eq 'NameSpace'
      end
    end

    context "when options does not include namespace" do
      let(:key) { 'Key_Thing_123' }
      let(:options) { { } }
      it "returns the string preceding the first underscore" do
        subject.should eq 'Key'
      end
    end
  end

  describe "#key_up_to_first_underscore" do
    it "returns the string up to the first underscore" do
      dummy.send(:key_up_to_first_underscore, 'someclass_thing').should eq 'someclass'
    end
  end
end
