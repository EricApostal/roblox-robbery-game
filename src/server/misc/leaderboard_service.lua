local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local data = require(SS.server_data.hot_data)

local ls = {}

local function persist_leaderboard(player, ls_object)
    coroutine.wrap(function()
        while player do -- so it exits if the player instance is nil (ie player object is destroyed, ie player has left)
            ls_object.Value = data:get_data(player.UserId).money
            wait(0.25)
        end
    end)()
end

function ls:init_leaderboard(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Money = Instance.new("IntValue")
	Money.Name = "Money"
	Money.Value = data:get_data(player.UserId).money
	Money.Parent = leaderstats

    persist_leaderboard(player, Money)
end

return ls