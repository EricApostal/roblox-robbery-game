local train = {}

local TweenService = game:GetService("TweenService")
local part = game.Workspace:WaitForChild("train").train.PrimaryPart
local hitbox = game.Workspace:WaitForChild("train").train.player_hitbox

--[[
    Movement
]]

local speed = 50

function train:move_to_position(pos)
    local goal = {}
    local _cf = CFrame.new(part.Position, pos)
    local rads = Vector3.new(_cf:ToEulerAnglesXYZ())

    local Position = pos

    goal.CFrame = CFrame.new(Position) * CFrame.Angles(rads.X, rads.Y, rads.Z)

    local p1 = part.Position
    local p2 = pos
    local dist = math.abs(p1.X-p2.X) + math.abs(p1.Y-p2.Y) + math.abs(p1.Z-p2.Z)
    local tweenInfo = TweenInfo.new(dist/speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(part, tweenInfo, goal)
    
    tween:Play()
    wait(dist/speed)
end

function train:move_to_positions(positions)
	for k,v in positions do
		train:move_to_position(v)
	end
end

function train:move_to_nodes(nodes)
	for k,v in nodes do
		train:move_to_position(v.Position)
	end
end

return train