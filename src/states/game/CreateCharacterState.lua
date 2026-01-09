--[[
The character customizer

]]

CreateCharacterState = Class{__includes = BaseState}

function CreateCharacterState:init()
 self.currentFolder = gTextures.entities
 self.currentFramesFolder = gFrames.entities
 self.trail = {}
 
 self.currentOption = 1
 self.categories = {'Body', 'Clothing', 'Head', 'Hair', 'Head Accessories'}
 self.currentCategory = 1
 self.clothingSubcats = {'Accessories', 'Legs', 'Torso', 'Torso 2'}
 self.currentSubcat = 1
 
 self.body = 1
 self.head = 1
 self.hair = 1
 self.clothing = {}
 
 self:getGFramesEq('graphics/entities')
 
end


function CreateCharacterState:enter()
  self:setUpPaths('graphics/entities')
  self.bodySprite = self:loadSprite(gTextures.entities.Body.Feminine[7])
end


function CreateCharacterState:update(dt)
  if love.keyboard.wasPressed('left') then
    
    self.currentOption = self.currentOption - 1
  end
  
  if love.keyboard.wasPressed('right') then
    
    self.currentOption = self.currentOption + 1
    
  end
  
  if love.keyboard.wasPressed('down') then
    self.currentCategory = self.currentCategory + 1  
  end
  
  if love.keyboard.wasPressed('up') then
    
    self.currentCategory = self.currentCategory - 1
    
  end
  
  if self.currentCategory > #self.categories then
    self.currentCategory = 1
    
  elseif self.currentCategory <= 0 then
    
    self.currentCategory = #self.categories
  end
  
  if self.currentOption > #CHARACTER_PARTS[self.categories[self.currentCategory]] then
    
    self.currentOption = 1
    
  elseif self.currentOption <= 0 then
    self.currentOption = #CHARACTER_PARTS[self.categories[self.currentCategory]]
    
  end
  
  
  
end

function CreateCharacterState:render()
  love.graphics.clear(COLORS.sand)
  love.graphics.setFont(gFonts.xlarge)
  love.graphics.setColor(COLORS.black)
  love.graphics.printf('Create your character.', 0, WINDOW_HEIGHT * 0.1, WINDOW_WIDTH, 'center')
  love.graphics.setColor(COLORS.white)
  
  --display the possible bodies, clothes, hair, etc.
  love.graphics.setFont(gFonts.large)
  for c, cat in pairs(self.categories) do
    if cat == self.categories[self.currentCategory] then
      
      love.graphics.setColor(COLORS.blue)
    else
      love.graphics.setColor(COLORS.black)
      
    end
    
    love.graphics.printf(cat, 0, math.floor(WINDOW_HEIGHT * 0.3) + (love.graphics.getFont():getHeight() * (c-1)), math.floor(WINDOW_WIDTH / 3), 'center')
  
  love.graphics.setColor(COLORS.white)
  end
  
  if self.categories[self.currentCategory] == 'Clothing' then
    
    love.graphics.setColor(COLORS.black)
      for s, subcat in pairs(self.clothingSubcats) do
        if subcat == self.clothingSubcats[self.currentSubcat] then
          love.graphics.setColor(COLORS.blue)
          
        else
          love.graphics.setColor(COLORS.black)
          
        end
        
        love.graphics.printf(subcat, math.floor(WINDOW_WIDTH*0.7), math.floor(WINDOW_HEIGHT * 0.3) + (love.graphics.getFont():getHeight() * (s - 1)), math.floor(love.graphics.getFont():getWidth('Accessories')), 'center')
        
      end
    
  end
  
  love.graphics.setColor(COLORS.white)
  love.graphics.draw(self.bodySprite, math.floor(WINDOW_WIDTH/2), math.floor(WINDOW_HEIGHT/2))
  
end

function CreateCharacterState:loadSprite(t) --t is a texture from gTextures. gTextures.entities.Body.Masculine[7] for example
  if type(t) == 'string' then
    local img = love.graphics.newImage(t)
    local frames = self:getGFramesEq(t)
    table.insert(frames, GenerateQuads(img, TILE_SIZE, TILE_SIZE))
    return img
    
  else
    return t
    
  end
  
    
end


function CreateCharacterState:setUpPaths(path) --iterates through path and sets up a table identical to the file structure, stores the paths/locations of files as a string when it reaches the bottom layer ofnesting
  
  local dir = path -- since we are going to concatenate some strings, we need to store path to track both the original argument and the concatenated string
  local fDir = gFrames['entities']
  
  for i, item in pairs(love.filesystem.getDirectoryItems(path)) do
    local info = love.filesystem.getInfo(dir..'/'..item)
    
    
    if info.type == 'file' then
      
      table.insert(self.currentFolder, dir..'/'..item)
      self.currentFramesFolder[item] = {}
      
    elseif info.type == 'directory' then
    
      self.currentFolder[item] = {}
      self.currentFramesFolder[item] = {}
      table.insert(self.trail, self.currentFolder)
      self.currentFolder = self.currentFolder[item]
      self.currentFramesFolder = self.currentFramesFolder[item]
      
      local dir = dir..'/'..item
      
      self:setUpPaths(dir)
      
      
    end
    
  end
  
  self.currentFolder = self.trail[#self.trail]
  table.remove(self.trail, #self.trail)

  
end

function CreateCharacterState:getGFramesEq(filepath)
  local landmarks = {}
  local currentMark = ''
  
  for i = 1, #filepath do
    local char = filepath:sub(i, i)
    if char ~= '/' then
      currentMark = currentMark..char
      
    else
      table.insert(landmarks, currentMark)
      currentMark = ''
    end
    
  end
  table.insert(landmarks, currentMark)
  
  
  local step = gFrames
  for m, mark in pairs(landmarks) do
    step = step[mark]
  end
  
  return step
  
  

end