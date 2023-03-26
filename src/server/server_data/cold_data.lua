--[[
    Handles database stuff between play sessions
]]
local cold_data = {}

-- require modules
local DataStoreService = game:GetService("DataStoreService")

-- so we can dynamically route do a different database
local databases = {}
databases['players'] = 'players_testdb_2'


function cold_data:save_data(raw_database, key, data)
    local database = DataStoreService:GetDataStore(databases[raw_database])
    -- I would use strict type checking for no nulls here... this could cause problems

    -- Saves the data to a database
    local success, errorMessage = pcall(function()
        database:SetAsync(key, data)
    end)
    
    if not success then
        warn("THERE WAS AN ERROR UPDATING THE DATABASE! : \n" + errorMessage)
    end
end

function cold_data:get_data(raw_database, key)
    -- Gets data from DB
    local database = DataStoreService:GetDataStore(databases[raw_database])

    local success, retrieved_data = pcall(function()
        local data = database:GetAsync(key)

        -- this is within a pcall, success is the whether this call actually worked, 
        -- retrieved_data is the data it retrieved, or the error if applicable
        return data
    end)
    
    if not success then
        warn("THERE WAS AN ERROR RETRIEVING FROM THE DATABASE! : \n" + retrieved_data)
    end

    return retrieved_data
end

return cold_data