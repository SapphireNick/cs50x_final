require 'Util'

Map = Class{}

function Map:init()

    -- call map into memory | the importet lua just returns a table
    self.map = require("Tiled-test-map/test-map")
    self.mapHeight = self.map.height
    self.mapWidth = self.map.width
    self.tileHeight = self.map.tileheight
    self.tileWidth = self.map.tilewidth
    self.spritesheet = love.graphics.newImage("Tiled-test-map/0x72_DungeonTilesetII_v1.3.1/0x72_DungeonTilesetII_v1.3.png")
    self.quads = generateQuads(self.spritesheet, self.tileWidth, self.tileHeight)

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
    return self.map.layers[layer].data[(y - 1) * self.mapWidth + x]
end

function Map:collides(tile)

    -- fedine collidable tiles
    local collidables = {
        36
    }

    for _, v in ipairs(collidables) do
        if tile.id == v then
            return true
        end
    end

    return false

end

function Map:update(dt)

    self.player:update(dt)

end

function Map:render()

    id = self:getTile(1, 2, 2)

    for i = 1, #self.map['layers'] do
       for y = 1, self.mapHeight do
            for x = 1, self.mapWidth do

                local tile = self:getTile(i, x, y)

                love.graphics.draw(
                    self.spritesheet,
                    self.quads[tile],
                    (x - 1) * self.tileWidth,
                    (y - 1) * self.tileHeight
                )

            end
        end
    end

    self.player:render()

end