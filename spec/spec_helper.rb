require 'rspec'
require 'access_controlled_data_container'
require 'shared_examples'

RSpec.configure do |config|
  config.fail_fast = true
  config.color = :enabled
  config.tty = true
  config.formatter = :documentation
end

class DataContainer
  def data_with_values
    hash = {}
    each_pair { |var, val| hash[var] = val }
  end
end
