require 'spec_helper'

describe AccessControlledDataContainer do
  before(:all) do
    @cl = AccessControlledDataContainer
    @container = @cl.new(:apple, :banana)
  end

  it_behaves_like 'DataContainer' do
    subject { @container }
    let(:dc_class) { @cl }
  end

  describe '#lock' do
    it 'locks the specified attribute from further editing' do
      @container.lock(:apple)
      expect { @container.apple='juice' }.to raise_exception
    end

    it "still allows access to the attribute's value" do
      expect(@container.apple).to eq('brown betty')
    end

    it 'also does not allow editing with set' do
      expect { @container.set(:apple, 'juice') }.to raise_exception
    end
  end

  describe '#unlock' do
    it 'releases the lock on the specified attribute, allowing editing' do
      @container.lock(:apple)    # for tests run in isolation
      @container.unlock(:apple)
      expect { @container.apple='juice' }.not_to raise_exception
    end
  end
end
