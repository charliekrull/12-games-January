

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 1024


COLORS = {white = {1, 1, 1},
          black = {0, 0, 0},
          red = {1, 0, 0},
          green = {0, 1, 0},
          blue = {0, 0, 1},
          yellow = {1, 1, 0},
          magenta = {1, 0, 1},
          cyan = {0, 1, 1},
          orange = {1, 106/255, 0},
          purple = {165/255, 0, 1}, 
          grey = {0.5, 0.5, 0.5}
          }
function muteColor(color)
  local col = {}
    for k, val in pairs(color) do
      col[k] = val/2
    end
    
    return col
end

TILE_SIZE = 16

CAM_SPEED = 350

ATOM_SIZE = 22