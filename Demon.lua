Demon = Class{}

ENEMY_SPEED_BIG = 40
ENEMY_SPEED_SMALL = 60

function Demon:init(type, map, player, posx, posy)

    self.type = type

    -- associate self with map

    self.map = map

    -- associate self with player

    self.player = player

    self.x = posx * self.map.tileWidth
    self.y = posy * self.map.tileHeight

    self.big_health = 5
    self.small_health = 3

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

    self.big_zombie_idle_frames = {
        love.graphics.newImage('frames/big_zombie_idle_anim_f0.png'),
        love.graphics.newImage('frames/big_zombie_idle_anim_f1.png'),
        love.graphics.newImage('frames/big_zombie_idle_anim_f2.png'),
        love.graphics.newImage('frames/big_zombie_idle_anim_f3.png')
    }

    self.big_zombie_run_frames = {
        love.graphics.newImage('frames/big_zombie_run_anim_f0.png'),
        love.graphics.newImage('frames/big_zombie_run_anim_f1.png'),
        love.graphics.newImage('frames/big_zombie_run_anim_f2.png'),
        love.graphics.newImage('frames/big_zombie_run_anim_f3.png')
    }

    self.small_zombie_idle_frames = {
        love.graphics.newImage('frames/orc_warrior_idle_anim_f0.png'),
        love.graphics.newImage('frames/orc_warrior_idle_anim_f1.png'),
        love.graphics.newImage('frames/orc_warrior_idle_anim_f2.png'),
        love.graphics.newImage('frames/orc_warrior_idle_anim_f3.png')
    }

    self.small_zombie_run_frames = {
        love.graphics.newImage('frames/orc_warrior_run_anim_f0.png'),
        love.graphics.newImage('frames/orc_warrior_run_anim_f1.png'),
        love.graphics.newImage('frames/orc_warrior_run_anim_f2.png'),
        love.graphics.newImage('frames/orc_warrior_run_anim_f3.png')
    }

    -- initialize animations for big demon

    self.big_animations = {
        ['idle'] = Animation ({
            frames = self.big_idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.big_run_frames,
            interval = 0.2
        })
    }

    -- initialize animations for small demon

    self.small_animations = {
        ['idle'] = Animation ({
            frames = self.small_idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.small_run_frames,
            interval = 0.2
        })
    }

    self.big_zombie_animations = {
        ['idle'] = Animation ({
            frames = self.big_zombie_idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.big_zombie_run_frames,
            interval = 0.2
        })
    }

    self.small_zombie_animations = {
        ['idle'] = Animation ({
            frames = self.small_zombie_idle_frames,
            interval = 0.25
        }),
        ['walking'] = Animation ({
            frames = self.small_zombie_run_frames,
            interval = 0.2
        })
    }

    if self.type == 'big' then
        self.animation = self.big_animations['idle']
        self.currentFrame = self.animation:getCurrentFrame()
    elseif self.type == 'small' then
        self.animation = self.small_animations['idle']
        self.currentFrame = self.animation:getCurrentFrame()
    end

    -- define behaviour table dependend on the type

    if self.type == 'big' then

        self.behaviours = {
                ['idle'] = function(dt)

                    -- function to calculate angle and velocity values for demons to follow player
                    -- source: https://love2d.org/forums/viewtopic.php?t=33065

                    self.dx = self.player.x - self.x
                    self.dy = self.player.y - self.y

                    local distance = math.sqrt(self.dx * self.dx + self.dy * self.dy)

                    if distance < 100 then
                        if self.dx < 0 then
                            self.direction = 'left'
                        elseif self.dx > 0 then
                            self.direction = 'right'
                        end
                        self.state = 'walking'
                        self.big_animations['walking']:restart()
                        self.animation = self.big_animations['walking']
                        self.x = self.x + (self.dx / distance * ENEMY_SPEED_BIG * dt)
                        self.y = self.y + (self.dy / distance * ENEMY_SPEED_BIG * dt)
                    end

                    self:checkLeftCollision()
                    self:checkRightCollision()
                    self:checkTopCollision()
                    self:checkBottomCollision()

                end,
                ['walking'] = function(dt)

                    -- function to calculate angle and velocity values for demons to follow player
                    -- source: https://love2d.org/forums/viewtopic.php?t=33065

                    self.dx = self.player.x - self.x
                    self.dy = self.player.y - self.y

                    local distance = math.sqrt(self.dx * self.dx + self.dy * self.dy)

                    if distance < 100 then
                        if self.dx < 0 then
                            self.direction = 'left'
                        elseif self.dx > 0 then
                            self.direction = 'right'
                        end
                        self.x = self.x + (self.dx / distance * ENEMY_SPEED_BIG * dt)
                        self.y = self.y + (self.dy / distance * ENEMY_SPEED_BIG * dt)
                    else
                        self.state = 'idle'
                        self.big_animations['idle']:restart()
                        self.animation = self.big_animations['idle']
                    end

                    self:checkLeftCollision()
                    self:checkRightCollision()
                    self:checkTopCollision()
                    self:checkBottomCollision()

                end
        }
    end

    if self.type == 'small' then

        self.behaviours = {
                ['idle'] = function(dt)

                    -- function to calculate angle and velocity values for demons to follow player
                    -- source: https://love2d.org/forums/viewtopic.php?t=33065

                    self.dx = self.player.x - self.x
                    self.dy = self.player.y - self.y

                    local distance = math.sqrt(self.dx * self.dx + self.dy * self.dy)

                    if distance < 75 then
                        if self.dx < 0 then
                            self.direction = 'left'
                        elseif self.dx > 0 then
                            self.direction = 'right'
                        end
                        self.state = 'walking'
                        self.small_animations['walking']:restart()
                        self.animation = self.small_animations['walking']
                        self.x = self.x + (self.dx / distance * ENEMY_SPEED_SMALL * dt)
                        self.y = self.y + (self.dy / distance * ENEMY_SPEED_SMALL * dt)
                    end

                    self:checkLeftCollision()
                    self:checkRightCollision()
                    self:checkTopCollision()
                    self:checkBottomCollision()

                end,
                ['walking'] = function(dt)

                    -- function to calculate angle and velocity values for demons to follow player
                    -- source: https://love2d.org/forums/viewtopic.php?t=33065

                    self.dx = self.player.x - self.x
                    self.dy = self.player.y - self.y

                    local distance = math.sqrt(self.dx * self.dx + self.dy * self.dy)

                    if distance < 75 then
                        if self.dx < 0 then
                            self.direction = 'left'
                        elseif self.dx > 0 then
                            self.direction = 'right'
                        end
                        self.x = self.x + (self.dx / distance * ENEMY_SPEED_SMALL * dt)
                        self.y = self.y + (self.dy / distance * ENEMY_SPEED_SMALL * dt)
                    else
                        self.state = 'idle'
                        self.small_animations['idle']:restart()
                        self.animation = self.small_animations['idle']
                    end

                    self:checkLeftCollision()
                    self:checkRightCollision()
                    self:checkTopCollision()
                    self:checkBottomCollision()

                end
        }
    end

    -- TODO #22 Add Zombie behaviour table

    self.state = 'idle'
    self.direction = 'right'

