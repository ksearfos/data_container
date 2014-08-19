class DataContainer < Struct
  def self.new(*args)
    new_class = super
    @instance = new_class.new
    p "created instance: #{@instance}"
    @instance
  end

  def get(ivar)
    send(ivar)
  end

  def set(ivar, value)
    send("#{ivar}=", value)
  end

  def to_s
    "#<#{self}: #{variable_value_pairs_string}>"
  end

  def inspect
    "#<DataContainer#<#{self} #{variable_value_pairs_string}>>"
  end

  alias :data :members

  private

  def variable_value_pairs_string
    str = ""
    each_pair { |ivar, value| str << " #{ivar}=#{value.inspect}" }
    str
  end
end
