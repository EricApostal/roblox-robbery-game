local net = require( game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts").Client.client_networking )
local RS = game:GetService("ReplicatedStorage")

local Fusion = require(RS.modules.Fusion)

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Basic test notification on spawn to see what this file does lol", -- Required
	Text = "Hey!", -- Required
	Icon = "rbxassetid://1234567890" -- Optional
})