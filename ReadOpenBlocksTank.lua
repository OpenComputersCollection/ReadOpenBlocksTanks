local component = require("component")
local term = require("term")
local tankCapacity = 16000

print("Enter where the direction the redstone signal should be read from.\nbottom=0\ntop=1\nback=2\nfront=3\nright=4\nleft=5\n(1,2,3,4,5): ")
local side = tonumber(term.read())
print("Enter the with of your tank")
local width = tonumber(term.read())
print("Enter the lenght of your tank")
local length = tonumber(term.read())
print("Enter the height of your tank")
local height = tonumber(term.read())

if component.isAvailable("redstone") then
    local redstone = component.redstone
    while (true) do
        local signalStrength = redstone.getInput(side)
        local totalCapacityUsed = signalStrength * width * length
        local totalCapacity = tankCapacity * width * length * height
        print(totalCapacityUsed .. "/" .. totalCapacity)
        os.sleep(1)
    end

else
    print("No redstone component found.")
end
