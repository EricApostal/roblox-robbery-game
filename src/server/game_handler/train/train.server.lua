--[[
    File for controlling train movements
]]

local train = require(script.Parent.train_movement)
local nodes = game.Workspace:WaitForChild("train").train_nodes

function make_positions()
  --[[
      Generates a circle of nodes for the train to follow

      Partially generated by google bard
  ]]
  local positions = {}
  local radius = 300
  local offset = 200
  local num_nodes = 600
  local step = 360 / num_nodes

  for angle = 0, 360, step do
    local x = radius * math.cos(angle * math.pi / 180) + offset
    local z = radius * math.sin(angle * math.pi / 180) + offset
    table.insert(positions, Vector3.new(x, 0, z))
  end

  for index, position in ipairs(positions) do
    local part = Instance.new("Part")
    part.Position = position
    part.Parent = nodes
    part.Anchored = true
    part.Transparency = 1
  end
end

make_positions()

local nodelist = {}
for k,v in nodes:GetChildren() do
	table.insert(nodelist, v)
end

function do_node_thing(cart, parent)
  coroutine.wrap(function()
    if not parent then
      while true do
        cart:move_to_nodes(nodelist)
      end
    else 
      while true do
        cart:move_to_nodes(nodelist, parent)
        local magnitude = math.abs((cart:front_hitch().Position - parent:rear_hitch().Position).Magnitude)
        print("magnitude = ")
        print(magnitude)
      end

    end
  end)()
end

function spawn_train(length)
  local head = train.new()
  local carts = {}

  table.insert(carts, head)
  do_node_thing(head)

  for i = 2, length do
    local cart = train.new()
    local parent = carts[i-1]
    local RodConstraintInstance = Instance.new("RodConstraint")
    RodConstraintInstance.Attachment0 = Instance.new("Attachment", cart:front_hitch())
    RodConstraintInstance.Attachment1 = Instance.new("Attachment", parent:rear_hitch())
    RodConstraintInstance.Length = 5
    RodConstraintInstance.Enabled = true
    RodConstraintInstance.LimitsEnabled = true
    RodConstraintInstance.Visible = true
    RodConstraintInstance.Parent = game.Workspace

    wait(2)

    do_node_thing(cart, carts[i-1])
    carts[#carts + 1] = cart
  end
end

--[[
  New idea

  Make it so that it follows the nodes like normal, 
  but if it's following another cart follow nodes
  but match the speed of the parent

]]

wait(5)

spawn_train(10)