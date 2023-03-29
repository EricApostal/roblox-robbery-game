--[[
    Handles bank robbery

    todo: handle if they are in-building. You could add a robber attribute, such as
    ```
    robbers[player].in_vault
    ```

]]

local bank = {}

-- modules
local players = game:GetService("Players")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")
local RS = game:GetService("ReplicatedStorage")
local net = require(SS.networking.server_networking)

local data = require(SS.server_data.hot_data)
local data_struct = require(RS.Common.data_struct)

-- defines
bank.active_robbery = false
local vault = game.Workspace:WaitForChild("robberies").bank.vault
local robbers = {}

function bank:start_robbery(player)
    --[[
        Starts the logic behind the bank robbery
    ]]

    net:start_robbery(player, "bank")

    bank.active_robbery = true
    print(player.name .. " has started a robbery!")

    -- This is so we don't hault whatever thread calls "bank:start_robbery"
    coroutine.wrap(function() 
        while bank.active_robbery do
            for _, player_id in robbers do
                local new_bag_count = data:get_data(player_id)["crime"]["bag_amount"] + 100
                data:set_attribute(player_id, "crime", {is_robbing = true, location = "bank", bag_amount = new_bag_count })
                net:update_crime_bag(player, new_bag_count)
            end
            wait(1)
        end
    end)()
end

function bank:stop_robbery()
    bank.active_robbery = false
    robbers = {}
end

local function contains_key(table, key)
    for i, _ in table do
        if i == key then 
            return true
        end
    end
    return false
end


vault.Touched:Connect(function() end) -- Just for a TouchInterest to occur on a CanCollide false part

function player_in_vault(player)
    -- https://devforum.roblox.com/t/how-do-i-accurately-check-if-a-player-is-in-a-certain-area/369733/2
    local touching = vault:GetTouchingParts()
	for i=1,#touching do
        local character = player.Character or player.CharacterAdded:Wait()
		if touching[i] == character.HumanoidRootPart then
			return true
		end
	end
	return false
end

function bank.check_vault_players()
    coroutine.wrap(function() 
        while true do
            for _, player in players:GetPlayers() do

                -- add them as a new robber
                if player_in_vault(player) and (not contains_key(robbers, player.UserId)) then
                    net:join_robbery(player, "bank")
                    print(player.Name .. " joined the robbery!")

                    data:set_attribute(player.UserId, "crime", {is_robbing = true, location = "bank", bag_amount = 0 or data:get_data(player.UserId)["crime"]["bag_amount"] })
                    robbers[player.UserId] = player.UserId -- don't ask :D
                end

                -- handle if the player is already in the array
                if (not player_in_vault(player)) and (contains_key(robbers, player.UserId)) then
                    print(player.name .. " has left the Bank robbery!") 
                    print("Money Gained: " .. data:get_data(player.UserId)["crime"]["bag_amount"])
                    robbers[player.UserId] = nil
                    data:add_attribute(player.UserId, "money", data:get_data(player.UserId)["crime"]["bag_amount"])
                    data:set_crime(player.UserId, data_struct["crime"])
                    print("Total Money: " .. data:get_data(player.UserId)["money"] )
                    net:leave_robbery(player)
                end
            end
            wait()
        end
    end)()
end

bank.check_vault_players()

return bank