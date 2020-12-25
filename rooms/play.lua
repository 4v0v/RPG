Play = Room:extend('Play')


function Play:new(id)
	Play.super.new(self, id)


	self.msgbox = Msgbox()

	self:add('player', Player(0, 0))
	self:add('pnj1', Pnj(-100, 0))
	self:add('door', Door(320, 511))
	self:add('signpost', Signpost(-350, 500))
	self:add('rabbit', Rabbit(-200, -200))
	self:add('house', House(0, 0))

	self:zoom(0.5)
end

function Play:update(dt)
	Play.super.update(self, dt)
	self.msgbox:update(dt)

	if !self.msgbox:is_empty() then 
		if pressed("space") then self.msgbox:next() end
		return
	end

	local player   = self:get('player')
	local door     = self:get('door')
	local pnj1     = self:get('pnj1')
	local signpost = self:get('signpost')

	if down('lctrl') then
		if     down("z") then player:set_state('run_up')
		elseif down("q") then player:set_state('run_left')
		elseif down("s") then player:set_state('run_down')
		elseif down("d") then player:set_state('run_right') end
	else 
		if     down("z") then player:set_state('move_up')
		elseif down("q") then player:set_state('move_left')
		elseif down("s") then player:set_state('move_down')
		elseif down("d") then player:set_state('move_right') end
	end

	if released('q') || released('d') || released('z') || released('s') then 
		player:stop_moving()
	end

	if pressed("space") then 
		if rect_rect_collision(player:aabb(), pnj1:aabb()) then 
			self.msgbox:add(
				{title = "Nun",    text = "Hello, i'm a nun."},
				{title = "Player", text = "Hello, nun."},
				{title = "Nun",    text = "Hello player."}
			)
		elseif rect_rect_collision(player:aabb(), signpost:aabb()) then 
			self.msgbox:add(
				{text = "Mayor's house"}
			)
		elseif rect_rect_collision(player:aabb(), door:aabb()) then 
			if door:is_state('opened') then door:set_state('closing') end
			if door:is_state('closed') then door:set_state('opening') end
		end

		player:stop_moving()
	end

	self:follow(player.pos.x, player.pos.y)
end

function Play:draw_inside_cam()
	Play.super.draw_inside_cam()
end

function Play:draw_outside_camera()
	Play.super.draw_outside_camera()
	self.msgbox:draw()
end
