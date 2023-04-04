local TweenService = game:GetService("TweenService")
-- local part = game.Workspace:WaitForChild("train").train.PrimaryPart
local train_model = game.Workspace:WaitForChild("train").train

--[[
    Movement
]]

local speed = 75

local train = {}
train.__index = train

function train:move_to_position(pos, parent_cart)
    --[[
        Moves cart to a given vector3

        Parent cart is for any cart that has children
    ]]
    
    local goal = {}
    local _cf = CFrame.new(self.cart_object.PrimaryPart.Position, pos)
    local rads = Vector3.new(_cf:ToEulerAnglesXYZ())

    local Position = pos

    goal.CFrame = CFrame.new(Position) * CFrame.Angles(rads.X, rads.Y, rads.Z)

    local p1 = self.cart_object.PrimaryPart.Position
    local p2 = pos
    local dist = math.abs(p1.X-p2.X) + math.abs(p1.Y-p2.Y) + math.abs(p1.Z-p2.Z)

    local wait_duration = dist/speed

    if parent_cart then
        wait_duration = parent_cart.child_speed
    end
    
    local tweenInfo = TweenInfo.new(wait_duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(self.cart_object.PrimaryPart, tweenInfo, goal)
    
    if (dist/speed) and (dist/speed > 0) then
        if not parent_cart then
            self.child_speed = dist/speed
        end
        tween:Play()
        wait(wait_duration)
    else
        -- just in case the tween is 0, otherwise it will probably crash (usually only happens if I mess something else up)
        wait()
    end
end

function train:move_to_positions(positions)
    for k, v in ipairs(positions) do
        self:move_to_position(v)
    end
end

function train:move_to_nodes(nodes, parent_cart)
    for k, v in ipairs(nodes) do
        self:move_to_position(v.Position, parent_cart)
    end
end

function train.new(cart_number)
    local new_train = setmetatable({cart_number = cart_number, cart_object = train_model:Clone(), child_speed = 0}, train)
    new_train.cart_object.Parent = game.Workspace -- Set the parent of the cloned train model to the workspace
    return new_train
end

return train