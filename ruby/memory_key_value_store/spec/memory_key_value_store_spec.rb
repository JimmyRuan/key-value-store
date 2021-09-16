require 'rspec'
require_relative '../memory_key_value_store'

describe "MemoryKeyValueStore" do
  describe "#get" do
    context "with a matching key" do
      it "gets the value of key" do
        store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
        expect(store.get(:aaa)).to eq('red')
      end
    end

    context "without a matching key" do
      it "returns the special value nil" do
        store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
        expect(store.get(:ccc)).to eq(nil)
      end
    end

    context "with a non-string value" do
      it "returns an error" do
        store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
        expect{store.set(:ccc, :string)}.to raise_error(RuntimeError)
      end
    end
  end

  describe "#set" do
    context "when they key does not hold a value" do
        it  "sets the key to hold the string value" do
          store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
          store.set(:ccc, 'orange')
          expect(store.get(:ccc)).to eq 'orange'
        end

        it "returns the string 'OK'" do
          store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
          expect(store.set(:ccc, 'orange')).to eq 'OK'
        end
    end

    context "when they key already holds a value" do
      it  "sets the key to hold the string value" do
        store = MemoryKeyValueStore.new({ccc: 'orange', bbb: 'yellow'})
        store.set(:ccc, 'banana')
        expect(store.get(:ccc)).to eq 'banana'
      end

      it "returns the string 'OK'" do
        store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
        expect(store.set(:aaa, 'orange')).to eq 'OK'
      end
    end
  end

  describe "#keys" do
    context "when no regex pattern is passed" do
      it "returns all keys" do
        store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
        expect(store.keys).to eq [:aaa, :bbb]
      end
    end

    context "when a regex pattern is passed" do
      it "returns all keys matching regex pattern" do
        store = MemoryKeyValueStore.new({aaa: 'red', bbb: 'yellow'})
        expect(store.keys('aa')).to eq [:aaa]
      end
    end
  end
end
