require "/scripts/shiputil.lua"

function init()
  self.flyingBoosterStates = config.getParameter("flyingBoosterStates")
end

function update(dt)
  local drives = world.getProperty("ship.drives") or 0

  if drives * 3 >= (world.getProperty("ship.thrusters") or 0) + 1 then -- If there is capacity for thruster
    if not storage.applied or false then -- If stats haven't already been applied
      world.setProperty("ship.thrusters", (world.getProperty("ship.thrusters") or 0) + 1) -- Increment fuel tanks by 1
      storage.applied = true
      shiputil.update() -- Update stats
    end
  else -- If there is not capacity
    if storage.applied or false then -- And it's been applied somehow (maybe a drive was deleted)
      world.setProperty("ship.thrusters", (world.getProperty("ship.thrusters") or 0) - 1) -- Decrement fuel tanks by 1
      storage.applied = false
      shiputil.update() -- Update stats
    end
  end

  if not storage.applied or false then
    animator.setAnimationState("boosterState", "offline")
  else
    local newFlyingType = world.flyingType()
    if newFlyingType ~= storage.flyingType then
      animator.setAnimationState("boosterState", self.flyingBoosterStates[newFlyingType])
      storage.flyingType = newFlyingType
    end
  end
end

function die()
  if storage.applied == false then return end -- If thruster offline, don't do

  world.setProperty("ship.thrusters", (world.getProperty("ship.thrusters") or 0) - 1) -- Decrement fuel tanks by 1
  storage.applied = false
  shiputil.update() -- Update stats
end
