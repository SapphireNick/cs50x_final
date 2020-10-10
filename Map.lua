require 'Util'

Map = Class{}

function Map:init()

    -- call map into memory | the importet lua just returns a table
    self.map = require("cs50x_fp_lv1/lv1")
    self.mapHeight = self.map.height
    self.mapWidth = self.map.width
    self.tileHeight = self.map.tileheight
    self.tileWidth = self.map.tilewidth
    self.spritesheet = love.graphics.newImage("cs50x_fp_lv1/0x72_DungeonTilesetII_v1.3.1/0x72_DungeonTilesetII_v1.3.png")
    self.quads = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

    self.data = {
        self.map.layers[1].data,
        self.map.layers[2].data
    }

    self.camx = 0
    self.camy = -3

    self.player = Player(self)

end

function Map:tileAt(layer, x, y)
    return {
        x = math.floor(x / self.tileWidth) + 1,
        y = math.floor(y / self.tileHeight) + 1,
        id = self:getTile(layer, math.floor(x / self.tileWidth) + 1, math.floor(y / self.tileHeight) + 1)
    }
end

-- get tile id from layer at pos x and y in tiles
function Map:getTile(layer, x, y)
    return self.data[layer][(y - 1) * self.mapWidth + x]
end

function Map:setTile(layer, x, y, tile_id)
    self.data[layer][(y - 1) * self.mapWidth + x] = tile_id
end

-- loads all demons in the right places

function Map:load_enemies()

    self.sd1 = Demon('small', self, self.player, 25, 34)
    self.sd2 = Demon('small', self, self.player, 25, 26)
    self.sd3 = Demon('small', self, self.player, 2, 26)
    self.sd4 = Demon('small', self, self.player, 51, 25)
    self.sd5 = Demon('small', self, self.player, 59, 2)
    self.sd6 = Demon('small', self, self.player, 59, 30)
    self.sd7 = Demon('small', self, self.player, 93, 33)
    self.sd8 = Demon('small', self, self.player, 51, 47)
    self.sd9 = Demon('small', self, self.player, 59, 38)
    self.sd10 = Demon('small', self, self.player, 64, 38)
    self.sd11 = Demon('small', self, self.player, 94, 47)
    self.sd12 = Demon('small', self, self.player, 87, 15)
    self.sd13 = Demon('small', self, self.player, 90, 13)

    self.bd1 = Demon('big', self, self.player, 6, 43)
    self.bd2 = Demon('big', self, self.player, 14, 2)
    self.bd3 = Demon('big', self, self.player, 56, 28)
    self.bd4 = Demon('big', self, self.player, 87, 10)

    self.sz1 = Demon('small_z', self, self.player, 6, 25)
    self.sz2 = Demon('small_z', self, self.player, 12, 16)
    self.sz3 = Demon('small_z', self, self.player, 15, 16)
    self.sz4 = Demon('small_z', self, self.player, 35, 1)
    self.sz5 = Demon('small_z', self, self.player, 41, 1)
    self.sz6 = Demon('small_z', self, self.player, 38, 10)
    self.sz7 = Demon('small_z', self, self.player, 33, 16)
    self.sz8 = Demon('small_z', self, self.player, 37, 18)
    self.sz9 = Demon('small_z', self, self.player, 39, 18)
    self.sz10 = Demon('small_z', self, self.player, 44, 16)
    self.sz11 = Demon('small_z', self, self.player, 61, 40)
    self.sz12 = Demon('small_z', self, self.player, 62, 40)
    self.sz13 = Demon('small_z', self, self.player, 69, 18)
    self.sz14 = Demon('small_z', self, self.player, 96, 41)
    self.sz15 = Demon('small_z', self, self.player, 96, 35)
    self.sz16 = Demon('small_z', self, self.player, 80, 12)
    self.sz17 = Demon('small_z', self, self.player, 83, 15)

    self.bz1 = Demon('big_z', self, self.player, 82, 9)
    self.bz2 = Demon('big_z', self, self.player, 87, 38)
    self.bz3 = Demon('big_z', self, self.player, 2, 6)

end

