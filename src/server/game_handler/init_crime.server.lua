--[[
    Cool script for robbery
]]

-- imports
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local net = require(SS.networking.server_networking)
local bank = require(SS.game_handler.robberies.bank)

print("Running robbery script")

local store_prompt = game.Workspace:WaitForChild("robberies").bank.start_block.rob_store


-- rather important bit of code-- responsible for starting the robbery. It's a remote so you could really trigger it however you want.
store_prompt.Triggered:Connect(function(player)
    net:start_robbery(player, "bank")
end)