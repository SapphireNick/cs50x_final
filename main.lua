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

gamestate = 'start'

function love.load()

    love.graphics.setFont(love.graphics.newFont('fonts/font.ttf'), 32)
    
    -- set up virtual screen resolution
    push:setupScreen(VIRUTAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fulscreen = false,
        resizable = true
    })
    
    -- set title of window
    love.window.setTitle('Dungeon Crawler 50')

    map:load_enemies()

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end

function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.update(dt)

    if gamestate == 'play' then
        map:update(dt)

        love.keyboard.keysPressed = {}
        love.keyboard.keysReleased = {}
    end

end

function love.draw()

    push:apply('start')

    love.graphics.clear(0, 0, 0, 1)

    if gamestate == 'start' then
        love.graphics.clear(0, 0, 0, 1)
        love.graphics.draw(love.graphics.newImage('background/Background.png'))
        love.graphics.printf("Welcome to Dungeon Crawler 50!", VIRUTAL_WIDTH / 4,
                VIRTUAL_HEIGHT / 2 - 20, VIRUTAL_WIDTH / 2, 'center')
        love.graphics.printf("Press enter to start!", VIRUTAL_WIDTH / 4,
                VIRTUAL_HEIGHT / 2, VIRUTAL_WIDTH / 2, 'center')
        if love.keyboard.wasPressed('return') then
            gamestate = 'play'
            map.select:play()
        end
    elseif gamestate == 'play' then
        love.graphics.translate(math.floor(-map.camx + 0.5), math.floor(-map.camy + 0.5))
        map:render()
    end

    push:apply('end')

end
