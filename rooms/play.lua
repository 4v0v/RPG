Play = Room:extend('Play')

function Play:new(id)
	Play.super.new(self, id)

	self:add('player', Player(0, 0))
	self:add('pnj1', Pnj(-100, 0))

	self.msgbox = Msgbox()

end

function Play:update(dt)
	Play.super.update(self, dt)
	self.msgbox:update(dt)

	local player          = self:get('player')
	local pnj1            = self:get('pnj1')
	local player_collider = {player.pos.x, player.pos.y, player.r}
	local pnj1_collider   = {pnj1.pos.x, pnj1.pos.y, pnj1.w, pnj1.w}

	if self.msgbox:is_empty() then
		if down("q") || down("left")  then player:move_left(dt)  end
		if down("d") || down("right") then player:move_right(dt) end
		if down("z") || down("up")    then player:move_up(dt)    end
		if down("s") || down("down")  then player:move_down(dt)  end
	end

	if released('q') && player.state == 'move_left' then 
		player.state = 'idle_left'
	elseif released('d') && player.state == 'move_right' then 
		player.state = 'idle_right'
	elseif released('z') && player.state == 'move_up' then 
		player.state = 'idle_up'
	elseif released('s') && player.state == 'move_down' then 
		player.state = 'idle_down'
	end

	if pressed("space") then 
		if self.msgbox:is_empty() && circ_rect_collision(player_collider, pnj1_collider) then 
			self.msgbox:add(
				{title = "one", text = "i'm a test message on multiple lines, how are you today ? fine thank you :) "},
				{title = "two", text = "i'm a second test message"},
				{text  = "i'm a third test message without title"},
				{title = "fourrrrrrrrrrrrrrrrr", text = "i'm a fourth test message", avatar = self.sasha_angry}
			)
		elseif !self.msgbox:is_empty() then 
			self.msgbox:next()
		end
	end
end

function Play:draw_inside_cam()
	Play.super.draw_inside_cam()
end

function Play:draw_outside_camera()
	Play.super.draw_outside_camera()
	self.msgbox:draw()
end