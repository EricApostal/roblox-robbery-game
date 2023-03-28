local Players = game:GetService("Players")
local ScreenGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("ScreenGui")
local RS = game:GetService("ReplicatedStorage")

local Fusion = require(RS.modules.Fusion)
local Value, Observer, Computed, ForKeys, ForValues, ForPairs, new, Children, OnEvent, OnChange, Out, Ref, Cleanup = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs, Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup

local ui = {}

function ui:spawn_bag_ui()
    --[[
        Spawns the money bag UI
    ]]

    print("spawnign bag UI")

    local bag_ui = new "Frame" {
        Position = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.fromOffset(100, 200),
        BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

        [Children] = {
            new "UICorner" {
                CornerRadius = UDim.new(0, 8),
            },
        }
    }
    bag_ui.Parent = ScreenGui
    print("spawned bag UI")
end

return ui