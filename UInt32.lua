UInt32 = {}
UInt32.__index = UInt32
UInt32.__name = "UInt32"
UInt32.mod = 4294967296
UInt32.max = 4294967295
UInt32.min = 0

--private functions
local function convert(integer)
    -- pass any integer, converts it to the approriate UInt32
    -- unsigned 32 bit integers range from 0 - 4,294,967,295
    -- 0000 0000 0000 0000 0000 0000 0000 0000 to 1111 1111 1111 1111 1111 1111 1111 1111
    -- 00000000 to FFFFFFFF

    integer = integer % UInt32.mod
    if integer < 0 then
        integer = UInt32.mod + integer
    end

    return math.floor(integer)
end

local function check_type(integer)
    -- check input value
    local i
    if type(integer) == "string" then
        i = tonumber(integer, 16)
        if i == nil then
            assert(false, "Error: Argument must be an integer, hexidecimal string, or UInt32.")
        end
    elseif type(integer) == "table" then
        if integer.__name == "UInt32" then
            i = integer.value
        else
            assert(false, "Error: Argument must be an integer, hexidecimal string, or UInt32.")
        end
    elseif type(integer) == "number" then
        if math.type(integer) == "integer" then
            i = integer
        elseif math.type(integer) == "float" then
            -- could be huge, nan, actual float, or just big int
            if integer == math.huge then
                i = UInt32.max
            elseif integer ~= integer then
                i = UInt32.min
            else
                if math.fmod(integer, 1) == 0 then
                    i = integer
                else
                    assert(false, "Error: Argument must be an integer, hexidecimal string, or UInt32.")
                end
            end
        else
            assert(false, "Error: Argument must be an integer, hexidecimal string, or UInt32.")
        end
    else
        assert(false, "Error: Argument must be an integer, hexidecimal string, or UInt32.")
    end

    return i
end

--overrides
function UInt32.to_string(u)
    assert(type(u) == "table", "Error: argument must be UInt32.")
    assert(u.__name == UInt32.__name, "Error: argument must be UInt32.")

    return tostring(u.value)
end
UInt32.__tostring = UInt32.to_string

function UInt32.add(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value + u2.value)
end
UInt32.__add = UInt32.add

function UInt32.subtract(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value - u2.value)
end
UInt32.__sub = UInt32.subtract

function UInt32.multiply(u1, u2)
    -- due to how lua handles big numbers and exponentiation, this will return incorrect results for large numbers
    -- to deal with this correctly would most likely require a new library
    -- see https://web.tecgraf.puc-rio.br/~lhf/ftp/lua/#lmapm
    -- https://rostrap.github.io/Libraries/Math/BigNum/

    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value * u2.value)
end
UInt32.__mul = UInt32.multiply

function UInt32.divide(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value // u2.value)
end
UInt32.__idiv = UInt32.divide

function UInt32.exponentiate(u1, u2)
    -- due to how lua handles big numbers and exponentiation, this will return incorrect results for large numbers
    -- to deal with this correctly would most likely require a new library
    -- see https://web.tecgraf.puc-rio.br/~lhf/ftp/lua/#lmapm
    -- https://rostrap.github.io/Libraries/Math/BigNum/

    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value ^ u2.value)
end
UInt32.__pow = UInt32.exponentiate

function UInt32.modulus(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value % u2.value)
end
UInt32.__mod = UInt32.modulus

function UInt32.equals(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return u1.value == u2.value
end
UInt32.__eq = UInt32.equals

function UInt32.less_than(u1, u2)
    --this works for all <, <=, >, >=
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return u1.value < u2.value
end
UInt32.__lt = UInt32.less_than

function UInt32.binary_and(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value & u2.value)
end
UInt32.__band = UInt32.binary_and

function UInt32.binary_or(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value | u2.value)
end
UInt32.__bor = UInt32.binary_or

function UInt32.binary_xor(u1, u2)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(type(u2) == "table", "Error: argument 2 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(u2.__name == UInt32.__name, "Error: argument 2 must be UInt32.")

    return UInt32:new(u1.value ~ u2.value)
end
UInt32.__bxor = UInt32.binary_xor

function UInt32.binary_not(u1)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")

    return UInt32:new(~ u1.value)
end
UInt32.__bnot = UInt32.binary_not

function UInt32.shift_left(u1, i1)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(math.type(i1) == "integer", "Error: argument 2 must be integer.")
    assert(i1 > 0 and i1 <= 32, "Error: argument 2 must be in the range 1 - 32.")

    return UInt32:new(u1.value << i1)
end
UInt32.__shl = UInt32.shift_left

function UInt32.shift_right(u1, i1)
    assert(type(u1) == "table", "Error: argument 1 must be UInt32.")
    assert(u1.__name == UInt32.__name, "Error: argument 1 must be UInt32.")
    assert(math.type(i1) == "integer", "Error: argument 2 must be integer.")
    assert(i1 > 0 and i1 <= 32, "Error: argument 2 must be in the range 1 - 32.")

    return UInt32:new(u1.value >> i1)
end
UInt32.__shr = UInt32.shift_right

--instance functions
function UInt32:new(integer)
    integer = check_type(integer)

    --table for new object    
    local new = {}

    --inherit from UInt32
    setmetatable(new, self)

    new.value = convert(integer)
    return new
end

function UInt32:integer()
    return self.value
end

function UInt32:hex()
    return string.format("%x", self.value)
end

