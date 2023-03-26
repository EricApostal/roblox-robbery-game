local net = {}

--[[
    File for all client networking
]]

-- Imports
local RS = game:GetService("ReplicatedStorage")
local knit = require(RS:WaitForChild("modules").Knit)

-- Constructer
knit.Start({ServicePromises = false}):catch(warn)
local money_service = knit.GetService("money_service")

-- Wrappers
function net.get_money()
    return money_service:get_money()
end


return net