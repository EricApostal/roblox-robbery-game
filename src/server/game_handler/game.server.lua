--[[
    Cool script for robbery
]]

-- imports
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local net = require(SS.networking.server_networking)

print("running robbery script")

local store_prompt = game.Workspace:WaitForChild("Robbery Part").rob_store

store_prompt.Triggered:Connect(function(player)
	print("store robbery prompt go brrr")
    net:start_robbery(player, "store")
end)