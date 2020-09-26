-- import libraries
Class = require 'class'
push = require 'push'

-- import classes

require 'Map'
require 'Animation'
require 'Player'
require 'Demon'

-- CONSTANTS
-- actual window resolution

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- downscaled resolution
VIRUTAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
-- VIRUTAL_WIDTH = 640
-- VIRTUAL_HEIGHT = 360

-- make upscaling look pixel-ish and not blurry

love.graphics.setDefaultFilter('nearest', 'nearest')

map = Map()

function love.load()
    
    -- set up virtual screen resolution
    push:setupScreen(VIRUTAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fulscreen = false,
        resizable = true
    })
    
    -- set title of window
    love.window.setTitle('Dungeon Crawler 50')

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)

    map:update(dt)

end

function love.draw()

    push:apply('start')

    love.graphics.clear(0, 0, 0, 1)

    love.graphics.translate(math.floor(-map.camx + 0.5), math.floor(-map.camy + 0.5))
    map:render()

    push:apply('end')

end
