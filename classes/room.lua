Room = Class:extend('Room')

function Room:new(id)
	@.id     = id or uid()
	@.timer  = Timer()
	@.camera = Camera()
	@._queue = {}
	@._ents  = { All = {} }
end

function Room:update(dt)
	@.timer:update(dt)
	@.camera:update(dt)

	-- update entitites
	for _, ent in pairs(@._ents['All']) do 
		ent:update(dt)
	end
	-- delete dead entities
	for _, ent in pairs(@._ents['All']) do 
		if ent.dead then
			@._ents['All'][ent.id] = nil
			for _, type in pairs(ent.types) do 
				@._ents[type][ent.id] = nil
			end
		end
	end
	-- push entities from queue
	for _, queued_ent in pairs(@._queue) do
		for _, type in ipairs(queued_ent.types) do 
			if not @._ents[type] then 
				@._ents[type] = {}
			end
			@._ents[type][queued_ent.id] = queued_ent
		end
		@._ents['All'][queued_ent.id] = queued_ent
	end
	@._queue = {}
end

function Room:draw()
	local entities = {}
	for _, ent in pairs(@._ents['All']) do table.insert(entities, ent) end
	table.sort(entities, function(a, b) if a.z == b.z then return a.id < b.id else return a.z < b.z end end)

	@.camera:draw(function()
		@:draw_inside_camera()
		for _, ent in pairs(entities) do 
			if ent.draw && !ent.outside_camera then 
				local _r,_g, _b, _a = love.graphics.getColor()
				ent:draw()
				love.graphics.setColor(_r, _g, _b, _a)
			end
		end
	end)

	@:draw_outside_camera()
	for _, ent in pairs(entities) do 
		if ent.draw && ent.outside_camera then
			local _r,_g, _b, _a = love.graphics.getColor()
			ent:draw()
			love.graphics.setColor(_r, _g, _b, _a)
		end
	end
end

function Room:draw_inside_camera()
end

function Room:draw_outside_camera()
end

function Room:add(a, b, c)
	local id, types, entity

	if type(a) == 'string' and type(b) == 'table' and type(c) == 'nil' then
		id, types, entity = a, {}, b
	elseif type(a) == 'string' and type(b) == 'table' and type(c) == 'table' then
		id, types, entity = a, b, c
	elseif type(a) == 'string' and type(b) == 'string' and type(c) == 'table' then 
		id, types, entity = a, {b}, c
	elseif type(a) == 'table' and type(b) == 'table' and type(c) == 'nil' then
		id, types, entity = uid(), a, b
	elseif type(a) == 'table' and type(b) == 'nil' and type(c) == 'nil' then
		id, types, entity = uid(), {}, a
	end

	table.insert(types, entity:class())
	for _, type in pairs(entity.types) do 
		table.insert(types, type)
	end

	entity.types    = types  
	entity.id       = id
	entity.room     = @
	@._queue[id] = entity
	return entity 
end

function Room:kill(id) 
	local entity = @:get(id)
	if entity then entity:kill() end
end

function Room:get(id) 
	local entity = @._ents['All'][id]
	if not entity or entity.dead then return nil end
	return entity
end

function Room:get_by_type(...)
	local entities = {}
	local types    = {...}
	local filter   = {} -- filter duplicate entities using id

	for _, type in pairs(types) do
		if @._ents[type] then
			for _, ent in pairs(@._ents[type]) do
				if not ent.dead then filter[ent.id] = ent end
			end
		end
	end

	for _, ent in pairs(filter) do 
		table.insert(entities, ent)
	end

	return entities
end

function Room:count(...)
	local entities = {}
	local types    = {...}
	local filter   = {} -- filter duplicate entities using id

	for _, type in pairs(types) do
		if @._ents[type] then
			for _, ent in pairs(@._ents[type]) do
				if not ent.dead then filter[ent.id] = ent end
			end
		end
	end
	for _, ent in pairs(filter) do 
		table.insert(entities, ent)
	end

	return #entities
end

function Room:enter() 
end

function Room:leave() 
end

function Room:after(...)
	@.timer:after(...)
end

function Room:tween(...)
	@.timer:tween(...)
end

function Room:every(...)
	@.timer:every(...)
end

function Room:every_immediate(...)
	@.timer:every_immediate(...)
end

function Room:during(...)
	@.timer:during(...)
end

function Room:once(...)
	@.timer:once(...)
end

function Room:always(...)
	@.timer:always(...)
end

function Room:zoom(...)
	@.camera:zoom(...)
end

function Room:shake(...)
	@.camera:shake(...)
end

function Room:follow(...)
	@.camera:follow(...)
end

function Room:get_mouse_position() return
	@.camera:get_mouse_position()
end
