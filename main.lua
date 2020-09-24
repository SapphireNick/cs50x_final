-- import libraries
Class = require 'class'
push = require 'push'

-- import classes

require 'Player'

-- CONSTANTS
-- actual window resolution

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- close resolution to NES but 16:9

VIRUTAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- make upscaling look pixel-ish and not blurry

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)

end

function love.draw()

end
