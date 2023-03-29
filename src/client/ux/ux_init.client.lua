--[[
    Initialize Client side UI
]]

-- Modules
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("ScreenGui")

local components = require(RS:WaitForChild("Common").ux.components)

-- Yeah, I hate it too.
local Fusion = require(RS.modules.Fusion)
local Value, Observer, Computed, ForKeys, ForValues, ForPairs, new, Children, OnEvent, OnChange, Out, Ref, Cleanup = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs, Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup

local close_button = components.close_button()

--[[
    This UI is more or less of a demo, I don't know it's actual function
    Feel free to do whatever you want with it
]]
local main_ui = new "Frame" {
    Position = UDim2.fromScale(.9, .9),
    AnchorPoint = Vector2.new(.5, .5),
    Size = UDim2.fromOffset(200, 200),
    BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

    [Children] = new "UICorner" {
        CornerRadius = UDim.new(0, 8)
    }
}

-- Setting the parrent to "ScreenGui" just makes it visible to the player
main_ui.Parent = ScreenGui
close_button.Parent = main_ui
