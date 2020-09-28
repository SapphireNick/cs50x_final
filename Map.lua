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


function Map:collides(tile)

    -- define collidable tiles
    local collidables = {
        33, 34, 35,
        165, 197, 229
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
        356
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

end