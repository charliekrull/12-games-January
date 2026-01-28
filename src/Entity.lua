--[[Something in the game that has components such as a state machine to govern behavior, or traits, etc.

]]

Entity = Class{}

function Entity:init(def) --def contains initial values for x and y
  self.drawHitBox = false
  self.drawPos = false
  
  for c, comp in pairs(def) do
    self[c] = comp  
  end
  
  if self.x == nil then self.x = 0 end
  if self.y == nil then self.y = 0 end
  
  
  self:loadComponents(ENTITY_DEFS[self.entityType])
  if not self.speed then self.speed = 0 end
  
  self.dx = self.velX or 0
  self.dy = self.velY or 0
  
  
  
end


function Entity:update(dt)
  
--  self.x = self.x + self.dx * dt
--  self.y = self.y + self.dy * dt
  
end


function Entity:render()

  love.graphics.setColor(COLORS.white)
  if gTextures[self.entityType] then
    
    love.graphics.draw(gTextures[self.entityType][self.texture], math.floor(self.x), math.floor(self.y), 0, self.scaleX or 1, self.scaleY or 1, self.imgOffsetX or 0, self.imgOffsetY or 0)
    
  
  else
    love.graphics.setColor(COLORS.yellow)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(COLORS.white)
    
  end
    
  
  if self.drawHitBox then
    love.graphics.setColor(COLORS.red)
    if self.hitbox.shape == 'rectangle' then
      love.graphics.rectangle('line', self.x, self.y, self.hitbox.width, self.hitbox.height)
    elseif self.hitbox.shape == 'circle' then
      love.graphics.circle('line', self.x, self.y, self.hitbox.radius)
    end
    
    love.graphics.setColor(COLORS.white)
    
  end
  
 
  
  if self.drawPos then
    love.graphics.setColor(COLORS.blue)
    love.graphics.circle('line', self.x, self.y, 5)
    love.graphics.setColor(COLORS.white)
  end
  
end

function Entity:loadComponents(tbl)
  for c, component in pairs(tbl) do
    self[c] = component  
  end
  
  
end


function Entity:loadAnimations()
  for a, anim in pairs(ENTITY_DEFS[self.entityType].animations) do
    self.animations[a] = Animation(anim)  
  end
  

end

function Entity:changeState(state, params)
  self.stateMachine:change(state, params)
end


function Entity:collides(target) --function for determining if two entities collide. Supports circle and rectangle collision shapes
  local function mixedCollide(cir, rect) --detects a collision between a circle and a rectangle
    local centCir, centRect = {x = cir.x, y = cir.y}, {x = rect.x + rect.hitbox.width/2, y = rect.y + rect.hitbox.height/2}  
    local centToCent = {x = centCir.x - centRect.x, y = centCir.y - centRect.y}
    local closestPoint = {x = clamp(centToCent.x, centRect.x - rect.width/2, centRect.x + rect.width/2), 
                          y = clamp(centToCent.y, centRect.y - rect.height/2, centRect.y+ rect.height/2)}
    return math.sqrt((centCir.x - closestPoint.x) ^ 2 + (centCir.y - closestPoint.y) ^ 2) < cir.hitbox.radius
  end
  
  
  if self.hitbox.shape == 'rectangle' then
    if target.hitbox.shape == 'rectangle' then -- both rectangles, use Axis-Aligned Bounding Boxes
    
  
      return not (self.x > target.x + target.width or target.x > self.x + self.width or
                self.y > target.y + target.height or target.y > self.y + self.height)
              
    elseif target.hitbox.shape == 'circle' then
      mixedCollide(target, self)
      
    end
  elseif self.hitbox.shape == 'circle' then
    
    if target.hitbox.shape == 'rectangle' then
      mixedCollide(self, target)
      
    elseif target.hitbox.shape == 'circle' then -- both circles, determine if the distance between them is less than the sum of their radii
      return math.sqrt((self.x - target.x)^2 + (self.y - target.y)^2) < self.hitbox.radius + target.hitbox.radius
      
    end
    
    
  end
    
end
