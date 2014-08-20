require 'spec_helper'

describe DataContainer do
  before(:all) do
    TestContainer = DataContainer.new(:apple, :banana)
  end

  describe '#initialize' do
    it 'creates instance variables for each of the array entries' do
      expect(TestContainer.data).to eq([:apple, :banana])
    end

    it 'sets each of those instance variables to nil' do
      expect(TestContainer.apple).to be_nil
      expect(TestContainer.banana).to be_nil
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
      it 'raises and exception' do
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
      container_string = '#<DataContainer: apple="yum!" banana="ick">'
      expect(TestContainer.to_s).to eq(container_string)
    end
  end

  describe '#inspect' do
    it 'shows the DataContainer class and its object ID' do
      container_inspection = /#<DataContainer:0x\d+/
      expect(TestContainer.inspect).to match container_inspection
    end
  end

  describe 'iterators' do
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

  describe '#merge' do
    before(:all) do
      Container1 = DataContainer.new(:var1, :var2)
      Container2 = DataContainer.new(:var1, :var2, :var3)
      Container1.populate_from_hash(var1: :pig, var2: :cow)
      Container2.populate_from_hash(var1: :chicken, var2: nil, var3: :hen)
      Container1.merge! Container2
    end

    it 'merges all shared data in the given DataContainer into self' do
      expect(Container1.var1).to eq(:chicken)
    end

    it 'ignores any nil shared values' do
      expect(Container1.var2).to eq(:cow)
    end

    it 'does not merge non-shared values' do
      expect(Container1).not_to include(:var3)
    end
  end

  describe '#include?' do
    it 'determines whether the given value is one of its data' do
      expect(TestContainer.include?(:apple)).to be_truthy
      expect(TestContainer.include?(:coconut)).to be_falsy
    end
  end

  describe "@defaults" do
    let(:defaults) do
      { apple: 'core', banana: 'peel', coconut: nil }
    end

    let(:test_container_defaults) { TestContainer.instance_variable_get(:@defaults) }

    context "when no defaults have been provided" do
      it "is nil for each attribute in the DataContainer" do
        expect(test_container_defaults).to eq({ apple: nil, banana: nil, coconut: nil })
      end
    end

    describe "#add_defaults" do
      it "sets default values according to the given hash" do
        TestContainer.add_defaults(defaults)
        expect(test_container_defaults).to eq(defaults)
      end
    end

    describe "#apply_defaults" do
      it "applies the default values, if any" do
        TestContainer.apply_defaults
        expect(TestContainer.to_h).to eq(defaults)
      end
    end
  end

  describe "#name" do
    it "is DataContainer" do
      expect(TestContainer.name).to eq('DataContainer')
    end

    context "when referenced in an error" do
      it "refers to the DataContainer by name" do
        expect do
          expect { TestContainer.goldfish }.to raise_exception
        end.to output(/DataContainer/).to stdout
      end
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
