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
vault.Touched:Connect(function(itemTouchingPart)
    -- https://scriptinghelpers.org/questions/88063/how-do-i-check-if-a-player-is-touching-a-part
    if(itemTouchingPart.Parent and game.Players:FindFirstChild(itemTouchingPart.Parent.Name)) and bank.active_robbery then

        local player = game.Players:FindFirstChild(itemTouchingPart.Parent.Name)
        local player_name = player.Name
        local player_id = player.UserId

        if not contains_key(robbers, player) then
            robbers[player] = {
                bag_amount = 0
            }
            print(player_name .. " joined the robbery!")
            
            -- so it's easy to access said data elsewhere
            data:set_attribute(player_id, "crime", {is_robbing = true, location = "bank", bag_amount = robbers[player].bag_amount})
            print('new player data: ')
            print(data:get_data(player_id))
        end
    end
end)

return bank