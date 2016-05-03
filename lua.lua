-- single line comment

--[[
    multi-line
    comment
--]]

-- *******************
-- *** VARS & FLOW ***
print '\n\n*** VARS & FLOW ***'

num = 42 -- every number is a 64bit-precision double

name = 'rui' -- strings are immutable
wall_of_text = [[   lorem
                    ipsum
                    dolor
                    sit
                    amet ]] -- strings that span through several lines...

print(name)
print(wall_of_text)

wall_of_text = nil -- wall_of_text can now be gc'ed

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

print(age) -- not defined here...

if i == 0 then
    print("i hasn't changed...")
elseif name ~= 'rui' then -- not equals
    print('the name has changed!')
    bool = true -- bool is declared as a global
else
    io.write('dang it... what\'s the name, then? ')
    input = io.read() -- this is global!
end

if bool then
    print(input)
elseif not bool then
    print("REDUNDANCY!")
end

for i = 1, 5 do print(i); i = i + 1 end
for j = 10, 1, -2 do print(j) end -- 'j' is local to the for loop

repeat input = io.read() until input ~= 'functions'


-- *****************
-- *** FUNCTIONS ***
print '\n\n*** FUNCTIONS ***'

function fizzBuzz(n)
    if n % 5 == 0 and n % 3 == 0 then
        print("fizzbuzz") -- no str concatenation yet! :P
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

function startFrom(y) -- anonymous function! remembers value of 'y'
    local f = function (x) return x + y end
    return f
end

addToAHundred = startFrom(100)
print(addToAHundred(10))
addToAThousand = startFrom(1000)
print(addToAThousand(50))

local x, y, z = -200, 400 -- z is nil!
print(addToAHundred(x,400)) -- 400 is discarded!

function call(f, times)
    for k = 1, times do f() end
end

function dumb()
    print('dumb')
end

call(dumb,5)

local g = function (x) print(x); return function (y) print(y); return math.sin(y) * math.cos(x) end end
local v = g(10)(10)
print(v)


-- **************
-- *** TABLES ***
-- lua's only data structure, it's essentially a map
print '\n\n*** TABLES ***'

table = { name = 'rui', age = 42 } -- the keys are like strings
age = table['age']
print(table.name .. ' is ' .. age .. ' years old')

person = { name = 'nando', age = '23', height = 180 }
person.weight = 73 -- adds a new entry to the table
person.height = nil -- removes an entry from the table

pets = { 'cat', 'dog', 'fish', 'snake' } -- tables with no defined keys work like arrays
weights = { 42.3, 74, 68.7 }
print(pets[1]) -- 'array' indexes start at 1
pets[-1] = 'tardigrad' -- and given that they're tables, they can have negative indexes
pets[100] = 't-rex' -- and holes!

table = { key = 'value' }
aKey = 'key'
anotherKey = 'k' .. 'e' .. 'y'
print(table[aKey] .. ' ' .. table[anotherKey])

table = {['+'] = "plus", ['-'] = "minus", ['='] = "equals", [{}] = "empty"}
if table[{}] then -- this {} is a different object from the one in the table
    print("found!")
else
    print("not found!") 
end

function printTable(table)
    for key, value in pairs(table) do
        print(key, value)
    end    
end

function printList(list)
    for i = 1, #list do
        print(list[i])
    end    
end

printTable(_G.pets) -- _G is a table that contains all globals
--print(getmetatable(_G))


-- ******************
-- *** METATABLES ***
print '\n\n*** METATABLES ***'

point = {}
function point.__add(a,b) -- will override the + operand
    local p = {}
    p.x = a.x + b.x
    p.y = a.y + b.y
    return p
end

function point.__scale(p,s) -- adds/defines 'scale' function/method
    local np = {}
    np.x = p.x * s
    np.y = p.y * s
    return np
end

function point.__len() -- overrides the # operator
    return 0
end

pA,pB={x=2,y=3},{x=4,y=2}

setmetatable(pA,point)
setmetatable(pB,point)

print("metatable of a point: ")
printTable(getmetatable(pA))

k = getmetatable(pA)['__scale'](pA,3)
print("applying 'scale' function on a point: ")
printTable(k)

pC = pA + pB
-- printTable(pC)

pX = pC.scale(pC,3)

print(#pA)