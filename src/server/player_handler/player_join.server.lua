--[[
    Handlers for when a player joins
]]

local Players = game:GetService("Players")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local data = require(SS.server_data.hot_data)

local function onPlayerAdded(player)
    data:init_player(player.UserId)
end

local function onPlayerLeaving(player)
    print("Player is leaving!")
    data:player_leaving(player.UserId)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerLeaving)