require 'spec_helper'

describe DataContainer do
  before(:all) do
    TestContainer = DataContainer.new(:apple, :banana)
  end

  describe '#initialize' do
    context "when given a list of symbols/strings" do
      it 'creates attributes for each of the array entries' do
        expect(TestContainer.data).to eq([:apple, :banana])
      end

      it 'sets each of those attributes to nil' do
        expect(TestContainer.apple).to be_nil
        expect(TestContainer.banana).to be_nil
      end
    end

    context "when given a hash" do
      before(:all) { HashContainer = DataContainer.new(apple: 'delish', banana: 'ewww') }

      it 'creates attributes from each of the hash keys' do
        expect(HashContainer.data).to eq([:apple, :banana])
      end

      it 'sets each of those attributes to the corresponding hash value' do
        expect(HashContainer.apple).to eq('delish')
        expect(HashContainer.banana).to eq('ewww')
      end
    end

    context "when given anything other than a hash or a list of symbols/strings" do
      it "raises an exception" do
        expect { DataContainer.new(12345) }.to raise_exception
        expect { DataContainer.new(['a', 'b', 'c']) }.to raise_exception
      end
    end
  end

  describe '#get' do
    before(:all) do
      TestContainer.apple = 'yum!'
      TestContainer.banana = 'ewwww :('
    end

    it 'retrieves the value of the variable name given' do
      expect(TestContainer.get(:apple)).to eq('yum!')
    end

    context "when given a variable that doesn't exist" do
      it 'raises an exception' do
        expect { TestContainer.get(:coconut) }.to raise_exception(DataContainer::AttributeError)
      end
    end
  end

  describe '#set' do
    it 'sets the variable given to the value provided' do
      TestContainer.set(:banana, 'good with ice cream')
      expect(TestContainer.banana).to eq('good with ice cream')
    end

    context "when given a variable that doesn't exist" do
      it 'raises an exception' do
        expect { TestContainer.set(:coconut, 'mmmmm') }.to raise_exception(DataContainer::AttributeError)
      end
    end
  end

  describe '#to_s' do
    it "shows the DataContainer class and its values" do
      TestContainer.banana = 'ick'
      container_string = /DataContainer.*apple="yum!".*banana="ick"/
      expect(TestContainer.to_s).to match container_string
    end
  end

  describe '#inspect' do
    it 'shows the DataContainer class and its values' do
      container_inspection = /DataContainer.*apple="yum!".*banana="ick"/
      expect(TestContainer.inspect).to match container_inspection
    end
  end

  describe 'iterators' do   # inherited as part of Struct, but I wanted to make sure they worked as anticipated
    describe '#each' do
      it 'iterates through each value' do
        str = ''
        TestContainer.each { |value| str << value + ' ' }
        expect(str).to eq('yum! ick ')
      end
    end

    describe '#each_pair' do
      it 'iterates through each variable and its value' do
        str = ''
        TestContainer.each_pair { |ivar, value| str << "#{ivar.upcase}:#{value}**" }
        expect(str).to eq('APPLE:yum!**BANANA:ick**')
      end
    end
  end

  describe '#include?' do
    it 'determines whether the given value is one of its data' do
      expect(TestContainer.include?(:apple)).to be_truthy
      expect(TestContainer.include?(:coconut)).to be_falsy
    end
  end

  describe "#name" do
    it "is DataContainer" do
      expect(TestContainer.name).to eq('DataContainer')
    end
  end

  describe '#populate_from_hash' do
    it 'sets the data values according to the values in the hash' do
      new_vals = { apple: 'core', banana: 'peel' }
      TestContainer.populate_from_hash(new_vals)
      expect(TestContainer.apple).to eq('core')
      expect(TestContainer.banana).to eq('peel')
    end
  end
end
