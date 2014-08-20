require 'rspec'
require 'data_container'

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
