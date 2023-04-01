print("Hello worlde")
-- Modules
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("ScreenGui")
local ui_handler = require( RS:WaitForChild("Common").ux.ui_handler )
local components = require(RS:WaitForChild("Common").ux.components)


local Fusion = require(RS.modules.Fusion)
local Value, Observer, Computed, ForKeys, ForValues, ForPairs, new, Children, OnEvent, OnChange, Out, Ref, Cleanup = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs, Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup

-- Inventory Hotbar
local  Main_Inv = new "Frame" {
    Position = UDim2.fromScale(.5, .8),
    AnchorPoint = Vector2.new(.5, .5),
    Size = UDim2.fromOffset(300, 70),
    Transparency = 1    ,
    BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

    [Children] = {
        new "UICorner" {
            CornerRadius = UDim.new(0, 3),
        },
        components.inventory_slot(UDim2.fromScale(.1, .6)),
        components.inventory_slot(UDim2.fromScale(.3, .6)),
        components.inventory_slot(UDim2.fromScale(.5, .6)),
        components.inventory_slot(UDim2.fromScale(.7, .6)),
        components.inventory_slot(UDim2.fromScale(.9, .6)),
        components.inventory_selection_text(UDim2.fromScale(.5, .01))
    }
}

Main_Inv.Parent = ScreenGui
