--[[
    Cool script for robbery
]]

-- imports
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local net = require(SS.networking.server_networking)

print("Running robbery script")

local store_prompt = game.Workspace:WaitForChild("robberies").bank_robbery.rob_store

store_prompt.Triggered:Connect(function(player)
	print("bank robbery prompt go brrr")
    net:start_robbery(player, "bank")
end)