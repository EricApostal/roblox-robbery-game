local Players = game:GetService("Players")
local ScreenGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("ScreenGui")
local RS = game:GetService("ReplicatedStorage")

local Fusion = require(RS.modules.Fusion)
local Value, Observer, Computed, ForKeys, ForValues, ForPairs, new, Children, OnEvent, OnChange, Out, Ref, Cleanup = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs, Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup



local ui = {}

function ui:bag_ui(bag_value)
    --[[
        Spawns the money bag UI
    ]]

    local moneyAmountLabel = new "TextLabel" {
        TextColor = BrickColor.Black(),
        TextSize = 32,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(.9, .6),
        BorderSizePixel = 2,
        TextXAlignment = 2,
        BackgroundTransparency = 1,
        Text = "$0"
    }

    local observer = Observer(bag_value)

    -- Update the Text property every time the bag_value changes
    observer:onChange(function()
        moneyAmountLabel.Text = "$" .. bag_value:get()
    end)

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
                BorderSizePixel = 0,
                TextXAlignment = 0,
            },
            moneyAmountLabel, -- Changed to the new variable

            new "TextButton" {
                Text = "Buy a larger bag!",
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
    return bag_ui
end


-- TOP RIGHT HUD

function ui:client_hud(cash_amount)
    --[[
        Spawns the HUD
        I know this is very copy pasta
    ]]

    local cashamount = new "TextLabel" {
        TextColor = BrickColor.Black(),
        TextSize = 32,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(.9, .6),
        BorderSizePixel = 2,
        TextXAlignment = 2,
        BackgroundTransparency = 1,
        Text = cash_amount
    }
    local client_hud = new "Frame" {
        Position = UDim2.fromScale(0.9, 0.1),
        AnchorPoint = Vector2.new(1, 1),
        Size = UDim2.fromOffset(300, 75),
        BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

        [Children] = {
            new "UICorner" {
                CornerRadius = UDim.new(0, 4),
            },
            cashamount
        }
    }
    return client_hud
end


return ui