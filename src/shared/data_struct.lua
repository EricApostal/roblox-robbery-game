--[[
    Data structure header file

    Basically just the default user data
]]

local data = {
    money = 1000,

    -- not sure if I like this, it will require a manual reset upon joining as it will save (or negate it?)
    -- my temporary solution is to just reset it upon intialization. Not too bad honestly, good for being aware of the previous session.
    crime = {
        is_robbing = false,
        location = "",
        bag_amount = 0
    },

    inventory = {}


}

return data