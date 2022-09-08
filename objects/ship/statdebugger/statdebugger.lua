function init()
  sb.logInfo(world.type())
  sb.logInfo("Level: %s", world.getProperty("ship.level"))
  sb.logInfo("World Type: %s", world.type())

  sb.logInfo("Crew Size: %s", world.getProperty("ship.crewSize"))
  sb.logInfo("Fuel: %s", world.getProperty("ship.fuel"))
  sb.logInfo("Max Fuel: %s", world.getProperty("ship.maxFuel"))
  sb.logInfo("Fuel Efficiency: %s", world.getProperty("ship.fuelEfficiency"))
end
