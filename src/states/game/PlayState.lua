--[[

Main state where the game is running

]]

PlayState = Class{__includes = BaseState}

function PlayState:init(def)
  self.map = sti('graphics/TileMaps/TestDesert.lua')
  self.camX = (self.map.layers[1].width * TILE_SIZE)/ 2 - WINDOW_WIDTH/2
  self.camY = (self.map.layers[1].height * TILE_SIZE) / 2 - WINDOW_HEIGHT/2
end

function PlayState:update(dt)
  self.map:update(dt)
  self:updateCamera(dt)
end

function PlayState:render()
  love.graphics.setColor(COLORS.white)
  self.map:draw(-math.floor(self.camX), -math.floor(self.camY))
  
  love.graphics.setColor(COLORS.red)
  love.graphics.setFont(gFonts.medium)
  love.graphics.print(math.floor(self.camX), TILE_SIZE, TILE_SIZE)
  love.graphics.print(math.floor(self.camY), TILE_SIZE * 4, TILE_SIZE)
end

function PlayState:updateCamera(dt)
  if love.keyboard.isDown('up') then
    
    self.camY = self.camY - CAM_SPEED * dt
  end
  
  if love.keyboard.isDown('right') then
    self.camX = self.camX + CAM_SPEED * dt
    
  end
  
  if love.keyboard.isDown('down') then
    self.camY = self.camY + CAM_SPEED * dt
  end
  
  if love.keyboard.isDown('left') then
    self.camX = self.camX - CAM_SPEED * dt
  end
  
  self.camX = clamp(self.camX, 0, (self.map.layers[1].width * TILE_SIZE) - WINDOW_WIDTH)
  self.camY = clamp(self.camY, 0, (self.map.layers[1].height * TILE_SIZE) - WINDOW_HEIGHT)
 
end

  