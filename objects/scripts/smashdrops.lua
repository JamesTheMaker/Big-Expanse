function die()
  smashDrops = config.getParameter("smashDrops", {})

  for _, drop in pairs(smashDrops) do
    world.spawnItem(drop[1], object.position(), drop[2] or 1)
  end
end
