--[[

Main state where the game is running

]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
  self.board = { width = WINDOW_WIDTH, height = WINDOW_HEIGHT * 0.875, entities = {}, percentCleared = 0, areaContains = function(area, target)--area is a table with an x, y, width and height and target is what we're testing to see if it's in the area
                                  return not (area.x > target.x + target.width or target.x > area.x + area.width or
                                            area.y > target.y + target.height or target.y > area.y + area.height)
                              end}
                              
  
  
end

function PlayState:enter(params)
  self.bg = params.bg or math.random(1, 29)
  self.bgColor = params.bgColor or COLORS[table.randomKey(COLORS)]
  if self.bgColor == COLORS.black then self.bgColor = COLORS.white end
  local mute = false
  for k, val in pairs(self.bgColor) do
    
    if val >= 0.5 then
      mute = true  
    end
    
  end
  if mute then self.bgColor = muteColor(self.bgColor) end
  self.score = params.score or 0
  self.level = params.level or 1
  self.lives = math.min(self.level + 1, 50)
  


  for i = 1, self.lives + 20 do
    local xComp = math.random() * (math.random(2) == 1 and 1 or -1)
    local yComp = (1 - math.abs(xComp)) * (math.random(2) == 1 and 1 or -1)
    self.board.entities[i] = Entity{entityType = 'atom', x = math.random(64, self.board.width - 64), y = math.random(64, self.board.height - 64),
                                      texture = math.random(6), velX = xComp * ENTITY_DEFS.atom.speed,
                                      velY = yComp * ENTITY_DEFS.atom.speed}
    
  end
  table.insert(self.board.entities, Entity{entityType = 'wall', x = self.board.width/2, y = self.board.height/2, width = TILE_SIZE * 2, height = TILE_SIZE * 2 })
  
  
end

function PlayState:update(dt)
  for e, ent in pairs(self.board.entities) do
    ent.x = ent.x + ent.dx * dt
    
    ent.y = ent.y + ent.dy * dt
    
    if ent.hitbox then
      for e2, ent2 in pairs(self.board.entities) do
        if ent2.hitbox and ent:collides(ent2) and ent ~= ent2 then
          ent.x = ent.x - ent.dx * dt
          ent.y = ent.y - ent.dy * dt
          print('boing')
          if ent2.entityType == 'atom' then -- the ball hit another ball
            local tempX, tempY = ent.dx, ent.dy
            ent.dx, ent.dy = ent2.dx, ent2.dy
            ent2.dx, ent2.dy = tempX, tempY
          
          elseif ent2.entityType == 'wall' then -- the ball hit a player-built wall
            
              --calculate direction of collision
            local entCenter = (ent.hitbox.shape == 'circle' and {x = ent.x, y = ent.y} or {x = ent.x + ent.width/2, y = ent.y + ent.height/2})
            local ent2Center = (ent2.hitbox.shape == 'circle' and {x = ent2.x, y = ent2.y} or {x = ent2.x + ent2.width/2, y = ent2.y + ent2.height/2})
            
            local entVel = {x = ent.x * ent.dx, y = ent.y * ent.dy}
            local ent2Vel = {x = ent2.x * ent2.dx, y = ent2.y * ent.dy}
            
            local collisionDir = {x = entVel.x + ent2Vel.x, y = entVel.y + ent2Vel.y}
            
            
            local dirs = {up = {x = 0.0, y = 1.0}, right = {x = 1.0, y = 0.0}, down = {x = 0.0, y = -1.0}, left = {x = -1.0, y = 0.0}}
            
            local maxDir = ''
        
            
            for d, dir in pairs(dirs) do
              --calculate the dot product
              local result = 0
              for t, term in pairs(collisionDir) do
                result = result + collisionDir.x * dir.x
              end
              if result > maxDir then maxDir = d end
           
            end
            
            
            if maxDir == 'up' or maxDir == 'down' then
              ent.dy = -ent.dy
              
            elseif maxDir == 'right' or maxDir == 'left' then
              ent.dx = -ent.dx
              
            end
          
          end
        
          
        end
        
        
        
      end
      
    end
    
    if ent.x < 0 then
      ent.x = 0
      ent.dx = -ent.dx
    elseif ent.x > self.board.width  - (ent.hitbox.shape == 'circle' and ent.hitbox.radius or ent.hitbox.width) then
      ent.x = self.board.width  - (ent.hitbox.shape == 'circle' and ent.hitbox.radius or ent.hitbox.width)
      ent.dx = -ent.dx
      
    end
    
    if ent.y < 0 then
      ent.y = 0
      ent.dy = -ent.dy
      
    elseif ent.y > self.board.height - (ent.hitbox.shape == 'circle' and ent.hitbox.radius or ent.hitbox.height) then
      ent.y = self.board.height - (ent.hitbox.shape == 'circle' and ent.hitbox.radius or ent.hitbox.height)
      ent.dy = -ent.dy
    end
      
      
    
  end
  
end

function PlayState:render()
  
  love.graphics.setColor(0.66, 0.66, 0.66)
  love.graphics.rectangle('fill', 0, 0, self.board.width, self.board.height)
  love.graphics.setColor(COLORS.grey)
  love.graphics.setLineWidth(1)
  
  for y = 0, WINDOW_HEIGHT - TILE_SIZE, TILE_SIZE do
    love.graphics.line(0, y, self.board.width, y)
    for x = 0, WINDOW_WIDTH - TILE_SIZE, TILE_SIZE do
      love.graphics.line(x, 0, x, self.board.height)
     
     
     
    end
  end
  
  
  for e, ent in pairs(self.board.entities) do
    ent:render()  
  end
  
  love.graphics.setColor(0.25, 0.25, 0.25)
  love.graphics.rectangle('fill', 0, self.board.height, WINDOW_WIDTH, WINDOW_HEIGHT * 0.2)
  love.graphics.rectangle('fill', 0, self.board.height, WINDOW_WIDTH, WINDOW_HEIGHT * 0.2)
  
  love.graphics.setFont(gFonts.large)
  love.graphics.setColor(COLORS.red)
  love.graphics.printf('Lives: '..tostring(self.lives), 8, self.board.height + 40, WINDOW_WIDTH, 'left')
  love.graphics.printf('Score: '..tostring(self.score), 0, self.board.height + 40, WINDOW_WIDTH, 'center')
  
  love.graphics.setColor(COLORS.white)
  
  
end

function startWall(x, y, o)
  if o == 'vertical' then
  
    local w = ENTITY{entityType = 'wall', x = x, y = y}
  
  elseif o == 'horizontal' then
  
  
  end
  
end
