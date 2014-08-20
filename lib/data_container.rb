class DataContainer < Struct
  class AttributeError < StandardError; end

  def self.new(*args)
    super.new    # send back an INSTANCE, not a class
  end

  def get(ivar)
    send(ivar) if include?(ivar)
  end

  def set(ivar, value)
    if include?(ivar)
      send("#{ivar}=", value)
    else
      raise AttributeError, attribute_error_message(ivar)
    end
  end

  def to_s
    '#<DataContainer: ' + variable_value_pairs_string.join(' ') + '>'
  end

  def inspect
    "#<DataContainer:0x#{self.object_id}>"
  end

  def name
    'DataContainer'
  end

  def merge!(other_data_container)
    other_data_container.each_pair do |var, val|
      set(var, val) if include?(var) && !val.nil?
    end
  end

  def include?(var)
    data.include?(var.to_sym)
  end

  def populate_from_hash(hash)
    hash.each { |var, val| set(var, val) }
  end

  alias_method :data, :members

  private

  def variable_value_pairs_string
    each_pair.map { |ivar, value| "#{ivar}=#{value.inspect}" }
  end

  def attribute_error_message(attr)
    "undefined attribute '#{attr}' for #{inspect} with backtrace:"
  end
end
