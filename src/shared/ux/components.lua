--[[
    Where all of the UI components will be stored, so we can easily access them
]]

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')

local Fusion = require(RS.modules.Fusion)
local Value, Observer, Computed, ForKeys, ForValues, ForPairs, new, Children, OnEvent, OnChange, Out, Ref, Cleanup = Fusion.Value, Fusion.Observer, Fusion.Computed, Fusion.ForKeys, Fusion.ForValues, Fusion.ForPairs, Fusion.New, Fusion.Children, Fusion.OnEvent, Fusion.OnChange, Fusion.Out, Fusion.Ref, Fusion.Cleanup

local comps = {}

function comps.close_button(parent_ui)
    return new "TextButton" {
        Position = UDim2.fromScale(0.05, 0.05),
        AnchorPoint = Vector2.new(.5, .5),
        Size = UDim2.fromOffset(25, 25),
        BackgroundColor3 = Color3.new(0.890196, 0.270588, 0.270588),
        Text = "X",
        TextColor = BrickColor.White(),
        TextSize = 24,

        [OnEvent "Activated"] = function()
            print("The button was clicked!")
            parent_ui.Visible = false
            print()
        end,

        [OnChange "Name"] = function(newName)
            
            print("The asdad button was renamed to:", newName)
        end,

        [Children] = new "UICorner" {
            CornerRadius = UDim.new(0, 8)
        }
    }
end

function comps.main_button(button_text, button_position, button_size, parent_ui)
    return new "TextButton" {
        Position =  button_position,--UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(.5, .5),
        Size = button_size,--UDim2.fromOffset(170, 50),
        BackgroundColor3 = Color3.new(0.890196, 0.270588, 0.270588),
        Text = button_text,
        TextColor = BrickColor.White(),
        TextSize = 24,

        [OnEvent "Activated"] = function()
            print("Player accepted EULA!")
            -- This was bing

            -- Fusion.Animate(parent_ui, TweenInfo.new(1), {
            --     Position = UDim2.fromScale(0.25, -0.25),
            --     BackgroundTransparency = 1,
            --     Visible = false
            -- })
        end,

        

        
    }
end

return comps