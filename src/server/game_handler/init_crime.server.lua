--!strict

--[[
    Cool script for robbery
]]

-- imports
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")
local bank = require(SS.game_handler.robberies.bank)

local store_prompt = game.Workspace:WaitForChild("robberies").bank.start_block.rob_store

--[[ 
    Rather important bit of code-- responsible for starting the robbery. 
    It's a remote so you could really trigger it however you want.
]]
store_prompt.Triggered:Connect(function(player)
    bank:start_robbery(player)
end)