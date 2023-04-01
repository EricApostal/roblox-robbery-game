

local TweenService = game:GetService("TweenService")
-- local part = game.Workspace:WaitForChild("train").train.PrimaryPart
local train_model = game.Workspace:WaitForChild("train").train

--[[
    Movement
]]

local speed = 50

local train = {}
train.__index = train


function train:move_to_position(pos)
    local goal = {}
    local _cf = CFrame.new(self.cart_object.PrimaryPart.Position, pos)
    local rads = Vector3.new(_cf:ToEulerAnglesXYZ())

    local Position = pos

    goal.CFrame = CFrame.new(Position) * CFrame.Angles(rads.X, rads.Y, rads.Z)

    local p1 = self.cart_object.PrimaryPart.Position
    local p2 = pos
    local dist = math.abs(p1.X-p2.X) + math.abs(p1.Y-p2.Y) + math.abs(p1.Z-p2.Z)
    local tweenInfo = TweenInfo.new(dist/speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(self.cart_object.PrimaryPart, tweenInfo, goal)
    
    tween:Play()
    wait(dist/speed)
end

function train:move_to_positions(positions)
    for k, v in ipairs(positions) do
        self:move_to_position(v)
    end
end

function train:move_to_nodes(nodes)
    for k, v in ipairs(nodes) do
        self:move_to_position(v.Position)
    end
end


function train.new(cart_number)
    local new_train = setmetatable({cart_number = cart_number, cart_object = train_model:Clone()}, train)
    new_train.cart_object.Parent = game.Workspace -- Set the parent of the cloned train model to the workspace
    return new_train
end


return train