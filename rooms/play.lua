Play = Room:extend('Play')

function Play:new(id)
	Play.super.new(@, id)

	@.msgbox = Msgbox()

	local img = lg.newImage("assets/images/town_tileset.png")
	local tileset = Tileset(img, 32, 32, 15 ,15)

	@.town = Map(0, 0, tileset, 
		{
			{1, 16, 16, 16, 16, 16 ,16, 31},
			{2, 17, 17, 17, 17, 17, 17, 32},
			{2, 17, 17, 17, 17, 17, 17, 32},
			{2, 17, 17, 17, 17, 17, 17, 32},
			{2, 17, 17, 17, 17, 17, 17, 32},
			{2, 17, 17, 17, 17, 17, 17, 32},
			{3, 18, 18, 18, 18, 18 ,18, 33},
		}
	)

	@:add('player', Player(0, 0))
	@:add('pnj', Pnj(-100, 0))
	@:add('door', Door(320, 511))
	@:add('signpost', Signpost(-350, 500))
	@:add('rabbit', Rabbit(-200, -200))

	for 5 do 
		@:after({.1, .2}, fn() 
			@:add(Rabbit(love.math.random(-200, 0), love.math.random(-200, 0)))
		end)
	end

	@:add('house', House(0, 0))

	@:zoom(0.5)

end

function Play:update(dt)
	Play.super.update(@, dt)	
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

function Play:draw_inside_camera()
	Play.super.draw_inside_camera()
	@.town:draw()
end

function Play:draw_outside_camera()
	Play.super.draw_outside_camera()
	@.msgbox:draw()
end
