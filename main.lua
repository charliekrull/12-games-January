--[[
January 2026 entry for the 12 games in 12 months resolution/challenge/ordeal

]]


require 'src/Dependencies'


function love.load() -- called once when the game starts
  io.stdout:setvbuf("no") -- turn off buffering for text so we can see everything we print to console immediately.

  math.randomseed(os.time())
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {resizable = true}) -- open the game window
  love.window.setTitle('January')
  
  love.keyboard.keysPressed = {}
  love.mouse.clicks = {}
  
  
  gFonts = {small = love.graphics.newFont('fonts/PlayfairDisplay-Regular.ttf', 12),
            medium = love.graphics.newFont('fonts/PlayfairDisplay-Regular.ttf', 18),
            large = love.graphics.newFont('fonts/PlayfairDisplay-Regular.ttf', 24),
            xlarge = love.graphics.newFont('fonts/PlayfairDisplay-Regular.ttf', 48),
            title = love.graphics.newFont('fonts/cinzel.regular.otf', 64)
          }
          
  gTextures = {['MainMenuBG'] = love.graphics.newImage('graphics/MainMenuBG.png'),
                ['atom'] = {}
                
              }
              
  for i = 1, 12 do -- load in the atom images
    gTextures.atom[i] = love.graphics.newImage('graphics/Atoms/Orb_'..tostring(i)..'.png')
  end
  
  
  

  
            
--  gFrames = {
--              }
  
 
  
 
  gStateMachine = StateMachine{['main-menu'] = function() return MainMenuState() end,
                                ['play'] = function() return PlayState() end}
  gStateMachine:change('main-menu')
end

function love.update(dt) -- called once a frame
  
  if love.keyboard.wasPressed('escape') then
    
    love.event.quit()
    
  end
  
  gStateMachine:update(dt)
  
  
  love.keyboard.keysPressed = {}
  love.mouse.clicks = {}
end

function love.draw() -- called once a frame
  gStateMachine:render()
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]  
end


function love.mousepressed(x, y, button)
  love.mouse.clicks[button] = {x = x, y = y} 
  
end
