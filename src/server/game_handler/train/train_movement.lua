local TweenService = game:GetService("TweenService")
-- local part = game.Workspace:WaitForChild("train").train.PrimaryPart
local train_model = game.Workspace:WaitForChild("train").train

--[[
    Movement
]]

local speed = 100
local cart_dist = 10

local train = {}
train.__index = train

function train:move_to_position(pos, parent_cart)
    --[[
        Moves cart to a given Vector3
        Parent cart is for any cart that has children
    ]]
    
    local goal = {}
    local _cf = CFrame.new(self.cart_object.PrimaryPart.Position, pos)
    local rads = Vector3.new(_cf:ToEulerAnglesXYZ())

    goal.CFrame = CFrame.new(pos) * CFrame.Angles(rads.X, rads.Y, rads.Z)

    local p1 = self.cart_object.PrimaryPart.Position
    local p2 = pos
    local dist = math.abs(p1.X-p2.X) + math.abs(p1.Y-p2.Y) + math.abs(p1.Z-p2.Z)

    local wait_duration = dist/speed

    if parent_cart then
        local modifier = 1
        local magnitude = math.round((self:front_hitch().Position - parent_cart:rear_hitch().Position).Magnitude)
        
        if magnitude > cart_dist then
            modifier = 0.9
        elseif magnitude < cart_dist then
            modifier = 1.1
        end

        wait_duration = (parent_cart.child_speed) * modifier
    end

    local tweenInfo = TweenInfo.new(wait_duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(self.cart_object.PrimaryPart, tweenInfo, goal)

    --[[

    When restarting the loop it needs the really small duration in order to actually move forward
    I'm always setting the child speed to the parent speed, thus this would never work
    What I need to do is either:

    A) Figure out why there is a really small tween in the first place
    B) Just tween the child cart manually if it's really small

    ]]

    if (wait_duration) and (wait_duration > 0.01) then
        tween:Play()
        self.child_speed = wait_duration
        wait(wait_duration)
    else
        print("0 node tween!")
        -- just in case the tween is 0, otherwise it will probably crash (usually only happens if I mess something else up)
        wait()
    end
end

function train:move_to_positions(positions)
    for k, v in ipairs(positions) do
        self:move_to_position(v)
    end
end

function train:rear_hitch()
    return self.cart_object.rear_hitch
end

function train:front_hitch()
    return self.cart_object.front_hitch
end

function train:move_to_nodes(nodes, parent_cart)
    for k, v in ipairs(nodes) do
        self:move_to_position(v.Position, parent_cart)
    end
end

function train:set_anchor(bool)
    self.cart_object.base.Anchored = bool
end

function train.new(cart_number)
    local new_train = setmetatable({cart_number = cart_number, 
    cart_object = train_model:Clone(), 
    child_speed = 0,
    }, train)

    new_train.cart_object.Parent = game.Workspace -- Set the parent of the cloned train model to the workspace
    return new_train
end

return train