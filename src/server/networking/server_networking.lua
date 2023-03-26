local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local knit = require(RS:WaitForChild("modules").Knit)
local data = require(SS.server_data.hot_data)

local game_service = knit.CreateService { Name = "game_service", Client = {} }

print("server networking module running")

-- init money service
function game_service:init()
    print("coin service initialized")
end

function game_service.Client:add_money(player, amount)
    data:add_attribute(player.UserId, "money", amount)
    print(amount + " dollars were added to " + player.UserId)
end

function game_service.Client:get_money(player)
    return data:get_data(player.UserId)["money"]
end

function game_service:start_robbery(player, location)
    
end

knit.Start():catch(warn)

local net = {}

function net:start_robbery(player, location) 
    game_service:start_robbery(player, location)
end

return net