--[[
Controls all active session data
]]

local session_data = {}

-- imports
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")
local RS = game:GetService("ReplicatedStorage")

local cold_data = require(SS.server_data.cold_data)
local data_header = require(RS.Common.data_struct)

function session_data:init_player(player_id)
    -- this is where we would retrieve from a DB
    
    local cold_player_data = cold_data:get_data("players", player_id)

    if cold_player_data ~= nil then
        session_data[player_id] = cold_player_data
        session_data[player_id]["crime"] = {data_header["crime"]} -- I hate this so much but it's the best I got atm
    else
        -- We would need to have an init function with the expected default data
        print("no data in DB (nil), setting to default values")

        -- not super modular, I may create a replicatedstorage header file
        session_data[player_id] = data_header
    end

    return session_data[player_id]
end

local function yield_until_valid(player_id) 
    --[[ 
        Yields until there is a table entry with the user's id
        
        It might be smart to implement init into this anyway, so we don't miss it
        This will run forever if init is called incorrectly
        it should be fine tho, it's using roblox's own onPlayerJoined function
    ]]
    local data = nil
    while data == nil do
        data = session_data[player_id]
        wait(0)
    end
end

function session_data:get_data(player_id)
    yield_until_valid(player_id)

    local player_data = session_data[player_id]
    
    return player_data
end

function session_data:set_attribute(player_id, attribute, value)
    yield_until_valid(player_id) 

    session_data[player_id][attribute] = value
    return true
end

function session_data:add_attribute(player_id, attribute, value)
    yield_until_valid(player_id) 

    session_data[player_id][attribute] += value
    return true
end

function session_data:player_leaving(player_id) 
    yield_until_valid(player_id) 

    print("saving player data (leaving)")
    cold_data:save_data("players", player_id, session_data:get_data(player_id))
end

return session_data