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
      it 'returns nil' do
        expect(TestContainer.get(:coconut)).to eq(nil)
      end
    end
  end

  describe '#set' do
    it 'sets the variable given to the value provided' do
      TestContainer.set(:banana, 'good with ice cream')
      expect(TestContainer.banana).to eq('good with ice cream')
    end

    context "when given a variable that doesn't exist" do
      it 'does not set anything' do
        TestContainer.set(:coconut, 'mmmmm')
        expect(TestContainer.data).not_to include :coconut
      end
    end
  end

  describe '#to_s' do
    it "shows all of the DataContainer's values" do
      TestContainer.banana = 'ick'
      container_string = '@apple="yum!", @banana="ick"'
      expect(TestContainer.to_s).to eq(container_string)
    end
  end

  describe '#inspect' do
    it 'shows the DataContainer class and its values' do
      container_inspection = '#<DataContainer: apple="yum!" banana="ick">'
      expect(TestContainer.inspect).to eq(container_inspection)
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
      Container1.var1 = :pig
      Container1.var2 = :cow
      Container2.var1 = :chicken
      Container2.var3 = :hen
      Container1.merge! Container2
    end

    it 'merges all shared data in the given DataContainer into self' do
      expect(Container1.var1).to eq(:chicken)
    end

    it 'ignores any nil shared values' do
      expect(Container1.var2).to eq(:cow)
    end

    it 'does not merge non-shared values' do
      expect(Container1.data).not_to include(:var3)
    end
  end

  describe '#include?' do
    it 'determines whether the given value is one of its data' do
      expect(TestContainer.include?(:apple)).to be_truthy
      expect(TestContainer.include?(:coconut)).to be_falsy
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
