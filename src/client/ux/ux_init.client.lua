--[[
    Initialize Client side UI
]]
print("Hello worlde")
-- Modules
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ScreenGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("ScreenGui")
local ui_handler = require( RS:WaitForChild("Common").ux.ui_handler )
local components = require(RS:WaitForChild("Common").ux.components)

-- Yeah, I hate it too.
local Fusion = require(RS.modules.Fusion)
local Value, Observer, Computed, ForKeys, ForValues, ForPairs, new, Children, OnEvent, OnChange, Out, Ref, Cleanup = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs, Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup

--[[
    This UI is more or less of a demo, I don't know it's actual function
    Feel free to do whatever you want with it
]]

-- Show your current bank balance on the top right
local main_ui = new "Frame" {
    Position = UDim2.fromScale(.9, .9),
    AnchorPoint = Vector2.new(.5, .5),
    Size = UDim2.fromOffset(200, 200),
    BackgroundColor3 = Color3.new(1.000000, 1.000000, 1.000000),

    [Children] = {
        new "UICorner" {
            CornerRadius = UDim.new(0, 8),
        }
        
    }
}

ui_handler:client_hud("Loaded HUD").Parent = ScreenGui
ui_handler:client_hud("Loaded HUD").Visible = true

-- this can't be a normal child within main_ui because it references itself
--local close_button = components.close_button(main_ui)

--main_ui.Parent = ScreenGui
--local test = components.main_button("Accept EULA", UDim2.fromScale(0.5, 0.9), UDim2.fromOffset(170, 30), main_ui)
-- Close button go byebye ACCEPT EULA!!
--close_button.Parent = main_ui
--test.Parent = main_ui
