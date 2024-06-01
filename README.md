# Lua-UInt32
This is a library for working with Unsigned 32 Bit Integers in Lua 5.4, as well as one for LuaJIT.

## Usage
To use the file in a Lua 5.4 script, add the [UInt32.lua](UInt32.lua) file to the project directory and require it in the main Lua script:
```lua
require("UInt32")
```

Or, for LuaJIT, add the [UInt32-LuaJIT.lua](UInt32-LuaJIT.lua) file and require that:
```lua
require("UInt32-LuaJIT")
```

To create a new UInt32, call the UInt32 new function and pass an integer in. The passed integer can be an integer or a hexidecimal string. Any other value will throw an error. The number will be converted into an unsigned 32 bit integer. 
```lua
UInt32:new(integer)
```

Arithmetic, comparisons, and bitwise operations can then be done on the UInt32 objects. All operations require both UInt32 arguments except for shift left and shift right, which will accept an integer as the shift value.

To retrieve the value as a regular Lua number, use UInt32:integer(). To retrieve it as a hexidecimal string, use UInt32:hex().
