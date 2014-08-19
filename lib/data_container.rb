class DataContainer < Struct
  def self.new(*args)
    super.new    # send back an INSTANCE, not a class
  end

  def get(ivar)
    send(ivar)
  end

  def set(ivar, value)
    send("#{ivar}=", value)
  end

  def to_s
    '@' + variable_value_pairs_string.join(', @')
  end

  def inspect
    '#<DataContainer: ' + variable_value_pairs_string.join(' ') + '>'
  end

  alias :data :members

  private

  def variable_value_pairs_string
    each_pair.map { |ivar, value| "#{ivar}=#{value.inspect}" }
  end
end
