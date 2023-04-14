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
    Position = UDim2.fromScale(.5, .9),
    AnchorPoint = Vector2.new(.5, .5),
    Size = UDim2.fromOffset(400, 70),
    Transparency = .6,
    BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

    [Children] = {
        new "UICorner" {
            CornerRadius = UDim.new(0, 8),
        },
        components.inventory_slot(UDim2.fromScale(.1, .5)),
        components.inventory_slot(UDim2.fromScale(.3, .5)),
        components.inventory_slot(UDim2.fromScale(.5, .5)),
        components.inventory_slot(UDim2.fromScale(.7, .5)),
        components.inventory_slot(UDim2.fromScale(.9, .5)),

        --[[
          Check components.lua
          ~ Resp
        ]]
        -- components.inventory_selection_text(UDim2.fromScale(.5, .01))
    }
}

-- Side buttons
local side_frame = new "Frame" {
    Position = UDim2.new(UDim.new(0, 5), UDim.new(0.5, 0)),
    AnchorPoint = Vector2.new(0, .5),
    Size = UDim2.fromOffset(70, 200),
    Transparency = .6,
    BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

    [Children] = {
        new "UICorner" {
            CornerRadius = UDim.new(0, 8),
        },
        new "UIListLayout" {
            
        }
    }
}

Main_Inv.Parent = ScreenGui
side_frame.Parent = ScreenGui
