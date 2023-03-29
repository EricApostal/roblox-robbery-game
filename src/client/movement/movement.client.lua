--[[
    Handles movement control such as sprinting
]]

local UserInputService = game:GetService("UserInputService")
local localplayer = game:GetService("Players").LocalPlayer

local character = localplayer.Character or localplayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		print("start sprint")
        humanoid.WalkSpeed = 30
	end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		print("stop sprint")
        humanoid.WalkSpeed = 16
	end
end)