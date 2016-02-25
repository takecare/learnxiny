-- single line comment

--[[
    multi-line comment
--]]

num = 42 -- every number is a 64bit-precision double

name = 'rui' -- strings are immutable
wall_of_text = [[   lorem
                    ipsum
                    dolor
                    sit
                    amet ]]

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

