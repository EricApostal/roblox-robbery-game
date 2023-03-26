local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local knit = require(RS:WaitForChild("modules").Knit)
local data = require(SS.server_data.hot_data)

local money_service = knit.CreateService { Name = "money_service", Client = {} }

print("server networking module running")

-- init money service
function money_service:init()
    print("coin service initialized")
end

function money_service.Client:add_money(player, amount)
    data:add_attribute(player.UserId, "money", amount)
    print(amount + " dollars were added to " + player.UserId)
end

function money_service.Client:get_money(player)
    return data:get_data(player.UserId)["money"]
end

function money_service.Client:start_robbery(player, location)
    print(player.name .. " has started a robbery!")
end

knit.Start():catch(warn)

local net = {}

function net:start_robbery(player, location) 
    money_service.Client:start_robbery(player, location)
end

return net