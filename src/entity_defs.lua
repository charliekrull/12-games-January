--[[
  
  Definitions of all the entities, naturally. The Entity's init function will use the appropriate key as it's 'components' argument
  

]]

ENTITY_DEFS = { atom = {speed = 400, scaleX = 32/175, scaleY = 32/180, imgOffsetX = 87, imgOffsetY = 90,
                        hitbox = {shape = 'circle', radius = 10}},
                wall = {speed = 0, hitbox = {shape = 'rectangle', width = TILE_SIZE * 2, height = TILE_SIZE * 2, growSpeed = 100}}
  }
  