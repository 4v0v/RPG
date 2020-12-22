Play = Room:extend('Play')


function Play:new(id)
	Play.super.new(self, id)

	self.house = lg.newImage('assets/images/house.png')
	self.door_spritesheet = lg.newImage('assets/images/door.png')

	self.frames_door_open = AnimationFrames(self.door_spritesheet, 32, 64, {{1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}})
	self.frames_door_close = AnimationFrames(self.door_spritesheet, 32, 64, {{6, 1}, {5, 1}, {4, 1}, {3, 1}, {2, 1}, {1, 1}})

	self.anim_door_open   = Animation(.3, self.frames_door_open, 'once'  )
	self.anim_door_close  = Animation(.3, self.frames_door_close, 'once' )


	self.msgbox = Msgbox()


	self:add('player', Player(0, 0))
	self:add('pnj1', Pnj(-100, 0))

	self:zoom(0.5)
end

function Play:update(dt)
	Play.super.update(self, dt)
	self.msgbox:update(dt)
	self.anim_door_close:update(dt)


	local player          = self:get('player')
	local pnj1            = self:get('pnj1')
	local player_collider = {player.pos.x, player.pos.y, player.r}
	local pnj1_collider   = {pnj1.pos.x, pnj1.pos.y, pnj1.w, pnj1.w}

	if self.msgbox:is_empty() then
		if down("q") || down("left")  then player:set_state('move_left')  end
		if down("d") || down("right") then player:set_state('move_right') end
		if down("z") || down("up")    then player:set_state('move_up')    end
		if down("s") || down("down")  then player:set_state('move_down')  end
	end

	if released('q') || released("left") && player.state == 'move_left' then 
		player:set_state('idle_left')
	elseif released('d')|| released("right")  && player.state == 'move_right' then 
		player:set_state('idle_right')
	elseif released('z')|| released("up")  && player.state == 'move_up' then 
		player:set_state('idle_up')
	elseif released('s')|| released("down")  && player.state == 'move_down' then 
		player:set_state('idle_down')
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

	self:follow(player.pos.x, player.pos.y)
end

function Play:draw_inside_cam()
	lg.draw(self.house, 0, 0, _, 4)
	self.anim_door_close:draw(320, 511, _, 3)

	Play.super.draw_inside_cam()
end

function Play:draw_outside_camera()
	Play.super.draw_outside_camera()
	self.msgbox:draw()
end
