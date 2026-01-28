--a collider, just a component to determine if it collides with another hitbox

HitBox = Class{}

function HitBox:init(def)
  self.x = def.x
  self.y = def.y
  self.width = def.width
  self.height = def.height
  
end
