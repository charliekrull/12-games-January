--[[
The character customizer

]]

CreateCharacterState = Class{__includes = BaseState}

function CreateCharacterState:init()
 self.currentFolder = gTextures.entities
 self.trail = {} 
end


function CreateCharacterState:enter()
  self:loadSprites('graphics/entities')
  
end


function CreateCharacterState:update(dt)
  
end

function CreateCharacterState:render()
  love.graphics.clear(COLORS.sand)
  love.graphics.setFont(gFonts.xlarge)
  love.graphics.setColor(COLORS.black)
  love.graphics.printf('Create your character.', 0, WINDOW_HEIGHT * 0.1, WINDOW_WIDTH, 'center')
  love.graphics.setColor(COLORS.white)
end

function CreateCharacterState:loadSprites(path)
  local dir = path -- since we are going to concatenate some strings, we need to store path to track both the original argument and the concatenated string
  
  
  for i, item in pairs(love.filesystem.getDirectoryItems(path)) do
    local info = love.filesystem.getInfo(dir..'/'..item)
    
    
    if info.type == 'file' then
      
      table.insert(self.currentFolder, love.graphics.newImage(dir..'/'..item))
      
    elseif info.type == 'directory' then
    
      self.currentFolder[item] = {}
      table.insert(self.trail, self.currentFolder)
      self.currentFolder = self.currentFolder[item]
      local dir = dir..'/'..item
      
      self:loadSprites(dir)
      
      
    end
    
  end
  
  self.currentFolder = self.trail[#self.trail]
  table.remove(self.trail, #self.trail)

  
end

function CreateCharacterState:customizeCharacter()
  
  local options = CHARACTER_PARTS
  
  
  
  
  
end
 

