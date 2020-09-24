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

end

-- get tile id from layer at pos x and y in tiles
function Map:getTile(layer, x, y)
    return self.map.layers[layer].data[(y - 1) * self.mapWidth + x]
end

function Map:render()

    id = self:getTile(1, 2, 2)

    for i = 1, 1 do
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

end