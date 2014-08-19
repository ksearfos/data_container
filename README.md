DataContainer
----------
## A container for data that is global to the project

## Use

A DataContainer acts very similar to a Struct object, except that it returns an instance rather than a class.  Much like a struct, you pass in the attributes you want your DataContainer to have and you will get back an object with setters and getters for each of those.  By default, all attributes are nil.

### Example
```
MyContainer = DataContainer.new(:apple, :banana, :coconut)

MyContainer.apple     #==> nil
MyContainer.banana = "don't slip on the peel"
MyContainer.banana   `#==> don't slip on the peel!
```

## Setting multiple values at once

In addition to the standard struct-type options, a DataContainer can take a hash to set its data.  The hash's keys should be the attributes you want to set, and the values their values.  Any keys that are _not_ attributes of your DataContainer will simply be ignored.  Any attributes that do not have a corresponding key in the hash will retain their current values.

N.B. This will overwrite existing values!

### Example
```
puts MyContainer          #==> @apple=nil, @banana="don't slip on the peel!", @cucumber=nil
MyContainer.populate_from_hash(apple: "my favorite!", banana: "yummy with ice cream", grapefruit: 'sour :X')
puts MyContainer          #==> @apple="my favorite!", @banana="yummy with ice cream", @cucumber=nil
```

## Iteration

Anyone familiar with the struct class already knows it has iteration built in.  The DataContainer has the same things available: `each` will iterate over each value, and `each_pair` will iterate through each attribute-value pair.

### Example
```
MyContainer.each { |value| puts value }
#===>
"my favorite!"
"yummy with ice cream"


MyContainer.each_pair { |var, val| puts "#{var.upcase}: #{val}" }
#==>
APPLE: "my favorite!"
BANANA: "yummy with ice cream"
COCONUT:
```

## Merging

DataContainers can also be merged as a way to copy over shared values. This does not work quite the way a Hash#merge! does; only attributes that both DataContainers share will be copied.  Additionally, nil values in the merging DataContainer will be ignored, so as not to overwrite existing values.

### Example
```
OtherContainer = DataContainer.new(:apple, :banana, :grapefruit)
OtherContainer.apple = 'best in autumn'

puts OtherContainer       #==> @apple="best in autumn", @banana=nil, @grapefruit=nil
puts MyContainer          #==> @apple="my favorite!, @banana="yummy with ice cream", @coconut=nil

MyContainer.merge!(OtherContainer)
puts MyContainer          #==> @apple="best in autumn", @banana="yummy with ice cream", @coconut=nil
```

## Dynamic Setters and Getters

Since structs don't actually have instance variables, DataContainers don't, either. Instead of forcing people to use send() any time they want to set/retrieve an attribute by name, the DataContainer comes equipped with the get() and set() methods.

N.B. Both of these methods simply ignore attributes that do not exist for the DataContainer

### Example
```
var = :apple
MyContainer.get(var)      #==> "best in autumn"
var = :grapefruit
MyContainer.get(var)      #==> nil

var = :coconut
MyContainer.set(var, "ALLERGIC!")     #==> @coconut="ALLERGIC!"
var = :grapefruit
MyContainer.set(var, "ALLERGIC!")     #==> nil
