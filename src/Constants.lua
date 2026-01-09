

WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 1024

PLAYER_SPEED = 250

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
          grey = {0.5, 0.5, 0.5},
          sand = {227/255, 198/255, 84/255}
        }
        
        
TILE_SIZE = 32

CAM_SPEED = 350

BODY = {'Feminine', 'Masculine'}

CLOTHING = {Accessories = {'Bowtie'}, 
            Legs = {'Cuffed Pants', 'Hose', 'Leggings', 'Overalls', 'Pants', 'Short Shorts', 'Shorts'},
            'Shoes',
            Torso = {'Buttoned Longsleeve Shirt', 'Buttoned T-shirt', 'Longsleeve Shirt', 'Polo', 'Scoop Longsleeve Shirt',
            'Scoop T-shirt', 'T-shirt', 'V-neck Longsleeve Shirt', 'V-neck T-Shirt'},
            ['Torso 2'] = {'Cardigan', 'Suspenders'}}

SHEETS = {'Climb', 'Combat 1h - Backslash', 'Combat 1h - Halfslash', 'Combat 1h - Idle', 'Combat 1h - Slash', 'Emotes', 'Idle',
          'Jump', 'Run', 'Sitting', 'Walk'}
        
        
HAIR = {'Balding', 'Bangs & Bun', 'Bob, Bangs', 'Bob, Side Part', 'Buzzcut', 'Chevron Mustache', 'Cornrows', 'Cowlick',
        'Curly', 'Dreadlocks', 'Flat Top, Fade', 'Flat Top', 'Handlebar Mustache', 'Horseshoe Mustache', 'Idol', 'Lampshade Mustache',
        'Medium Beard', 'Natural', 'Page', 'Parted', 'Thick Eyebrows', 'Thin Eyebrows', 'Trimmed Beard', 'Twists, Fade', 'Twists', 'Walrus Mustache'}
      
HEAD = {'Elderly', 'Feminine', 'Head Overlay - Eyes', 'Head Overlay - Large Nose', 'Masculine'}

HEAD_ACCESSORIES = {'Eyepatch', 'Glasses', 'Halfmoon Glasses'}


CHARACTER_PARTS = {['Body'] = BODY, ['Clothing'] = CLOTHING, ['Head'] = HEAD, ['Hair'] = HAIR, ['Head Accessories'] = HEAD_ACCESSORIES} -- in render order