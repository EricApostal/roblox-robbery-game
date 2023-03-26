--[[
    Data structure header file
]]

local data = {
    money = 1000,

    -- not sure if I like this, it will require a manual reset upon joining as it will save (or negate it?)
    crime = {
        is_robbing = false,
        location = nil,
        bag_amount = 0
    }
}

return data