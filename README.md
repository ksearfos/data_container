DataContainer
----------
A container for data that is global to a project.  The DataContainer is an alternative to globals and passing configuration details between classes.

### Use

A DataContainer is very similar to a Struct object, except that it returns an instance rather than a class.  Much like a struct, you pass in the attributes you want your DataContainer to have and you will get back an object with setters and getters for each of those.  By default, all attributes are nil.

**Example**
```
MyContainer = DataContainer.new(:apple, :banana, :coconut)

MyContainer.apple     #==> nil

MyContainer.banana = "don't slip on the peel"
MyContainer.banana   `#==> don't slip on the peel!
```

### Setting multiple values at once

In addition to the standard struct-type options, a DataContainer can take a hash to set its data, either at initialization or later.  The hash's keys should be the attributes you want to set, and the values their values.

If the hash is passed in at initialization, then the DataContainer will have an attribute for each key, and no more.

**Example**
```
ValuedContainer = DataContainer.new(car: 'Honda Accord', age: 33, location: 'Ohio')
puts ValuedContainer
#==> #<DataContainer car='Honda Accord', age=33, location='Ohio'>
```

If the DataContainer has already been initialized, then the hash keys must correspond to existing attributes, or else an exception will be raised.  Any attributes that do not have a corresponding key in the hash will retain their current values.

N.B. This will overwrite existing values!

**Example**
```
puts MyContainer
#==> #<DataContainer apple=nil, banana="don't slip on the peel!", cucumber=nil>

MyContainer.populate_from_hash(apple: "my favorite!", banana: "yummy with ice cream")
puts MyContainer
#==> #<apple="my favorite!", banana="yummy with ice cream", cucumber=nil>

MyContainer.populate_from_hash(apple: 'mmmm', grapefruit: 'too sour!')
#==> DataContainer::AttributeError undefined attribute 'grapefruit'
```

### Iteration

Anyone familiar with the struct class already knows it has iteration built in.  The DataContainer has the same things available: `each` will iterate over each value, and `each_pair` will iterate through each attribute-value pair.

**Example**
```
MyContainer.each { |value| puts value }
#===> "my favorite!"
"yummy with ice cream"


MyContainer.each_pair { |var, val| puts "#{var.upcase}: #{val}" }
#==> APPLE: "my favorite!"
BANANA: "yummy with ice cream"
COCONUT:
```

### Dynamic Setters and Getters

Since structs don't actually have instance variables, DataContainers don't, either. Instead of forcing people to use `send` any time they want to set/retrieve an attribute by name, the DataContainer comes equipped with the `get` and `set` methods.

N.B. Both of these methods simply ignore attributes that do not exist for the DataContainer

**Example**
```
var = :apple
MyContainer.get(var)      #==> "best in autumn"

var = :grapefruit
MyContainer.get(var)      #==> nil

var = :coconut
MyContainer.set(var, "ALLERGIC!")     #==> @coconut="ALLERGIC!"

var = :grapefruit
MyContainer.set(var, "ALLERGIC!")     #==> nil
```
