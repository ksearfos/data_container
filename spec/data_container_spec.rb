require 'spec_helper'

describe DataContainer do
  before(:all) do
    TestContainer = DataContainer.new(:apple, :banana)
  end

  describe "#initialize" do
    it "creates instance variables for each of the array entries" do
      expect(TestContainer.data).to eq([:apple, :banana])
    end

    it "sets each of those instance variables to nil" do
      expect(TestContainer.apple).to be_nil
      expect(TestContainer.banana).to be_nil
    end
  end

  describe "#get" do
    before(:all) do
      TestContainer.apple = 'yum!'
      TestContainer.banana = 'ewwww :('
    end

    it "retrieves the value of the variable name given" do
      expect(TestContainer.get(:apple)).to eq('yum!')
    end
  end

  describe "#set" do
    it "sets the variable given to the value provided" do
      TestContainer.set(:banana, 'good with ice cream')
      expect(TestContainer.banana).to eq('good with ice cream')
    end
  end

  describe "#to_s" do
    it "shows all of the DataContainer's values" do
      TestContainer.banana = 'ick'
      container_string = '@apple="yum!", @banana="ick"'
      expect(TestContainer.to_s).to eq(container_string)
    end
  end

  describe "#inspect" do
    it "shows the DataContainer class and its values" do
      container_inspection = '#<DataContainer: apple="yum!" banana="ick">'
      expect(TestContainer.inspect).to eq(container_inspection)
    end
  end
end
