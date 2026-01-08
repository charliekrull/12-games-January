--[[Something in the game that has components such a state machine to govern behavior, or traits, etc.

]]

Entity = Class{}

function Entity:init(x, y, components)
  self.x = x
  self.y = y
  
  self.dx = 0
  self.dy = 0
  
  for c, comp in pairs(components) do
    self[c] = comp  
  end
  
end




