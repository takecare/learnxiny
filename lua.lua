-- single line comment

--[[
    multi-line
    comment
--]]

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
while i < 10 do
    print(i)
    i = i + 1
end

do -- you can define blocks like this
    local name = 'miguel' -- this var is local to the block
    local age = 10
    print(name)
end

print(age) -- not defined here...

if i == 0 then
    print("i hasn't changed...")
elseif name ~= 'rui' then
    print('the name has changed!')
else
    io.write('dang it... what\'s the name, then? ')
    local input = io.read()
    print('gocha! the name\'s ' + name)
end

