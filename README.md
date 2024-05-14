This is a library for working with Unsigned 32 Bit Integers in Lua. 

To use the file in a Lua script, add the [UInt32.lua](UInt32.lua) file to the project directory and require it in the main Lua script:
```
require("UInt32")
```

To create a new UInt32, call the UInt32 new function and pass an integer in. The passed integer can be an integer or a hexidecimal string. Any other value will throw an error. The number will be converted into an unsigned 32 bit integer. 
```
UInt32:new(integer)
```

Arithmetic, comparisons, and bitwise operations can then be done on the UInt32 objects. All operations require both UInt32 arguments except for shift left and shift right, which will accept an integer as the shift value.

To retrieve the value as a regular Lua number, use UInt32:integer(). To retrieve it as a hexidecimal string, use UInt32:hex().
