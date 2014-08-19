class DataContainer < Struct
  def self.new(*args)
    super.new    # send back an INSTANCE, not a class
  end

  def get(ivar)
    send(ivar) if include?(ivar)
  end

  def set(ivar, value)
    send("#{ivar}=", value) if include?(ivar)
  end

  def to_s
    '@' + variable_value_pairs_string.join(', @')
  end

  def inspect
    '#<DataContainer: ' + variable_value_pairs_string.join(' ') + '>'
  end

  def merge!(other_data_container)
    other_data_container.each_pair do |var, val|
      set(var, val) unless val.nil?
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
end
