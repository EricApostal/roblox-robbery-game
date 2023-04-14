local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService('RunService')

local LastTrainCFrame

local Function
local Function2

local teleportThreshold = 10 -- Define the threshold distance to prevent teleporting
local cart_switch_wait = 150

local last_hit = nil
local last_hit_time = 0

Function = RunService.Heartbeat:Connect(function()

    --------------------------------------------------------------- CHECK PLATFORM BELOW

    local character = player.Character or player.CharacterAdded:wait()
    local RootPart = character:WaitForChild("HumanoidRootPart")
    local Ignore = character
    local ray = Ray.new(RootPart.CFrame.p, Vector3.new(0, -50, 0))
    local Hit, Position, Normal, Material = workspace:FindPartOnRayWithIgnoreList(ray, {Ignore}, false, true)

    if Hit and Hit.Name == "train_player_hitbox" then
        local Train

        if (not ((DateTime.now().UnixTimestampMillis - last_hit_time) < cart_switch_wait)) or (not last_hit) then
            Train = Hit
        else
            Train = last_hit
        end

        if last_hit ~= Hit then
            if (DateTime.now().UnixTimestampMillis - last_hit_time) >= cart_switch_wait then
                Train = Hit
                last_hit = Hit
                last_hit_time = DateTime.now().UnixTimestampMillis
            else
                Train = last_hit
            end
        end

        if LastTrainCFrame == nil then
            LastTrainCFrame = Train.CFrame
        end

        local TrainCF = Train.CFrame
        local Rel = TrainCF * LastTrainCFrame:inverse()
        LastTrainCFrame = Train.CFrame
        local newCFrame = Rel * RootPart.CFrame

        if (newCFrame.p - RootPart.CFrame.p).Magnitude < teleportThreshold then
            RootPart.CFrame = newCFrame
        end

    else
        LastTrainCFrame = nil
    end

    Function2 = character:WaitForChild("Humanoid").Died:Connect(function()
        Function:Disconnect()
        Function2:Disconnect()
    end)
end)
