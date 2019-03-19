-- learn lua in y minutes
--[[
    run this in a terminal:
        lua main.lua
]]

-- [[ VARIABLES ]]
globalVar = 2019
num = 42 -- every number is a 64bit-precision double

name = 'rui' -- strings are immutable
wall_of_text = [[lorem
                 ipsum
                 dolor
                 sit
                 amet ]] -- strings can span several lines
print(wall_of_text)

wall_of_text = nil -- wall_of_text can now be gc'ed

-- [[ CONTROL FLOW ]]
i = 0
while i < 5 do
    i = i + 1
end

do -- you can define blocks like this
    local name = 'miguel' -- this var is local to the block
    local age = 10
end
print(age) -- not defined here, prints 'nil'

if i == 0 then
    print("i hasn't changed...")
elseif name ~= 'rui' then
    print('the name has changed!')
else
    io.write('what\'s your name? ')
    local input = io.read()
end

for i = 1, 5 do i = i + 1; i = i + 1 end -- separate exprssions in the same line with ;
for j = 10, 1, -2 do --[[ nothing ]] end -- custom for step

repeat input = io.read() until input ~= 'functions' -- another control flow block


-- [[ FUNCTIONS ]]
function fizzBuzz(n)
    if n % 3 == 0 then
        print("fizz")
    elseif n % 5 == 0 then
        print("buzz")
    else
        print(n)
    end
end

function multiplier(mult) -- functions can return functions
    local multiply = function (x) return x * mult end -- functions can be assigned to variables
    return multiply
end
multiplyBy2 = multiplier(2)
multiplyBy2(10) -- returns 20

function sayHello(firstName, lastName)
    local text = 'Hello '
    if (lastName ~= nil) then -- you can omit arguments in a function
        text = text .. lastName .. ', ' .. firstName
    else
        text = text .. firstName -- this is how you concatenate strings
    end
    return text
end
sayHello('Fernando', 'Pessoa') -- returns 'Hello Fernando Pessoa'
sayHello 'Fernando' -- you can omit () if you have only one string argument


-- [[ TABLES ]]
person = { name = 'Fernando', lastName = 'Pessoa', dob = '13/06/1888'} -- creating a table
person.birthPlace = 'Lisbon' -- adding a new key+value
person['birthPlace'] = nil -- removing an entry
city = person.birthPlace -- accessing a value

heteronym = { name = 'Fernando', lastName = 'Pessoa', dob = '13/06/1888'}
print(person == heteronym and 'same object' or 'not same object') -- object comparison with ternary operator, prints 'not same object'

printName = function (person) print(person.name) end
printName {name = 'Afonso Henriques' } -- you can omit () if you have a single table as an argument

_G['printName'] = nil -- _G is a table that contains all global vars
--printName { name = 'Afonso Henriques' } -- this will cause a runtime crash (printName is not defined)

array = { 'a', 'b', 'c', 'd', 'e', 'f' } -- keys are implicit indices when omitted (so you get an array-like behaviour)
local letter = array[3] -- leter == 'c'


breadFlour = { weight = 10 }
wholewheatFlour = { weight = 5.2 }

-- you can overload operators for tables by first defining a meta table
metaFlour = {}
function metaFlour.__add(flour1, flour2) -- overloading the '+' operator (this is called a metamethod)
    return flour1.weight + flour2.weight
end

setmetatable(breadFlour, metaFlour) -- set the meta table
setmetatable(wholewheatFlour, metaFlour)
local total = breadFlour + wholewheatFlour
local totalMetatable = getmetatable(total) -- 'total' does NOT inherit the meta table from the other tables so this is 'nil'

local ryeFlour = {}
setmetatable(ryeFlour, { __index = { weight = 0 }}) -- __index is the lookup/access operator
print(ryeFlour.weight) -- prints 0 (even though we didn't initially define it)

--[[ CLASSES ]]

Cat = {}
function Cat:new()
    cat = { speak = (function () print 'meow!' end) }
    self.__index = self -- this makes lookups work, by having the lookup operator look into the instance
    return setmetatable(cat, self)
end

function Cat:jump()
    print '*jumps*'
end

gato = Cat:new()
gato.name = 'Pirata'
print(gato.name)
gato:jump() -- if we didn't do "self.__index = self" above, this wouldn't work
gato:speak()

CrazyCat = Cat:new()
function CrazyCat:jump()
    print '*jumps crazy high*'
end

francisca = CrazyCat:new()
francisca:jump()
