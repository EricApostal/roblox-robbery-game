--!strict

local TweenService = game:GetService("TweenService")
-- local part = game.Workspace:WaitForChild("train").train.PrimaryPart
local train_model = game.Workspace:WaitForChild("train").train

--[[
    Movement
]]

local speed: number = 80
local cart_dist: number = 48

local train = {}
train.__index = train

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

function smoother(x)
    return math.tanh(x)
end

--@param self: train
function train.move_to_position(self: train, pos: Vector3, parent_cart: any )

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
        local magnitude = (self.cart_object.base.Position - parent_cart.cart_object.base.Position).Magnitude
        local dist_error = cart_dist - magnitude
        
        -- Set the sensitivity of the tanh function using a scaling factor (adjust this value as needed)
        local scaling_factor: number = 0.1
        local modifier: number = 1
        
        -- Set an offset to control the minimum value of the modifier (adjust this value as needed)
        local offset: number = 0.1
        -- print("error = " .. dist_error)

        if (math.abs(dist_error) > 1) and not self.distance_calibrated then
            modifier = 1 + smoother(scaling_factor * dist_error) * offset
        -- else
            -- print("error is fine, calibration stopped")
            -- self.distance_calibrated = true
        end

        wait_duration = (parent_cart.child_speed) * modifier

    end

    local tweenInfo = TweenInfo.new(wait_duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(self.cart_object.PrimaryPart, tweenInfo, goal)

    if (wait_duration) and (wait_duration > 0.0000001) then
        tween:Play()
        self.child_speed = wait_duration

        --[[[
            BruhhhH nah I don't even know anymore

            this WAIT STATEMENT was the issue. Literally like bruh. It would jitter because it would wait slightly too long
        ]]
        wait(wait_duration*.8)
    else
        print("0 node tween!")
        -- just in case the tween is 0, otherwise it will probably crash (usually only happens if I mess something else up)
        wait()
    end
end


function train:set_anchor(bool)
    self.cart_object.base.Anchored = bool
end

function train.new(cart_number)
    local new_train = setmetatable({cart_number = cart_number, 
    cart_object = train_model:Clone(), 
    child_speed = 0,
    distance_calibrated = false -- is the distance between self and the parent cart calibrated?
    }, train)

    if (cart_number ~= -1) then
        new_train.cart_object.Parent = game.Workspace -- Set the parent of the cloned train model to the workspace
    end
    return new_train
end

-- mock train for type checking
type train = typeof(train.new(-1))

return train