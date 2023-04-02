--[[
    Handles movement control such as sprinting
]]

local UserInputService = game:GetService("UserInputService")
local localplayer = game:GetService("Players").LocalPlayer

local character = localplayer.Character or localplayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

--[[
    This is a very basic system, and I think it should be expanded upon
    Making this more network dependent would allow for more security, and for stuff like sprint cooldown / "exhaustion"
]]

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
        humanoid.WalkSpeed = 32
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
        humanoid.WalkSpeed = 16
	end
end)