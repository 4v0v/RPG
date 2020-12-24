Player = Entity:extend('Player')

Player.spritesheet = lg.newImage('assets/images/blk.png')

Player.frames_move_up    = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 1},  {3, 1}})
Player.frames_move_left  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 4},  {3, 4}})
Player.frames_move_down  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 3},  {3, 3}})
Player.frames_move_right = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 2},  {3, 2}})

Player.frames_idle_up    = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 1}})
Player.frames_idle_left  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 4}})
Player.frames_idle_down  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 3}})
Player.frames_idle_right = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 2}})

function Player:new(x, y)
	Player.super.new(self, {x = x, y = y})
	
	self.speed = 500
	self.dir   = Vec2(0, 1)
	self.state = 'idle_down'

	self.anim_move_up    = Animation(.3, Player.frames_move_up    )
	self.anim_move_left  = Animation(.3, Player.frames_move_left  )
	self.anim_move_down  = Animation(.3, Player.frames_move_down  )
	self.anim_move_right = Animation(.3, Player.frames_move_right )

	self.anim_run_up     = Animation(.1, Player.frames_move_up    )
	self.anim_run_left   = Animation(.1, Player.frames_move_left  )
	self.anim_run_down   = Animation(.1, Player.frames_move_down  )
	self.anim_run_right  = Animation(.1, Player.frames_move_right )

	self.anim_idle_up    = Animation(.3, Player.frames_idle_up    )
	self.anim_idle_left  = Animation(.3, Player.frames_idle_left  )
	self.anim_idle_down  = Animation(.3, Player.frames_idle_down  )
	self.anim_idle_right = Animation(.3, Player.frames_idle_right )
end

function Player:update(dt)
	Player.super.update(self, dt)

	if self.state == 'move_left' then 
		self.anim_move_left:update(dt)
		self.pos.x = self.pos.x - self.speed * dt
		self.dir = Vec2(-1, 0)

	elseif self.state == 'move_right' then
		self.anim_move_right:update(dt)
		self.pos.x = self.pos.x + self.speed * dt 
		self.dir = Vec2(1, 0)

	elseif self.state == 'move_up'    then
		self.anim_move_up:update(dt)
		self.pos.y = self.pos.y - self.speed * dt
		self.dir = Vec2(0, -1)

	elseif self.state == 'move_down'  then
		self.anim_move_down:update(dt)
		self.pos.y = self.pos.y + self.speed * dt
		self.dir = Vec2(0, 1)

	elseif self.state == 'run_left' then 
		self.anim_run_left:update(dt)
		self.pos.x = self.pos.x - self.speed * 2 * dt
		self.dir = Vec2(-1, 0)

	elseif self.state == 'run_right' then
		self.anim_run_right:update(dt)
		self.pos.x = self.pos.x + self.speed * 2 * dt 
		self.dir = Vec2(1, 0)

	elseif self.state == 'run_up'    then
		self.anim_run_up:update(dt)
		self.pos.y = self.pos.y - self.speed * 2 * dt
		self.dir = Vec2(0, -1)

	elseif self.state == 'run_down'  then
		self.anim_run_down:update(dt)
		self.pos.y = self.pos.y + self.speed * 2 * dt
		self.dir = Vec2(0, 1)

	elseif self.state == 'idle_left'  then
		self.anim_idle_left:update(dt)
		self.dir = Vec2(-1, 0)

	elseif self.state == 'idle_right' then
		self.anim_idle_right:update(dt)
		self.dir = Vec2(1, 0)

	elseif self.state == 'idle_up'    then
		self.anim_idle_up:update(dt)
		self.dir = Vec2(0, -1)

	elseif self.state == 'idle_down'  then
		self.anim_idle_down:update(dt)
		self.dir = Vec2(0, 1)
	end

end

function Player:draw()
	Player.super.draw(self)

	if self.state == 'move_left' then 
		self.anim_move_left:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'move_right' then
		self.anim_move_right:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'move_up'    then
		self.anim_move_up:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'move_down'  then
		self.anim_move_down:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'run_left' then 
		self.anim_run_left:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'run_right' then
		self.anim_run_right:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'run_up'    then
		self.anim_run_up:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'run_down'  then
		self.anim_run_down:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'idle_left'  then
		self.anim_idle_left:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'idle_right' then
		self.anim_idle_right:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'idle_up'    then
		self.anim_idle_up:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'idle_down'  then
		self.anim_idle_down:draw(self.pos.x, self.pos.y, _, 5, 5)
	end

end

function Player:stop_moving()
	if self:is_state('move_left') || self:is_state('run_left') then 
		self:set_state('idle_left')

	elseif self:is_state('move_right') || self:is_state('run_right') then 
		self:set_state('idle_right')

	elseif self:is_state('move_up') || self:is_state('run_up') then 
		self:set_state('idle_up')

	elseif self:is_state('move_down') || self:is_state('run_down') then 
		self:set_state('idle_down')
	end
end

function Player:aabb()
	return {
		x = self.pos.x - (24 * 5)/2 + 20,
		y = self.pos.y - (32 * 5)/2 + 120,
		w = 24 * 5 - 40,
		h = 32 * 5 - 120,
	}
end
