require_relative 'data_container'

class AccessControlledDataContainer
  def initialize(*args)
    @data = DataContainer.new(*args)
    @locked = Hash.new { |hash,attr| hash[attr] = false }
  end

  def lock(*attrs)
    attrs.each { |attr| @locked[attr] = true }
  end

  def unlock(*attrs)
    attrs.each { |attr| @locked[attr] = false }
  end

  def method_missing(sym, *args, &block)
    if sym =~ /^(.*)=$/   # attribute setting method, or []=
      raise_locked_attribute_error if locked?($1)
    elsif sym == :set
      raise_locked_attribute_error if locked?(args.first)
    else
      @data.send(sym, *args, &block)
    end
  end

  private

  def editing_method?(sym)
    sym == :set || sym =~ /=$/   # attribute setting method, or []=
  end

  def locked?(attr)
    @locked[attr.to_sym]
  end
end
