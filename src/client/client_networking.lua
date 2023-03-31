local net = {}

--[[
    File for all client networking
]]

-- Imports
local RS = game:GetService("ReplicatedStorage")
local knit = require(RS:WaitForChild("modules").Knit)
local ui_handler = require( RS:WaitForChild("Common").ux.ui_handler )
local Fusion = require(RS.modules.Fusion)
local value = Fusion.Value
local ScreenGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("ScreenGui")

-- Constructer
knit.Start({ServicePromises = false}):catch(warn)
local game_service = knit.GetService("game_service")

-- Globals
local bag_amount = value(0)
local bag_ui = ui_handler:bag_ui(bag_amount)

-- Wrappers
function net.get_money()
    return game_service:get_money()
end

function net:get_bag_amount()
    return game_service:get_crime_bag_amount()
end

-- Listeners (RemoteSignal)
game_service.PlayerJoinedRobbery:Connect(function(player)
    print("Joined robbery")
    bag_ui.Parent = ScreenGui
    bag_ui.Visible = true
end)

game_service.StartRobbery:Connect(function(location)
    print("Localplayer has started a " .. location .. " robbery!")
end)

game_service.CrimeBagUpdate:Connect(function(player)
    bag_amount:set(net:get_bag_amount())
end)

game_service.LeaveRobbery:Connect(function(player)
    print("player = ")
    print(player)
    print("Localplayer has left a robbery and is collecting money!")
    bag_ui.Visible = false
end)

return net