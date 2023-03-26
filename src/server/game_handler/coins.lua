--[[
    handles all server-sided game functions for coin game
]]

-- modules
local SS = game:GetService("ServerScriptService"):WaitForChild("Server")
local data = require(SS.server_data.hot_data)

-- defines
local coins = 0

function spawn_coin()
        coins += 1
        local part = Instance.new("Part")
        part.Name = "coin"
        part.Anchored = false
        part.Shape = Enum.PartType.Ball
        part.Color = Color3.new(1, 0.9490196078431372, 0)
        part.Position = Vector3.new(math.random(-50, 50), 200, math.random(-50, 50))

        part.Parent = workspace -- Put the part into the Workspace

        part.Touched:Connect(function(hit)
            local player = game:GetService("Players"):GetPlayerFromCharacter(hit.Parent)
            if player then
                part:Destroy()
                coins -= 1
                data:add_attribute(player.UserId, "coins", 1)
            end
            wait()
        end)

end

while true do
    if coins < 50 then
        spawn_coin()
    end
    wait()
end