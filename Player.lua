Player = Class{}

-- local variables

local WALKING_SPEED = 100

function Player:init(map)

    self.width = 16
    self.height= 28
    self.max_health = 5
    self.current_health = 5

    self.sounds = {
        ['pickup'] = love.audio.newSource('sounds/pickup.wav', 'static'),
        ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
        ['swing'] = love.audio.newSource('sounds/swing.wav', 'static')
    }

    -- variables for velocity

    self.dx = 0
    self.dy = 0

    -- offset from top left for sprite flipping
    -- just self.width and self.height divided by 2 repectively

    self.xOffset = 8
    self.yOffset = 14
    self.weapon_offset = 0
    self.weapon_tilt = 0.9

    self.is_attacking = false

    -- player position in level

    self.map = map
    self.x = map.tileWidth * 38
    self.y = map.tileHeight * 45

    -- load player sprites into memory

    self.full_heart_sprite = love.graphics.newImage('frames/ui_heart_full.png')
    self.empty_heart_sprite = love.graphics.newImage('frames/ui_heart_empty.png')

    self.weapon_sprite = love.graphics.newImage('frames/weapon_red_gem_sword.png')

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

    -- 8 directional movement now working correctly

    self.behaviours = {
        ['idle'] = function(dt)

            self.weapon_offset = self:get_weapon_offset()

            if love.keyboard.wasPressed('space') then
                self.is_attacking = true
                self.sounds['swing']:play()
            end

            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.state = 'walking'
                self.dx = -WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
                self.weapon_offset = 0
            end
            if love.keyboard.isDown('d') then
                self.direction = 'right'
                self.state = 'walking'
                self.dx = WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
                self.weapon_offset = 0
            end
            if not love.keyboard.isDown('a') and not love.keyboard.isDown('d') then
                self.dx = 0
            end
            if love.keyboard.isDown('w') then
                self.state = 'walking'
                self.dy = -WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
                self.weapon_offset = 0
            end
            if love.keyboard.isDown('s') then
                self.state = 'walking'
                self.dy = WALKING_SPEED
                self.animations['walking']:restart()
                self.animation = self.animations['walking']
                self.weapon_offset = 0
            end
            if not love.keyboard.isDown('w') and not love.keyboard.isDown('s') then
                self.dy = 0
            end
            if not love.keyboard.isDown('a') and not love.keyboard.isDown('s') and 
                not love.keyboard.isDown('w') and not love.keyboard.isDown('d') then
                self.dx = 0
                self.dy = 0
            end
        end,
        ['walking'] = function(dt)

            if love.keyboard.wasPressed('space') then
                self.is_attacking = true
                self.sounds['swing']:play()
            end

            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -WALKING_SPEED
            end
            if love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = WALKING_SPEED
            end
            if not love.keyboard.isDown('a') and not love.keyboard.isDown('d') then
                self.dx = 0
            end
            if love.keyboard.isDown('w') then
                self.dy = -WALKING_SPEED
            end
            if love.keyboard.isDown('s') then
                self.dy = WALKING_SPEED
            end
            if not love.keyboard.isDown('w') and not love.keyboard.isDown('s') then
                self.dy = 0
            end
            if not love.keyboard.isDown('a') and not love.keyboard.isDown('s') and 
                not love.keyboard.isDown('w') and not love.keyboard.isDown('d') then
                self.dx = 0
                self.dy = 0
                self.state = 'idle'
                self.animations['idle']:restart()
                self.animation = self.animations['idle']
            end

            self:checkLeftCollision()
            self:checkRightCollision()
            self:checkTopCollision()
            self:checkBottomCollision()

        end
    }

    -- sound effects
    -- TODO

    -- state to determine which animation to play

    self.state = 'idle'

    -- determines sprite flipping

    self.direction = 'right'

    self.timer = 1

end

function Player:checkLeftCollision()
    if self.dx < 0 then
        if self.map:collides(self.map:tileAt(1, self.x - 1, self.y)) then
            self.dx = 0
            self.x = self.map:tileAt(1, self.x - 1, self.y).x * self.map.tileWidth
        end
    end
end

function Player:checkRightCollision()
    if self.dx > 0 then
        if self.map:collides(self.map:tileAt(1, self.x + self.width , self.y)) then
            self.dx = 0
            self.x = (self.map:tileAt(1, self.x + self.width, self.y).x - 1) * self.map.tileWidth - self.width
        end
    end
end

function Player:checkTopCollision()
    if self.dy < 0 then
        if self.map:collides(self.map:tileAt(1, self.x, self.y - 1)) then
            self.dy = 0
            self.y = self.map:tileAt(1, self.x, self.y - 1).y * self.map.tileHeight
        end
    end
end

function Player:checkBottomCollision()
    if self.dy > 0 then
        if self.map:collides(self.map:tileAt(1, self.x, self.y + self.height)) then
            self.dy = 0
            self.y = (self.map:tileAt(1, self.x, self.y + self.height).y - 1) * self.map.tileHeight - self.height
        end
    end
end

function Player:get_weapon_offset()
    for i = 1, #self.idle_frames do
        if self.animation:getCurrentFrame() == self.idle_frames[i] then
            return i
        end
    end
end

function Player:update(dt)

    self.behaviours[self.state](dt)
    self.animation:update(dt)
    self.currentFrame = self.animation:getCurrentFrame()

    self.timer = self.timer + dt

    -- check current health and check if on top of potion/pickup
    -- set tile to 0 when picked up

    if self.current_health < 5 then
        if self.map:check_pickups(self.map:tileAt(2, self.x, self.y)) then
            self.map:setTile(2, self.map:tileAt(2, self.x, self.y).x, self.map:tileAt(2, self.x, self.y).y, 0)
            self.current_health = self.current_health + 1
            self.sounds['pickup']:play()
        end
    end

    -- check if timer is above 1 ( for invincibility frames ) and
    -- check if player is standing on spikes

    if self.timer > 1 then
        if self.map:check_spike(self.map:tileAt(2, self.x + self.xOffset, self.y + self.yOffset)) then
            self.timer = 0
            self.current_health = self.current_health - 1
            self.sounds['hit']:play()
        end
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

end

function Player:render()

    local scaleX
    local weapon_tilt

    if self.direction == 'right' then
        scaleX = 1
    elseif self.direction == 'left' then
        scaleX = -1
    end

    for x = 1, self.max_health do
        if x <= self.current_health then
            love.graphics.draw(self.full_heart_sprite, self.map.camx + (x - 1) * 16 + 5, self.map.camy + 5)
        else
            love.graphics.draw(self.empty_heart_sprite, self.map.camx + (x - 1) * 16 + 5, self.map.camy + 5)
        end
    end

    love.graphics.draw(self.currentFrame, math.floor(self.x + self.xOffset),
                       math.floor(self.y + self.yOffset), 0, scaleX, 1, self.xOffset, self.yOffset)

    love.graphics.draw(self.weapon_sprite, math.floor(self.x + self.xOffset),
                       math.floor(self.y + self.yOffset + self.weapon_offset + 12), scaleX * self.weapon_tilt, scaleX * 0.6, 0.6, 10, 21)

end
