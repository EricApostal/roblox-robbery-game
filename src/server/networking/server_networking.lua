local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local knit = require(RS:WaitForChild("modules").Knit)

local data = require(SS.server_data.hot_data)
local bank = require(SS.game_handler.robberies.bank)

local game_service = knit.CreateService { 
    Name = "game_service", 
    Client = {
        RobberyStarted = knit.CreateSignal(), 
    },
}

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
    --[[
        Starts a robbery. Player = initiator. Location = building (bank, train, etc)
    ]]

    bank:start_robbery(player)
end

knit.Start():catch(warn)

local net = {}

function net:start_robbery(player, location)
    game_service:start_robbery(player, location)
    game_service.Client.RobberyStarted:Fire(player)
end

return net