function Map:update_enemies(dt)

    self.sd1:update(dt)
    self.sd2:update(dt)
    self.sd3:update(dt)
    self.sd4:update(dt)
    self.sd5:update(dt)
    self.sd6:update(dt)
    self.sd7:update(dt)
    self.sd8:update(dt)
    self.sd9:update(dt)
    self.sd10:update(dt)
    self.sd11:update(dt)
    self.sd12:update(dt)
    self.sd13:update(dt)

    self.bd1:update(dt)
    self.bd2:update(dt)
    self.bd3:update(dt)
    self.bd4:update(dt)


    self.sz1:update(dt)
    self.sz2:update(dt)
    self.sz3:update(dt)
    self.sz4:update(dt)
    self.sz5:update(dt)
    self.sz6:update(dt)
    self.sz7:update(dt)
    self.sz8:update(dt)
    self.sz9:update(dt)
    self.sz10:update(dt)
    self.sz11:update(dt)
    self.sz12:update(dt)
    self.sz13:update(dt)
    self.sz14:update(dt)
    self.sz15:update(dt)
    self.sz16:update(dt)
    self.sz17:update(dt)

    self.bz1:update(dt)
    self.bz2:update(dt)
    self.bz3:update(dt)

end

function Map:render_enemies()

    self.sd1:render()
    self.sd2:render()
    self.sd3:render()
    self.sd4:render()
    self.sd5:render()
    self.sd6:render()
    self.sd7:render()
    self.sd8:render()
    self.sd9:render()
    self.sd10:render()
    self.sd11:render()
    self.sd12:render()
    self.sd13:render()

    self.bd1:render()
    self.bd2:render()
    self.bd3:render()
    self.bd4:render()

    self.sz1:render(dt)
    self.sz2:render(dt)
    self.sz3:render(dt)
    self.sz4:render(dt)
    self.sz5:render(dt)
    self.sz6:render(dt)
    self.sz7:render(dt)
    self.sz8:render(dt)
    self.sz9:render(dt)
    self.sz10:render(dt)
    self.sz11:render(dt)
    self.sz12:render(dt)
    self.sz13:render(dt)
    self.sz14:render(dt)
    self.sz15:render(dt)
    self.sz16:render(dt)
    self.sz17:render(dt)

    self.bz1:render(dt)
    self.bz2:render(dt)
    self.bz3:render(dt)

end

function Map:collides(tile)

    -- define collidable tiles
    local collidables = {
        33, 34, 35,
        167, 198, 230
    }

    for _, v in ipairs(collidables) do
        if tile.id == v then
            return true
        end
    end

    return false

end

function Map:check_pickups(tile)

    -- define pickups
    local pickups = {
        467
    }

    for _, v in ipairs(pickups) do
        if tile.id == v then
            return true
        end
    end

    return false

end

function Map:check_spike(tile)

    --  define spike/hurtable tiles id's
    local hurtable_tiles = {
        357
    }

    for _, v in ipairs(hurtable_tiles) do
        if tile.id == v then
            return true
        end
    end

    return false

end

function Map:update(dt)

    self.player:update(dt)
    self:update_enemies(dt)

    self.camx = math.max(0, math.min(self.player.x - 432 / 2,
            math.min(self.mapWidth * self.tileWidth - 432, self.player.x)))

    self.camy = math.max(0, math.min(self.player.y - 243 / 2 + self.player.height,
            math.min(self.mapHeight * self.tileHeight - 243, self.player.y)))

end

function Map:render()

    id = self:getTile(1, 2, 2)

    for i = 1, #self.data do
        for y = 1, self.mapHeight do
            for x = 1, self.mapWidth do
                
                local tile = self:getTile(i, x, y)

                if tile ~= 0 then
                    love.graphics.draw(
                        self.spritesheet,
                        self.quads[tile],
                        (x - 1) * self.tileWidth,
                        (y - 1) * self.tileHeight
                    )
                end

            end
        end
    end

    if self.player.current_health <= 0 then
        love.graphics.clear(0, 0, 0, 1)
        love.graphics.draw(self.player.idle_frames[3], self.camx + 432 / 2, self.camy + 243 / 2 - self.player.yOffset)
        self.player.x = 0
        self.player.y = 0
        love.graphics.printf("You died! Try again? [y/n]",
                             432 / 8 - 50,
                             243 / 2 + 50,
                             432, 'center')
        if love.keyboard.isDown('y') then
            self:load_enemies()
            self.player.x = map.tileWidth * 38
            self.player.y = map.tileHeight * 45
            self.player.current_health = 5
        elseif love.keyboard.isDown('n') then
            love.event.quit()
        end


    else
        self.player:render()
        self:render_enemies()
    end

end
