local component = require("component")
local term = require("term")
local tankCapacity = 16000

function progressbar(percentageValue)
    local fullChar = "▓"
    local emptyChar = "░"
    local buildingString = ""
    for i = 1, 20 do
        if percentageValue >= 5 then
            buildingString = buildingString .. fullChar
        else
            buildingString = buildingString .. emptyChar
        end
        percentageValue = percentageValue - 5
    end
    return buildingString
end

function percentage(value, maxValue)
    return (value / maxValue) * 100
end

function readable(number)
    local str_n = tostring(number)
    local formatted_n = ""

    local count = 0
    for i = str_n:len(), 1, -1 do
        count = count + 1
        formatted_n = str_n:sub(i, i) .. formatted_n

        if count % 3 == 0 and i > 1 then
            formatted_n = "'" .. formatted_n
        end
    end
    return formatted_n
end

print("Enter where the direction the redstone signal should be read from.\nbottom=0\ntop=1\nback=2\nfront=3\nright=4\nleft=5\n(1,2,3,4,5): ")
local side = tonumber(term.read())
print("Enter the with of your tank:")
local width = tonumber(term.read())
print("Enter the lenght of your tank:")
local length = tonumber(term.read())
print("Enter the height of your tank:")
local height = tonumber(term.read())

if component.isAvailable("redstone") then
    local redstone = component.redstone
    while (true) do
        local signalStrength = redstone.getInput(side)
        local totalCapacityUsed = signalStrength * width * length
        local totalCapacity = tankCapacity * width * length * height
        term.clear()
        print(readable(string.format("%.0f", totalCapacityUsed)) .. "/" .. readable(totalCapacity))
        local prtg = percentage(totalCapacityUsed, totalCapacity)
        print(progressbar(prtg))
        print(string.format("%.2f", prtg) .. "%")
        os.sleep(1)
    end

else
    print("No redstone component found.")
end
