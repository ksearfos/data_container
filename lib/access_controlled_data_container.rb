require_relative 'data_container'

class AccessControlledDataContainer
  def initialize(*args)
    @data = DataContainer.new(*args)
    @locked = Hash.new { |hash,attr| hash[attr] = false }
  end

  def name
    'AccessControlledDataContainer'
  end

  def to_s
    @data.to_s.gsub!('DataContainer', name)
  end

  def lock(*attrs)
    attrs.each { |attr| @locked[attr] = true }
  end

  def unlock(*attrs)
    attrs.each { |attr| @locked[attr] = false }
  end

  def method_missing(sym, *args, &block)
    raise_error_if_setting_locked_attribute(sym, *args)
    @data.send(sym, *args, &block)
  end

  private

  def raise_error_if_setting_locked_attribute(method, *args)
    if method =~ /=$/     # attribute setting method, or []=
      check_accessibility(method.to_s.chop)
    elsif method == :set
      check_accessibility(args.first)
    end
  end

  def editing_method?(sym)
    sym == :set || sym =~ /=$/     # attribute setting method, or []=
  end

  def locked?(attr)
    @locked[attr.to_sym] == true   # since default is false, nil is also ok
  end

  def raise_locked_attribute_error(attr)
    raise DataContainer::AccessError, "cannot modify locked attribute '#{attr}'"
  end

  def check_accessibility(attr)
    raise_locked_attribute_error(attr) if locked?(attr)
  end
end
