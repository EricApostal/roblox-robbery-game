local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")
local data = require(SS.server_data.hot_data)
local data_struct = require(RS.Common.data_struct)
local ui_handler = require( RS:WaitForChild("Common").ux.ui_handler )
-- Point is to update the Huds money counter
-- Current problems i have no idea how to trigger start the HUD from ui handler
function update_hud_money()
    while true do
        for _, player in players:GetPlayers() do
            --print("Total Money: " .. data:get_data(player.UserId)["money"] )
            print("Updated money or smh")
            -- Should hopefully send the info to the label from ui handler
            ui_handler:client_hud(data:get_data(player.UserId)["money"])
        end
        wait(3)
   end
end
print("file ran")
update_hud_money()