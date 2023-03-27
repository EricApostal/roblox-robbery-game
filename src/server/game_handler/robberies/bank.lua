--[[
    Handles bank robbery

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
        for player_id, _ in robbers do

            local new_bag_count = data:get_data(player_id)["crime"]["bag_amount"] + 100
            data:set_attribute(player_id, "crime", {is_robbing = true, location = "bank", bag_amount = new_bag_count })
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

--[[
     shitty way to see who is robbing the bank
     yeah, it's super laggy
     no, I'm not fixing it
]]

local function vault_touch_coro(player_id)
    -- async function that constantly monitors to see if a player is still touching the vault
    local coro_running = true

    coroutine.wrap(function() 
        while coro_running do
        -- if the check difference is greater than 1 second
            if (os.time() - robbers[player_id]) > 1 then
                print("player has timed out of bank")
                -- if so, remove the player and stop the coro
                table.remove(robbers, player_id)
                data:set_attribute(player_id, "crime", {is_robbing = false, location = nil, bag_amount = 0 })
                coro_running = false
            else 
                print("player has not timed out of bank yet")
            end
            wait()
        end
    end)()

end

vault.Touched:Connect(function(itemTouchingPart)
    -- https://scriptinghelpers.org/questions/88063/how-do-i-check-if-a-player-is-touching-a-part
    if(itemTouchingPart.Parent and game.Players:FindFirstChild(itemTouchingPart.Parent.Name)) and bank.active_robbery then

        local player = game.Players:FindFirstChild(itemTouchingPart.Parent.Name)
        local player_name = player.Name
        local player_id = player.UserId

        print("player do be touching it tho")

        if not ( contains_key(robbers, player_id) ) then
            robbers[player_id] = os.time()
            -- if robber isn't already in the db

            print(player_name .. " joined the robbery!")

            -- start thread to check if the player leaves the vault
            vault_touch_coro(player_id)
            
            -- so it's easy to access said data elsewhere
            data:set_attribute(player_id, "crime", {is_robbing = true, location = "bank", bag_amount = 0 or data:get_data(player_id)["crime"]["bag_amount"] })
        end
        robbers[player_id] = os.time()
    end
end)

return bank