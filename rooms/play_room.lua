Play_room = Room:extend('Play_room')

function Play_room:new(id)
	Play_room.super.new(@, id)

	@.msgbox = Msgbox()

	local tileset = Tileset(lg.newImage("assets/images/tileset_town.png"), 32, 32, _, _, 15 ,15)

	@.town = Map(tileset, -100, -100, 5,
		{
			{ 01, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 03, },
			{ 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, },
			{ 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, },
			{ 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, },
			{ 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, },
			{ 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, },
			{ 31, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 33, },
		}
	)

	@:add('player', Player(0, 0))
	@:add('pnj', Pnj(-100, 0))
	local door = @:add('door', Door(320, 511))
	door:on_open(fn() game:change('house') end)
	@:add('signpost', Signpost(-350, 500))
	@:add('house', House(0, 0))


	for 5 do 
		@:after({.1, .2}, fn() 
			@:add(Rabbit(love.math.random(-200, 0), love.math.random(-200, 0)))
		end)
	end


	@:zoom(0.5)
end

function Play_room:update(dt)
	Play_room.super.update(@, dt)	
	@.msgbox:update(dt)

	if pressed('1') then game:change('menu') end

	if !@.msgbox:is_empty() then 
		if pressed('space') then @.msgbox:next() end
		return
	end

	local player   = @:get('player')
	local door     = @:get('door')
	local pnj      = @:get('pnj')
	local signpost = @:get('signpost')

	if down('lctrl') then
		if     down('z') then player:set_state('run_up')
		elseif down('q') then player:set_state('run_left')
		elseif down('s') then player:set_state('run_down')
		elseif down('d') then player:set_state('run_right') end
	else 
		if     down('z') then player:set_state('move_up')
		elseif down('q') then player:set_state('move_left')
		elseif down('s') then player:set_state('move_down')
		elseif down('d') then player:set_state('move_right') end
	end

	if released('q') || released('d') || released('z') || released('s') then 
		player:stop_moving()
	end

	if pressed('space') then 
		if rect_rect_collision(player:aabb(), pnj:aabb()) then
			@.msgbox:add(
				{"Nun",   "I'm a nun."},
				{"Player","Hello, nun."},
				{"Nun",   "Hello player."}
			)

		elseif rect_rect_collision(player:aabb(), signpost:aabb()) then 
			@.msgbox:add({"Mayor's house"})

		elseif rect_rect_collision(player:aabb(), door:aabb()) then 
			if door:is_state('opened') then door:set_state('closing') end
			if door:is_state('closed') then door:set_state('opening') end
		end

		player:stop_moving()
	end

	@:follow(player.pos.x, player.pos.y)
end

function Play_room:draw_inside_camera()
	@.town:draw()
end

function Play_room:draw_outside_camera()
	Play_room.super.draw_outside_camera()
	@.msgbox:draw()
end
