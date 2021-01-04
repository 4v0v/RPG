Tileset = Class:extend('Tileset')

function Tileset:new(image, tile_w, tile_h, ox, oy, x_number, y_number)
  @.image    = image
	@.tile_w   = tile_w
	@.tile_h   = tile_h
	@.ox       = ox or 0
	@.oy       = oy or 0
	@.tiles    = (fn()
		local tiles = {}
		for i = 1,  x_number do
			for j = 1, y_number do 
				table.insert(tiles, love.graphics.newQuad(
					(j-1) * @.tile_w, 
					(i-1) * @.tile_h, 
					@.tile_w, @.tile_h, 
					@.image:getWidth(), @.image:getHeight()
				))
			end
		end
		return tiles
	end)()
end

Map = Class:extend('Map')

function Map:new(tileset, x, y, scale, map)
	@.x      = x 
	@.y      = y
	@.scale  = scale or 1
	@.map    = map
	@.map_w  = #map[1]
	@.map_h  = #map
	@.tile_w = tileset.tile_w 
	@.tile_h = tileset.tile_h 
	@.tiles  = tileset.tiles
	@.image  = tileset.image
end

function Map:draw()
	for i = 1, @.map_h do 
		for j = 1, @.map_w do
			if @.map[i][j] != '' then
				lg.draw(@.image, @.tiles[@.map[i][j]],
					@.x + (j-1) * @.tile_w * @.scale, 
					@.y + (i-1) * @.tile_h * @.scale, 
					_, @.scale 
				)
			end
		end
	end
end
