require 'spec_helper'

describe DataContainer do
  before(:all) do
    @child = class TestContainer < DataContainer
      @data = [:apple, :banana]
      class << self; attr_reader :data; end
    end
  end

  it "contains a list of data" do
    expect(@child.data).to eq([:apple, :banana])
  end
end
