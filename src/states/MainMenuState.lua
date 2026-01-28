--[[  State when the game starts up, has the main menu and leads to the game proper, options, etc.

]]

MainMenuState = Class{__includes = BaseState}

function MainMenuState:init()

  self.options = {'Play', 'options', 'credits'}
  self.currentOpt = 1
end

function MainMenuState:update(dt)
  
  self.currentOpt = self:determineCurrent()
  if love.mouse.clicks[1] then
    if self.currentOpt == 1 then
      gStateMachine:change('play', {})
    end
    
  end
  
  
  
  
end

function MainMenuState:render()
  love.graphics.clear(COLORS[self.bgColor])
  
  local bg = gTextures.MainMenuBG
  
  love.graphics.draw(bg, 0, 0)
  
  
  --display title
  love.graphics.setFont(gFonts.title)
  
  love.graphics.setColor(COLORS.purple)
  love.graphics.printf('Trap', 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, 'center')
  
  love.graphics.setFont(gFonts.xlarge)
  for key = 1, #self.options do
    if key == self.currentOpt then
      love.graphics.setColor(COLORS.yellow)
    else
      love.graphics.setColor(COLORS.white)
    end
    
    love.graphics.printf(self.options[key], 0, (WINDOW_HEIGHT * 0.66) + (key-1) * gFonts.xlarge:getHeight(), WINDOW_WIDTH, 'center')
  end
  love.graphics.setColor(COLORS.white)
end


function MainMenuState:determineCurrent()
  local mouseX, mouseY = love.mouse.getPosition()
  
  if mouseY < WINDOW_HEIGHT*0.66 then
    return 1
    
  elseif mouseY > WINDOW_HEIGHT*0.66 + #self.options * gFonts.xlarge:getHeight() then
    return #self.options
    
  else
    return math.floor((mouseY - WINDOW_HEIGHT*0.66) / gFonts.xlarge:getHeight() + 1)
  end
  

  
end
