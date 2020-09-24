-- import libraries
Class = require 'class'
push = require 'push'
sti = require 'sti'

-- import classes

require 'Player'

-- CONSTANTS
-- actual window resolution

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- downscaled resolution

VIRUTAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

-- make upscaling look pixel-ish and not blurry

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    
    -- set up virtual screen resolution
    push:setupScreen(VIRUTAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fulscreen = false,
        resizable = true
    })
    
    -- set title of window
    love.window.setTitle('Dungeon Crawler 50')

    -- load map
    map = sti('Tiled-test-map/test-map.lua')

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    map:update(dt)
end

function love.draw()

    push:apply('start')

    love.graphics.clear(1, 1, 1, 1)

    map:draw()

    push:apply('end')

end
