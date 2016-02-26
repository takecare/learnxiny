-- single line comment

--[[
    multi-line
    comment
--]]

-- *******************
-- *** VARS & FLOW ***

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
elseif name ~= 'rui' then
    print('the name has changed!')
    bool = true
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

if not bool then 
    for i=1,100 do fizzBuzz(i) end
end

function startFrom(y) -- anonymous function! remembers value of 'y'
    local f = function (x) return x + y end
    return f
end

addToAHundred = startFrom(100)
print(addToAHundred(10))
print(addToAHundred(50))

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

table = { name = 'rui', age = 42 } -- the keys are like strings
age = table['age']
print(table.name .. ' is ' .. age .. ' years old')
