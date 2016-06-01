-- single line comment

--[[
    multi-line
    comment
--]]

-- *******************
-- *** VARS & FLOW ***
print '\n\n*** VARS & FLOW ***'

num = 42 -- every number is a 64bit-precision double

print '\n___ declaring variables'
name = 'rui' -- strings are immutable
wall_of_text = [[   lorem
                    ipsum
                    dolor
                    sit
                    amet ]] -- strings that span through several lines...

print(name)
print(wall_of_text)

wall_of_text = nil -- wall_of_text can now be gc'ed

print '\n___ flow control and scope'
i = 0
while i < 5 do
    print(i)
    i = i + 1
end

do -- you can define blocks like this
    local i = 0 -- this var is local to the block
    local age = 10
    name = 'miguel'
end

print('printing a var out of current scope: ' .. tostring(age)) -- not defined here, should print nil

if i == 0 then
    print("i hasn't changed...")
elseif name ~= 'rui' then -- not equals
    print('the name has changed!')
    bool = true -- bool is declared as a global
else
    io.write('dang it... what\'s the name, then? ')
    input = io.read() -- this is global too!
end

if bool then
    print(input) -- it's nil at this point
elseif not bool then
    print("REDUNDANCY!")
end

count = 0
repeat
    io.write(count .. ' please type \'takecare\': ')
    input, count = io.read(), count + 1 -- multiple assignment!
until input == 'takecare'


-- *****************
-- *** FUNCTIONS ***
print '\n\n*** FUNCTIONS ***'

function fizzBuzz(n)
    if n % 5 == 0 and n % 3 == 0 then -- you can improve this ;)
        print("fizzbuzz")
    elseif n % 3 == 0 then
        print("fizz")
    elseif n % 5 == 0 then
        print("buzz")
    else
        print(n)
    end
end

-- if not bool then 
--     for i=1,100 do fizzBuzz(i) end
-- end

function startFrom(y)
    local f = function (x) return x + y end -- anonymous function, remembers value of 'y'
    return f
end

print '___ anonymous functions'
addToAHundred = startFrom(100)
print(addToAHundred(10))

addToAThousand = startFrom(1000)
print(addToAThousand(50))

local x, y, z = -200, 400 -- z is nil!
print(addToAHundred(x,400)) -- 400 is discarded 'cause addToAHundred takes only 1 argument

function call(f, times) -- passing a function as an argument
    for k = 1, times do f() end
end

function dumb()
    print('dumb')
end

call(dumb,5)

-- can  you guess the outcome?
local g = function (x) print(x); return function (y) print(y); return y + x end end
local v = g(10)(15)
io.write('and the value is... ' .. v)


-- **************
-- *** TABLES ***
-- lua's only data structure, it's essentially a map
print '\n\n*** TABLES ***'

print '___ declaring tables, the only data structure lua has!'
table = { name = 'rui', age = 42 } -- the keys are like strings
age = table['age']
print(table.name .. ' is ' .. age .. ' years old')

person = { name = 'nando', age = '23', height = 180 }
person.weight = 73 -- adds a new entry to the table
person.height = nil -- removes an entry from the table

print '___ using tables as arrays'
pets = { 'cat', 'dog', 'fish', 'snake' } -- tables with no defined keys work like arrays
print(pets[1]) -- 'array' indexes start at 1
pets[-1] = 'tardigrad' -- and given that they're tables, they can have negative indexes
pets[100] = 't-rex' -- and holes!

print '___ there are different ways to access a table\'s values'
table = { key = 'value' }
aKey = 'key'
anotherKey = 'k' .. 'e' .. 'y'
print(table[aKey] .. ' ' .. table[anotherKey])


table = {['+'] = "plus", ['-'] = "minus", ['='] = "equals", [{}] = "empty"}
if table[{}] then -- this {} is a different object from the one in the table, it's a new one! given it's the table ctor
    print("found!")
else
    print("not found!")
end

function printTable(table)
    for key, value in pairs(table) do -- pairs() is really handy
        print(key, value)
    end    
end

function printArray(array)
    for i = 1, #array do
        print(array[i])
    end    
end

function anotherPrintList( ... )
    for i, v in ipairs(list) do
        print(i .. ' ' .. v)
    end
end

printTable(_G.pets) -- _G is a table that contains all globals
--printList(pets) -- won't work 'cause this list has holes
--anotherPrintList(pets) -- won't work 'cause this list has holes


-- *******************
-- *** MORE TABLES ***
print '\n\n*** MORE TABLES ***'

-- we'll be defining Point as an object
Point = {x=0, y=0}

--[[ important at this point:
 as there are no classes in lua, it's approach to OO is based
 on prototype-style declarations ]]--

-- we've declared Point and we'lbe be using it as a prototype

print('___ adding functions to objects')
function Point.scale(point, factor) -- adds/defines 'scale' function/method
    local newPoint = {}
    newPoint.x = point.x * factor
    newPoint.y = point.y * factor
    return newPoint
end
-- this aint' good though, as we're returning a new point every time...

myPoint = {x=10, y=10, scale = Point.scale}
myPoint.scale(myPoint, 2) -- what are myPoint's values at this point?

function Point.print(self)
    print('(' .. self.x .. ', ' .. self.y .. ')')
end

-- myPoint.print(myPoint) -- this won't work 'cause print() is not defined for myPoint
myPoint.print = Point.print
myPoint.print(myPoint)

function Point.scale(point, factor) -- adds/defines 'scale' function/method
    point.x = point.x * factor
    point.y = point.y * factor
    return point
end

myPoint.scale = Point.scale
myPoint.print(myPoint.scale(myPoint, 3.5)) -- this syntax... ugh... surely we can improve this
local scaledPoint = myPoint:scale(2)
print('scaled again: ' .. scaledPoint.x .. ', ' .. scaledPoint.y) -- there we go!

samePointButScaledAgain = myPoint:scale(2):print()


-- ******************
-- *** METATABLES ***
print '\n\n*** METATABLES ***'

function Point.__add(a,b) -- will override the + operand
    local p = {}
    p.x = a.x + b.x
    p.y = a.y + b.y
    return p
end

function Point.__len() -- overrides the # operator on the Point table
    return 42
end

pA, pB = {x=2,y=3}, {x=4,y=2}

setmetatable(pA, Point)
setmetatable(pB, Point)

print("metatable of a point: ")
printTable(getmetatable(pA))

pC = pA + pB -- + will call __add from pA's metatable

print('the length of A is ' .. #pA)

Point.__index = { name = 'Point'} -- "default" indexes for the table that is Point
print('name is... ' .. pA.name) -- remember, pA's metatable is Point's metatable

Point.__concat = Point.__add -- you can assign functions here too!
print('pA.x + pB.x = ' .. (pA .. pB).x)

-- values of a metatable's indexes are called metamethods
-- __concat is a metatable index in Point's metatable, which value we set to Point.__add

--[[
k = getmetatable(pA)['__scale'](pA,3)
print("applying 'scale' function on a point: ")
printTable(k)

pC = pA + pB
-- printTable(pC)

-- pX = pC.scale(pC,3)

print(#pA)
--]]
