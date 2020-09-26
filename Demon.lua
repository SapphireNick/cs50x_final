Demon = Class{}

function Demon:init(type, map)

    self.type = type

    self.x = 0
    self.y = 0

    -- height and width for either small or big demon
    -- type argument will decide which demon to spawn

    self.big_height = 36
    self.big_width = 32
    self.small_height = 24
    self.small_width = 16

    -- velocity

    self.dx = 0
    self.dy = 0

    -- offsets for both types for sprite flipping

    self.big_yOffset = 18
    self.big_xoffset = 16
    self.small_yOffset = 12
    self.small_xOffset = 8

    -- idle and walking fraes for big demon

    self.big_idle_frames = {
        love.graphics.newImage('frames/big_demon_idle_anim_f0.png'),
        love.graphics.newImage('frames/big_demon_idle_anim_f1.png'),
        love.graphics.newImage('frames/big_demon_idle_anim_f2.png'),
        love.graphics.newImage('frames/big_demon_idle_anim_f3.png')
    }

    self.big_run_frames = {
        love.graphics.newImage('frames/big_demon_run_anim_f0.png'),
        love.graphics.newImage('frames/big_demon_run_anim_f1.png'),
        love.graphics.newImage('frames/big_demon_run_anim_f2.png'),
        love.graphics.newImage('frames/big_demon_run_anim_f3.png')
    }

    -- idle and walking frames for small demon

    self.small_idle_frames = {
        love.graphics.newImage('frames/chort_idle_anim_f0.png'),
        love.graphics.newImage('frames/chort_idle_anim_f1.png'),
        love.graphics.newImage('frames/chort_idle_anim_f2.png'),
        love.graphics.newImage('frames/chort_idle_anim_f3.png')
    }

    self.small_run_frames = {
        love.graphics.newImage('frames/chort_run_anim_f0.png'),
        love.graphics.newImage('frames/chort_run_anim_f1.png'),
        love.graphics.newImage('frames/chort_run_anim_f2.png'),
        love.graphics.newImage('frames/chort_run_anim_f3.png')
    }

    -- initialize animations for big demon

    self.big_animations = {
        ['idle'] = Animation ({
            frames = self.big_idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.big_run_frames
        })
    }

    -- initialize animations for small demon

    self.small_animations = {
        ['idle'] = Animation ({
            frames = self.small_idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.small_run_frames
        })
    }

    if self.type == 'big' then
        self.animation = self.big_animations['idle']
        self.currentFrame = self.animation:getCurrentFrame()
    elseif self.type == 'small' then
        self.animation = self.small_animations['idle']
        self.currentFrame = self.animation:getCurrentFrame()
    end

    self.state = 'idle'
    self.direction = 'right'

end

function Demon:update(dt)

    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()

end

function Demon:render()

    local scaleX

    if self.direction == 'right' then
        scaleX = 1
    else
        scaleX = -1
    end

    if self.type == 'big' then
        --temp
        self.x = 16
        self.y = 16
        love.graphics.draw(self.currentFrame, math.floor(self.x + self.big_xoffset),
                math.floor(self.y + self.big_yOffset), 0, scaleX, 1, self.big_xoffset, self.big_yOffset)
    elseif self.type == 'small' then
        --temp
        self.x = 3 * 16
        self.y = 3 * 16
        love.graphics.draw(self.currentFrame, math.floor(self.x + self.small_xOffset),
                math.floor(self.y + self.small_yOffset), 0, scaleX, 1, self.small_xOffset, self.small_yOffset)
    end

end