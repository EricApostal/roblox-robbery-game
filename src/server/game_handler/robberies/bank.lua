--[[
    Handles bank robbery

    URGENT TODO: re-write vault detection. Using ontouch is a stupid idea and doesn't really work

    todo: handle if they are in-building. You could add a robber attribute, such as
    ```
    robbers[player].in_vault
    ```

    Or even better, add it to the hot data player array

]]

local bank = {}

-- modules
local players = game:GetService("Players")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local data = require(SS.server_data.hot_data)

-- defines
bank.active_robbery = false
local vault = game.Workspace:WaitForChild("robberies").bank.vault
local robbers = {}

local function tick_money()
    -- coroutine that runs every second during bank robbery to increment money
    local money_increment = coroutine.create(function() 
        
    end)
end

function bank.get_robbers()
    -- Returns everyone touching the vault block
    
    
end

function bank:start_robbery(player)
    bank.active_robbery = true
    print(player.name .. " has started a robbery!")

    while bank.active_robbery do
        for _, player_id in robbers do

            local new_bag_count = data:get_data(player_id)["crime"]["bag_amount"] + 100



            data:set_attribute(player_id, "crime", {is_robbing = true, location = "bank", bag_amount = new_bag_count })

            print("player data: ")
            print(data:get_data(player_id))

            
            -- print(player_id .. " recieved $100! New data:")
            -- print(data:get_data(player_id))
        end
        wait(1)
    end

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
		if touching[i] == player.Character.HumanoidRootPart then
			return true
		end
	end
	return false
end

function bank.check_vault_players()
    print("checking vault players")
    coroutine.wrap(function() 
        while true do
            for _, player in players:GetPlayers() do

                -- add them as a new robber
                if player_in_vault(player) and (not contains_key(robbers, player.UserId)) then
                    print(player.Name .. " joined the robbery!")
                    print(robbers)

                    data:set_attribute(player.UserId, "crime", {is_robbing = true, location = "bank", bag_amount = 0 or data:get_data(player.UserId)["crime"]["bag_amount"] })
                    robbers[player.UserId] = player.UserId -- goofy but it's the best way to do it with .remove
                end

                -- handle if the player is already in the array
                if (not player_in_vault(player)) and (contains_key(robbers, player.UserId)) then
                    print("player is not in the vault! Removing.")
                    robbers[player.UserId] = nil
                    print(robbers)
                end

            end
            wait()
        end
    end)()
end

bank.check_vault_players()

return bank