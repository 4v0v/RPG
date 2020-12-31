Game = Class:extend('Game')

function Game:new()
	@.current = ''
	@.rooms = {}
end

function Game:update(dt)
	if current == '' then return end
	@.rooms[@.current]:update(dt)
end

function Game:draw()
	if current == '' then return end
	@.rooms[@.current]:draw()
end

function Game:add(name, room)
	@.rooms[name] = room
end

function Game:change(name)
	@.current = name
end
