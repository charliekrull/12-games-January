--[[  State when the game starts up, has the main menu and leads to the game proper, options, etc.

]]

MainMenuState = Class{__includes = BaseState}

function MainMenuState:init()

  self.options = {'Play', 'options', 'credits'}
  self.currentOpt = 1
end

function MainMenuState:update(dt)
  if #love.mouse.clicks > 0 then
    
  end
  
  if love.keyboard.wasPressed('up' or 'w') then
    self.currentOpt = self.currentOpt - 1
    if self.currentOpt <= 0 then
      
      self.currentOpt = #self.options
    end
    
  end
  
  if love.keyboard.wasPressed('down' or 's') then
    
    self.currentOpt = self.currentOpt + 1
    if self.currentOpt > #self.options then
      
      self.currentOpt = 1
      
    end
    
    
  end
  
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    if self.options[self.currentOpt] == 'Play' then 
      gStateMachine:change('create-character')
      
    end
    
      
  end
  

  
  
end

function MainMenuState:render()
  love.graphics.clear(COLORS[self.bgColor])
  
  local bg = gTextures.MainMenuBG
  
  love.graphics.draw(bg, 0, 0)
  
  
  --display title
  love.graphics.setFont(gFonts.title)
  
  love.graphics.setColor(COLORS.black)
  love.graphics.printf('That One Time I Hid from a Spaceship', 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, 'center')
  
  love.graphics.setFont(gFonts.xlarge)
  for key = 1, #self.options do
    if key == self.currentOpt then
      love.graphics.setColor(COLORS.blue)
    else
      love.graphics.setColor(COLORS.black)
    end
    
    love.graphics.printf(self.options[key], 0, (WINDOW_HEIGHT * 0.66) + (key-1) * gFonts.xlarge:getHeight(), WINDOW_WIDTH, 'center')
  end
  love.graphics.setColor(COLORS.white)
end
