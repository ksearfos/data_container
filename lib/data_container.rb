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
    str = "#<DataContainer"
    each_pair { |ivar, value| str << " #{ivar}=#{value.inspect}" }
    str << ">"
    str
  end

  def inspect
    to_s
  end

  alias :data :members
end
