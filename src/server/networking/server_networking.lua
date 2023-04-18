--!strict

local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")

local knit = require(RS:WaitForChild("modules").Knit)

local data = require(SS.server_data.hot_data)

local game_service = knit.CreateService { 
    Name = "game_service", 
    Client = {
        --[[
            I may try to shave down on these.
            It's okay, but binding a single signal w/ proper args sounds cleaner

            Whatever either way is fine
        ]]
        StartRobbery = knit.CreateSignal(), 
        PlayerJoinedRobbery = knit.CreateSignal(), 
        CrimeBagUpdate = knit.CreateSignal(),
        LeaveRobbery = knit.CreateSignal(),
        ShowUI = knit.CreateSignal()
    },
}

-- init money service
function game_service:init()
    print("coin service initialized")
end

function game_service:add_money(player, amount)
    data:add_attribute(player.UserId, "money", amount)
    print(amount + " dollars were added to " + player.UserId)
end

function game_service.Client:get_money(player)
    return data:get_data(player.UserId)["money"]
end

function game_service.Client:get_crime_bag_amount(player)
    return data:get_data(player.UserId)["crime"].bag_amount
end

knit.Start():catch(warn)

local net = {}

function net:start_robbery(player, location)
    game_service.Client.StartRobbery:Fire(player, location)
end

function net:join_robbery(player, location)
    game_service.Client.PlayerJoinedRobbery:Fire(player, location)
end

function net:update_crime_bag(player, new_value)
    game_service.Client.CrimeBagUpdate:Fire(player, new_value)
end

function net:leave_robbery(player)
    game_service.Client.LeaveRobbery:Fire(player)
end

function net:show_ui(player, ui_name)
    game_service.Client.ShowUI:Fire(player, ui_name)
end

return net