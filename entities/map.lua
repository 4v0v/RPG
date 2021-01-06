Map = Entity:extend('Map')

function Map:new(tileset, x, y, scale, map)
	Map.super.new(self, {x = x, y = y, z = -math.huge})
	@.scale  = scale or 1
	@.map    = map
	@.map_w  = #map[1]
	@.map_h  = #map
	@.tile_w = tileset.tile_w 
	@.tile_h = tileset.tile_h 
	@.tiles  = tileset.tiles
	@.image  = tileset.image

	@.layers = {}
	table.insert(@.layers, map)
end

function Map:draw()
	for _, layer in ipairs(@.layers) do 
		for i = 1, @.map_h do 
			for j = 1, @.map_w do
				if layer[i][j] != '' then
					lg.draw(@.image, 
						@.tiles[layer[i][j]],
						@.pos.x + (j-1) * @.tile_w * @.scale, 
						@.pos.y + (i-1) * @.tile_h * @.scale, 
						0, @.scale 
					)
				end
			end
		end
	end
end

function Map:add_layer(layer)
	table.insert(@.layers, layer)
end
