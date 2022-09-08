function init()
  item.consume(1)

  if config.getParameter("techUnlock", nil) ~= nil then
    player.makeTechAvailable(config.getParameter("techUnlock"))
    player.enableTech(config.getParameter("techUnlock"))
  end
end
