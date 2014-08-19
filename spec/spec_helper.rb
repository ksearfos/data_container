require 'rspec'
require 'data_container'

RSpec.configure do |config|
  config.fail_fast = true
  config.color = :enabled
  config.tty = true
  config.formatter = :documentation
end
