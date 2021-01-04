House_room = Room:extend('House_room')

function House_room:new(id)
	House_room.super.new(@, id)

	@.msgbox = Msgbox()

	local tileset = Tileset(lg.newImage("assets/images/tileset_house.png"), 16, 16, _, _, 16 ,16)

	@.house = Map(tileset, -100, -100, 5,
		{
			{ 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08,},
			{ 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,},
			{ 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40,},
			{ 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,},
			{ 01, 02, 03, 01, 02, 03, 03, 03, 03, 02, 02, 02, 02, 02, 02,},
			{ 01, 02, 03, 01, 02, 03, 03, 03, 03, 02, 02, 02, 02, 02, 02,},
			{ 01, 02, 03, 01, 02, 03, 03, 03, 03, 02, 02, 02, 02, 02, 02,},
			{ 01, 02, 03, 01, 02, 03, 03, 03, 03, 02, 02, 02, 02, 02, 02,},
		}
	)

	@.house2 = Map(tileset, -100, -100, 5,
		{
			{ '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',},
			{ '', 09, 10, 11, '', '', 09, 10, 11, '', '', 09, 10, 11, '',},
			{ '', 25, 26, 27, '', '', 25, 26, 27, '', '', 25, 26, 27, '',},
			{ '', 41, 42, 43, '', '', 41, 42, 43, '', '', 41, 42, 43, '',},
			{ '', 57, 58, 59, '', '', 57, 58, 59, '', '', 57, 58, 59, '',},
			{ '', 73, 74, 75, '', '', 73, 74, 75, '', '', 73, 74, 75, '',},
			{ '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',},
			{ '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',},
		}
)

	@:add('player', Player(0, 300))

	@.camera:set_scale(0.5)
	@.camera:set_position(0, 300)
end

function House_room:update(dt)
	House_room.super.update(@, dt)	
	@.msgbox:update(dt)

	if pressed('1') then game:change('menu') end

	if !@.msgbox:is_empty() then 
		if pressed('space') then @.msgbox:next() end
		return
	end

	local player   = @:get('player')

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

	@:follow(player.pos.x, player.pos.y)
end

function House_room:draw_inside_camera()
	@.house:draw()
	@.house2:draw()
end

function House_room:draw_outside_camera()
	House_room.super.draw_outside_camera()
	@.msgbox:draw()
end
