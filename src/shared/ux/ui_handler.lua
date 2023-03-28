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

    local bag_ui = new "Frame" {
        Position = UDim2.new(1, -50, 1, -50),
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.fromOffset(300, 75),
        BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

        [Children] = {
            new "UICorner" {
                CornerRadius = UDim.new(0, 4),
            },
            new "TextLabel" {
                Text = "Money Bag",
                TextColor = BrickColor.Black(),
                TextSize = 24,
                AnchorPoint = Vector2.new(0, 0),
                Position = UDim2.fromScale(0.05, 0),
                Size = UDim2.fromScale(.9, .3),
                BorderSizePixel = 0, -- just to check for scaling
                TextXAlignment = 0,
            },
            new "TextLabel" {
                Text = "$1000", -- change to actually bag amount
                TextColor = BrickColor.Black(),
                TextSize = 32,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromScale(.9, .6),
                BorderSizePixel = 2,
                TextXAlignment = 2,
                BackgroundTransparency = 1
            },

            new "TextButton" {
                Text = "Buy a larger bag!", -- change to actually bag amount
                TextColor = BrickColor.Black(),
                AnchorPoint = Vector2.new(1, 1),
                Position = UDim2.fromScale(0.98, 0.98),
                Size = UDim2.fromScale(.4, .3),
                BorderSizePixel = 0,
                TextXAlignment = 2,
                BackgroundColor = BrickColor.new(0.250980, 1.000000, 0.000000),
                [Children] = {
                    new "UICorner" {
                        CornerRadius = UDim.new(0, 4),
                    },
                }
            }
        }
    }
    bag_ui.Parent = ScreenGui

end

return ui