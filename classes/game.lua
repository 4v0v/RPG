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

function Game:add_room(room_name, room)
	@.rooms[room_name] = room
end

function Game:change_room(room_name)
	@.current = room_name
end