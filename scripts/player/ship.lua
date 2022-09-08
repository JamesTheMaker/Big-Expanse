function init()
  message.setHandler("byoshipUpdate", byoshipUpdate, properties)
end

function byoshipUpdate(_, _, properties)
  if type(properties) ~= "table" then
    sb.logInfo("Ship Update Error: Properties is %s", type(properties))
    return -- Don't continue
  end

  sb.logInfo(player.worldId() .. ":" .. player.ownShipWorldId())

  if player.worldId() == player.ownShipWorldId() then
    local shipUpgrades = player.shipUpgrades()
    shipUpgrades.maxFuel = (properties[1] * 100) + 100
    shipUpgrades.crewSize = properties[2]
    shipUpgrades.shipSpeed = (properties[3] * 10) + 1
    if properties[4] > 0 then shipUpgrades.capabilities[2] = "planetTravel" end

    player.upgradeShip(shipUpgrades)
    sb.logInfo("Ship Update sucessful.")
  end
end
