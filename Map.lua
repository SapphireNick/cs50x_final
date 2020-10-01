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

-- TODO #24 Add zombies

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

    self.player:render()
    self:render_enemies()

end