local net = {}

--[[
    File for all client networking
]]

-- Imports
local RS = game:GetService("ReplicatedStorage")
local knit = require(RS:WaitForChild("modules").Knit)

-- Constructer
knit.Start({ServicePromises = false}):catch(warn)
local game_service = knit.GetService("game_service")

-- Wrappers
function net.get_money()
    return game_service:get_money()
end


return net