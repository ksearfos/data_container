# uses subject (the data container) and dc_class (the data container class)
shared_examples 'DataContainer' do
  describe '#initialize' do
    context "when given a list of symbols/strings" do
      it 'creates attributes for each of the array entries' do
        expect(subject.data).to eq([:apple, :banana])
      end

      it 'sets each of those attributes to nil' do
        expect(subject.apple).to be_nil
        expect(subject.banana).to be_nil
      end
    end

    context "when given a hash" do
      let(:hash_container) { dc_class.new(apple: 'delish', banana: 'ewww') }

      it 'creates attributes from each of the hash keys' do
        expect(hash_container.data).to eq([:apple, :banana])
      end

      it 'sets each of those attributes to the corresponding hash value' do
        expect(hash_container.apple).to eq('delish')
        expect(hash_container.banana).to eq('ewww')
      end
    end

    context "when given anything other than a hash or a list of symbols/strings" do
      it "raises an exception" do
        expect { dc_class.new(12345) }.to raise_exception
        expect { dc_class.new(['a', 'b', 'c']) }.to raise_exception
      end
    end
  end

  describe '#get' do
    before(:each) do
      subject.apple = 'yum!'
      subject.banana = 'ewwww :('
    end

    it 'retrieves the value of the variable name given' do
      expect(subject.get(:apple)).to eq('yum!')
    end

    context "when given a variable that doesn't exist" do
      it 'raises an exception' do
        expect { subject.get(:coconut) }.to raise_exception(DataContainer::AttributeError)
      end
    end
  end

  describe '#set' do
    it 'sets the variable given to the value provided' do
      subject.set(:banana, 'good with ice cream')
      expect(subject.banana).to eq('good with ice cream')
    end

    context "when given a variable that doesn't exist" do
      it 'raises an exception' do
        expect { subject.set(:coconut, 'mmmmm') }.to raise_exception(DataContainer::AttributeError)
      end
    end
  end

  describe '#to_s' do
    it "shows the DataContainer class and its values" do
      subject.banana = 'ick'
      container_string = /DataContainer.*apple="yum!".*banana="ick"/
      expect(subject.to_s).to match container_string
    end
  end

  describe '#inspect' do
    it 'shows the DataContainer class and its values' do
      container_inspection = /DataContainer.*apple="yum!".*banana="ick"/
      expect(subject.inspect).to match container_inspection
    end
  end

  describe 'iterators' do   # inherited as part of Struct, but I wanted to make sure they worked as anticipated
    describe '#each' do
      it 'iterates through each value' do
        str = ''
        subject.each { |value| str << value + ' ' }
        expect(str).to eq('yum! ick ')
      end
    end

    describe '#each_pair' do
      it 'iterates through each variable and its value' do
        str = ''
        subject.each_pair { |ivar, value| str << "#{ivar.upcase}:#{value}**" }
        expect(str).to eq('APPLE:yum!**BANANA:ick**')
      end
    end
  end

  describe '#include?' do
    it 'determines whether the given value is one of its data' do
      expect(subject.include?(:apple)).to be_truthy
      expect(subject.include?(:coconut)).to be_falsy
    end
  end

  describe "#name" do
    it "is DataContainer" do
      expect(subject.name).to eq('DataContainer')
    end
  end

  describe '#populate_from_hash' do
    it 'sets the data values according to the values in the hash' do
      new_vals = { apple: 'core', banana: 'peel' }
      subject.populate_from_hash(new_vals)
      expect(subject.apple).to eq('core')
      expect(subject.banana).to eq('peel')
    end

    context 'when given one or more hash keys that are not in the DataContainer' do
      it 'raises an exception' do
        expect { subject.populate_from_hash(apple: 'brown betty', eel: 'slimy') }.to raise_exception
      end
    end
  end
end
