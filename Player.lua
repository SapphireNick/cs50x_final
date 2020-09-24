Player = Class{}

-- local variables

local WALKING_SPEED = 140
local JUMP_VELOCITY = 400

function Player:init()

    self.x = 0
    self.y = 0
    self.width = 16
    self.height= 28

    -- variables for velocity
    self.dx = 0
    self.dy = 0

    -- offset from top left for sprite flipping
    -- just self.width and self.height divided by 2 repectively
    self.xOffset = 8
    self.yOffset = 14

    -- reference to map for checking tiles
    map = sti('Tiled-test-map/test-map.lua')

    -- load player sprites into memory
    self.idle_frames = {
        love.graphics.newImage(frames/knight_m_idle_anim_f0.png),
        love.graphics.newImage(frames/knight_m_idle_anim_f1.png),
        love.graphics.newImage(frames/knight_m_idle_anim_f2.png),
        love.graphics.newImage(frames/knight_m_idle_anim_f3.png)
    }

    self.run_frames = {
        love.graphics.newImage(frames/knight_m_run_anim_f3.png),
        love.graphics.newImage(frames/knight_m_run_anim_f3.png),
        love.graphics.newImage(frames/knight_m_run_anim_f3.png),
        love.graphics.newImage(frames/knight_m_run_anim_f3.png)
    }

    -- initialize all player animations


    -- sound effects
    -- TODO

    -- reference to map
    -- TODO

    -- state to determine which animation to play
    self.state = 'idle'

    -- determines sprite flipping
    self.direction = 'right'
end