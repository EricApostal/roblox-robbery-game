local TweenService = game:GetService("TweenService")
-- local part = game.Workspace:WaitForChild("train").train.PrimaryPart
local train_model = game.Workspace:WaitForChild("train").train

--[[
    Movement
]]

local speed = 80
local cart_distance = 9

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
    

    if (dist/speed) and (dist/speed > 0) then
        tween:Play()
        wait(dist/speed)
    else
        -- print("uh oh, bad tween wait: ")
        -- print("dist = " .. dist)
        -- print("speed = " .. speed)
        wait()
    end
end

function train:move_to_positions(positions)
    for k, v in ipairs(positions) do
        self:move_to_position(v)
    end
end

    
function train:move_to_node(node, nodes)
    local num_nodes = #nodes

    local child_index = node - cart_distance
    if child_index <= 0 then
        child_index = child_index + num_nodes
    end

    self.child_node = child_index
    self:move_to_position(nodes[node].Position)
end

function train:move_to_nodes(nodes)
    local num_nodes = #nodes

    for k, v in ipairs(nodes) do
        local child_index = k - cart_distance
        if child_index <= 0 then
            child_index = child_index + num_nodes
        end

        self.child_node = child_index
        self:move_to_position(v.Position)
    end
end



function train.new(cart_number)
    local new_train = setmetatable({cart_number = cart_number, cart_object = train_model:Clone(), child_node = 1}, train)
    new_train.cart_object.Parent = game.Workspace -- Set the parent of the cloned train model to the workspace
    return new_train
end


return train