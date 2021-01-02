Tileset = Class:extend('Tileset')

function Tileset:new(image, tile_w, tile_h, x_number, y_number)
  @.image    = image
	@.tile_w   = tile_w
	@.tile_h   = tile_h
	@.offset_x = offset_x or 0
	@.offset_y = offset_y or 0
	@.tiles    = (fn()
		local tiles = {}
		for i = 1,  x_number do
			for j = 1, y_number do 
				table.insert(tiles, love.graphics.newQuad(
					(i-1) * @.tile_w, 
					(j-1) * @.tile_h, 
					@.tile_w, @.tile_h, 
					@.image:getWidth(), @.image:getHeight()
				))
			end
		end
		return tiles
	end)()
end

Map = Class:extend('Map')

function Map:new(x, y, tileset, map)
	@.x = x 
	@.y = y
	@.map_width = #map[1]
	@.tileset = tileset
	@.tiles = tileset.tiles
	@.map   = map
	@.image = tileset.image
end

function Map:draw()
	for i = 1, #@.map do 
		for j = 1, @.map_width do
			if @.map[i][j] != '' then
				lg.draw(@.image, @.tiles[@.map[i][j]],
					(j-1) * @.tileset.tile_w * 5, 
					(i-1) * @.tileset.tile_h * 5, 
					_, 5 
				)
			end
		end
	end
end
