local net = {}

--[[
    File for all client networking
]]

-- Imports
local RS = game:GetService("ReplicatedStorage")
local knit = require(RS:WaitForChild("modules").Knit)

-- Constructer
knit.Start({ServicePromises = false}):catch(warn)
local coin_service = knit.GetService("coin_service")

-- Wrappers
function net.get_coins()
    return coin_service:get_coins()
end

function net.get_pets()
    return coin_service:get_pets()
end

return net