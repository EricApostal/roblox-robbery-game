--[[
    Handles bank robbery
]]

local bank = {}

-- defines
bank.active_robbery = false


function bank.start_robbery(player)
    bank.active_robbery = true
    print(player.name .. " has started a robbery!")
end


return bank