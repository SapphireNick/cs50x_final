Player = Class{}

-- local variables

local WALKING_SPEED = 140

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

    -- player position in level
    -- TODO

    -- load player sprites into memory
    self.idle_frames = {
        love.graphics.newImage('frames/knight_m_idle_anim_f0.png'),
        love.graphics.newImage('frames/knight_m_idle_anim_f1.png'),
        love.graphics.newImage('frames/knight_m_idle_anim_f2.png'),
        love.graphics.newImage('frames/knight_m_idle_anim_f3.png')
    }

    self.run_frames = {
        love.graphics.newImage('frames/knight_m_run_anim_f0.png'),
        love.graphics.newImage('frames/knight_m_run_anim_f1.png'),
        love.graphics.newImage('frames/knight_m_run_anim_f2.png'),
        love.graphics.newImage('frames/knight_m_run_anim_f3.png')
    }

    -- initialize all player animations
    self.animations = {
        ['idle'] = Animation ({
            frames = self.idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.run_frames
        })
    }

    self.animation = self.animations['idle']
    self.currentFrame = self.animation:getCurrentFrame()

    self.behaviours = {
        ['idle'] = function(dt)
            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.state = 'walking'
                self.dx = -WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.state = 'walking'
                self.dx = WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
            elseif love.keyboard.isDown('w') then
                self.state = 'walking'
                self.dy = -WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
            elseif love.keyboard.isDown('s') then
                self.state = 'walking'
                self.dy = WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
            else
                self.dx = 0
                self.dy = 0
            end
        end,
        ['walking'] = function(dt)
            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
            elseif love.keyboard.isDown('w') then
                self.dy = -WALKING_SPEED
            elseif love.keyboard.isDown('s') then
                self.dy = WALKING_SPEED
            else
                self.dx = 0
                self.dy = 0
                self.state = 'idle'
                self.animations['idle']:restart()
                self.animation = self.animations['idle']
            end
        end
    }

    -- sound effects
    -- TODO

    -- state to determine which animation to play
    self.state = 'idle'

    -- determines sprite flipping
    self.direction = 'right'
end

function Player:update(dt)

    self.behaviours[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

end

function Player:render()

    local scaleX

    if self.direction == 'right' then
        scaleX = 1
    else
        scaleX = -1
    end

    love.graphics.draw(self.currentFrame, math.floor(self.x + self.xOffset),
            math.floor(self.y + self.yOffset), 0, scaleX, 1, self.xOffset, self.yOffset)

end