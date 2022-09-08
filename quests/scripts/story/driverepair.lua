 -- Do this --

require "/scripts/util.lua"
require "/quests/scripts/questutil.lua"
require "/scripts/vec2.lua"
require "/quests/scripts/portraits.lua"

function init()
  storage.complete = storage.complete or false
  self.compassUpdate = config.getParameter("compassUpdate", 0.5)
  self.descriptions = config.getParameter("descriptions")

  self.driveRepairItem = config.getParameter("driveRepairItem")
  self.driveRepairCount = config.getParameter("driveRepairCount")

  self.driveItem = config.getParameter("driveItem")

  self.techstationUid = config.getParameter("techstationUid")

  storage.bookmarked = storage.bookmarked or false

  setPortraits()

  storage.stage = storage.stage or 1
  self.stages = {
    collectResource,
    collectCoreFragment,
    repairDrive
  }

  self.state = FSM:new()
  self.state:set(self.stages[storage.stage])
end

function questInteract(entityId)
  if self.onInteract then
    return self.onInteract(entityId)
  end
end

function questStart()
  player.upgradeShip(config.getParameter("shipUpgrade"))
end

function update(dt)
  self.state:update(dt)

  if storage.complete then
    quest.complete()
  end
end

function collectResource()
  quest.setCompassDirection(nil)

  while storage.stage == 1 do
    quest.setObjectiveList({{self.descriptions.collectResource, false}})
    quest.setProgress(player.hasCountOfItem(self.driveRepairItem) / self.driveRepairCount)
    if player.hasItem({name = self.driveRepairItem, count = 1}) then
      storage.stage = 2
    end
    coroutine.yield()
  end

  quest.setObjectiveList({})

  self.state:set(self.stages[storage.stage])
end

function collectCoreFragment()
  quest.setCompassDirection(nil)

  while storage.stage == 2 do
    quest.setObjectiveList({{self.descriptions.collectCoreFragment, false}})
    quest.setProgress(player.hasCountOfItem(self.driveRepairItem) / self.driveRepairCount)
    if player.hasItem({name = self.driveRepairItem, count = self.driveRepairCount}) then
      storage.stage = 3
    end
    coroutine.yield()
  end

  quest.setObjectiveList({})

  self.state:set(self.stages[storage.stage])
end

function repairDrive()
  quest.setCompassDirection(nil)

  while storage.stage == 3 do
    quest.setObjectiveList({{self.descriptions.repairDrive, false}})
    quest.setProgress(player.hasCountOfItem(self.driveItem))
    if player.hasItem({name = self.driveItem, count = 1}) then
      storage.complete = true
    end
    coroutine.yield()
  end

  quest.setObjectiveList({})

  self.state:set(self.stages[storage.stage])
end

function questComplete()
  setPortraits()
  player.addTeleportBookmark(config.getParameter("outpostBookmark"))

  questutil.questCompleteActions()
end
