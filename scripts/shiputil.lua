shiputil = { }

function shiputil.update()
  local players = world.players()
  local properties = {
    world.getProperty("ship.fuelTanks", 0),
    world.getProperty("ship.crewBunks", 0),
    world.getProperty("ship.thrusters", 0),
    world.getProperty("ship.drives", 0)
  }

  sb.logInfo("Ship Update:")
  sb.logInfo("Fuel Tanks: %s", properties[1])
  sb.logInfo("Crew Bunks: %s", properties[2])
  sb.logInfo("Thrusters: %s", properties[3])
  sb.logInfo("Drives: %s", properties[4])

  for _, player in pairs(players) do
    world.sendEntityMessage(player, "byoshipUpdate", properties)
  end
end
