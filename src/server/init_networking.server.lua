local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local knit = require(RS:WaitForChild("modules").Knit)
local data = require(SS.server_data.hot_data)

local coin_service = knit.CreateService { Name = "coin_service", Client = {} }

print("server networking module running")

function coin_service:init()
    print("coin service initialized")
end

function coin_service.Client:add_coins(player, amount)
    data:add_attribute(player.UserId, "coins", amount)
    print(amount + " coins were added to " + player.UserId)
end

function coin_service.Client:get_coins(player)
    return data:get_data(player.UserId)["coins"]
end

function coin_service.Client:get_pets(player)
    return data:get_data(player.UserId)["pets"]
end

knit.Start():catch(warn)