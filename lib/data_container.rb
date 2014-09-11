class DataContainer < Struct
  class AttributeError < StandardError; end

  def self.new(*args)
    if args.size == 1 && args.first.is_a?(Hash)    # actually given a hash, not an array of values
      new_class = super(*args.first.keys)
      new_class.new(*args.first.values)
    else
      new_class = super(*args)   # Struct constructor
      new_class.new              # send back an INSTANCE, not a class
    end
  end

  def initialize(*args)
    super    # Instance of Struct/new class constructor
  end

  def get(ivar)
    do_if_included(ivar) { send(ivar) }
  end

  def set(ivar, value)
    do_if_included(ivar) { send("#{ivar}=", value) }
  end

  def to_s
    "#<#{name} " + variable_value_pairs_string.join(', ') + '>'
  end
  alias_method :inspect, :to_s

  def name
    'DataContainer'
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

  def do_if_included(ivar)
    include?(ivar) ? yield(ivar) : raise(AttributeError, attribute_error_message(ivar))
  end
end
