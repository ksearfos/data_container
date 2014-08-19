class DataContainer
  extend Enumerable

  @ivars = []

  class << self
    if @ivars.is_a? Array then attr_accessor *@ivars
    elsif @ivars.is_a? Hash then attr_accessor *@ivars.keys
    else raise "Unable to create SettingsFairy class from a #{@ivars.class}"
    end

    def merge(other_settings, ignore_unknown = false)
      if ignore_unknown   # merge in ALL ivars/values in other_settings
        other_settings.each do |ivar, value|
          next if value.nil?
          self.set ivar, value
        end
      else     # merge in only those ivars/values that self shares
        self.each do |ivar, value|
          other_value = other_settings.get(ivar)
          next if other_value.nil?
          self.set ivar, other_value
        end
      end
    end

    def each(&block)
      @ivars.each do |ivar|
        value = get(ivar)
        block.arity? == 2 ? block.call(ivar, value) : block.call(value)
      end
    end

    def get(ivar)
      instance_variable_get("@#{ivar}")
    end

    def set(ivar, value)
      instance_variable_set("@#{ivar}", value)
    end
  end
end
