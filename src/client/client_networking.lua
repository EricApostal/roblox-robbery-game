local net = {}

--[[
    File for all client networking
]]

-- Imports
local RS = game:GetService("ReplicatedStorage")
local knit = require(RS:WaitForChild("modules").Knit)
local ui_handler = require( RS:WaitForChild("Common").ux.ui_handler )

-- Constructer
knit.Start({ServicePromises = false}):catch(warn)
local game_service = knit.GetService("game_service")



-- Wrappers
function net.get_money()
    return game_service:get_money()
end

-- Listeners (RemoteSignal)
game_service.PlayerJoinedRobbery:Connect(function(player)
    print("Joined robbery")
    ui_handler:spawn_bag_ui()
end)

game_service.StartRobbery:Connect(function(player)
    print("Started Robbery")
end)

return net