end

-- helper functions to check for collision

function Demon:checkLeftCollision()
    if self.dx < 0 then
        if self.map:collides(self.map:tileAt(1, self.x - 1, self.y)) then
            self.dx = 0
            self.x = self.map:tileAt(1, self.x - 1, self.y).x * self.map.tileWidth
        end
    end
end

function Demon:checkRightCollision()
    if self.dx > 0 then
        if type == 'big' then
            if self.map:collides(self.map:tileAt(1, self.x + self.big_width , self.y)) then
                self.dx = 0
                self.x = (self.map:tileAt(1, self.x + self.big_width, self.y).x - 1) * self.map.tileWidth - self.big_width
            end
        else
            if self.map:collides(self.map:tileAt(1, self.x + self.small_width , self.y)) then
                self.dx = 0
                self.x = (self.map:tileAt(1, self.x + self.small_width, self.y).x - 1) * self.map.tileWidth - self.small_width
            end
        end
    end
end

function Demon:checkTopCollision()
    if self.dy < 0 then
        if self.map:collides(self.map:tileAt(1, self.x, self.y - 1)) then
            self.dy = 0
            self.y = self.map:tileAt(1, self.x, self.y - 1).y * self.map.tileHeight
        end
    end
end

function Demon:checkBottomCollision()
    if self.dy > 0 then
        if type == 'big' then
            if self.map:collides(self.map:tileAt(1, self.x, self.y + self.big_height)) then
                self.dy = 0
                self.y = (self.map:tileAt(1, self.x, self.y + self.big_height).y - 1) * self.map.tileHeight - self.big_height
            end
        else
            if self.map:collides(self.map:tileAt(1, self.x, self.y + self.small_height)) then
                self.dy = 0
                self.y = (self.map:tileAt(1, self.x, self.y + self.small_height).y - 1) * self.map.tileHeight - self.small_height
            end
        end
    end
end


function Demon:update(dt)

    self.behaviours[self.state](dt)
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
        love.graphics.draw(self.currentFrame, math.floor(self.x + self.big_xoffset),
                math.floor(self.y + self.big_yOffset), 0, scaleX, 1, self.big_xoffset, self.big_yOffset)
    elseif self.type == 'small' then
        love.graphics.draw(self.currentFrame, math.floor(self.x + self.small_xOffset),
                math.floor(self.y + self.small_yOffset), 0, scaleX, 1, self.small_xOffset, self.small_yOffset)
    end

end