require "/scripts/shiputil.lua"

function init()
  if world.type() ~= "unknown" then return end -- Check if spaceship or not
  if storage.applied then return end -- If modifications have been applied, end here

  storage.property = config.getParameter("property", nil)

  world.setProperty(storage.property, (world.getProperty(storage.property) or 0) + 1) -- Increment fuel tanks by 1
end

function update()
  if storage.applied then return end -- If modifications have been applied, end here

  storage.applied = true
  shiputil.update() -- Update stats
end

function die()
  if world.type() ~= "unknown" then return end -- Check if spaceship or not

  world.setProperty(storage.property, (world.getProperty(storage.property) or 0) - 1) -- Decrement fuel tanks by 1
  storage.applied = false
  shiputil.update() -- Update stats
end
