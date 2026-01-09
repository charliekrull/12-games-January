--[[
  
  Definitions of all the entities, naturally. The Entity's init function will use the appropriate key as it's 'components' argument
  

]]

ENTITIES = { player = {width = TILE_SIZE,
                        height = TILE_SIZE * 2,
                        speed = PLAYER_SPEED
                        canvas = love.graphics.newCanvas(TILE_SIZE, TILE_SIZE * 2}
  }