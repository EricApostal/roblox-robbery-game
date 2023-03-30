--[[
    Makes it so the player stays on top of the hitbox of the train

    Found at:
    https://devforum.roblox.com/t/how-do-i-make-a-player-move-with-a-part/2093770
        and 
    https://devforum.roblox.com/t/jailbreak-train-platform-system/236339/35
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService('RunService')

local LastTrainCFrame

local Function
local Function2


Function = RunService.Heartbeat:Connect(function()

--------------------------------------------------------------- CHECK PLATFORM BELOW

local character = player.Character or player.CharacterAdded:wait()

local RootPart = character:WaitForChild("HumanoidRootPart")

local Ignore = character

local ray = Ray.new(RootPart.CFrame.p,Vector3.new(0,-50,0))

local Hit, Position, Normal, Material = workspace:FindPartOnRay(ray,Ignore)

if Hit and Hit.Name == "player_hitbox" then -- Change "RaftTop" to whatever the moving part's name is

--------------------------------------------------------------- MOVE PLAYER TO NEW POSITON FROM OLD POSITION

local Train = Hit
if LastTrainCFrame == nil then -- If no LastTrainCFrame exists, make one!
	LastTrainCFrame = Train.CFrame -- This is updated later.
end
local TrainCF = Train.CFrame 

local Rel = TrainCF * LastTrainCFrame:inverse()

LastTrainCFrame = Train.CFrame -- Updated here.

RootPart.CFrame = Rel * RootPart.CFrame -- Set the player's CFrame
--print("set")

else
LastTrainCFrame = nil -- Clear the value when the player gets off.

end

Function2 = character.Humanoid.Died:Connect(function()
	Function:Disconnect() -- Stop memory leaks
	Function2:Disconnect() -- Stop memory leaks
end)

end)