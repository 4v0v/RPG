Pnj = Entity:extend('Pnj')

Pnj.spritesheet = lg.newImage('assets/images/nun.png')

Pnj.frames_move_up    = AnimationFrames(Pnj.spritesheet, 24,  32, {{1, 1},  {3, 1}})
Pnj.frames_move_right = AnimationFrames(Pnj.spritesheet, 24,  32, {{1, 2},  {3, 2}})
Pnj.frames_move_down  = AnimationFrames(Pnj.spritesheet, 24,  32, {{1, 3},  {3, 3}})
Pnj.frames_move_left  = AnimationFrames(Pnj.spritesheet, 24,  32, {{1, 4},  {3, 4}})

Pnj.frames_idle_up    = AnimationFrames(Pnj.spritesheet, 24,  32, {{2, 1}})
Pnj.frames_idle_right = AnimationFrames(Pnj.spritesheet, 24,  32, {{2, 2}})
Pnj.frames_idle_down  = AnimationFrames(Pnj.spritesheet, 24,  32, {{2, 3}})
Pnj.frames_idle_left  = AnimationFrames(Pnj.spritesheet, 24,  32, {{2, 4}})

function Pnj:new(x, y)
	Pnj.super.new(self, {x = x, y = y, z = 5})
	
	self.speed       = 500
	self.direction   = Vec2(-1, 0)
	self.state       = 'idle_down'

	self.anim_move_up    = Animation(.3, Pnj.frames_move_up    )
	self.anim_move_left  = Animation(.3, Pnj.frames_move_left  )
	self.anim_move_down  = Animation(.3, Pnj.frames_move_down  )
	self.anim_move_right = Animation(.3, Pnj.frames_move_right )
	self.anim_idle_up    = Animation(.3, Pnj.frames_idle_up    )
	self.anim_idle_left  = Animation(.3, Pnj.frames_idle_left  )
	self.anim_idle_down  = Animation(.3, Pnj.frames_idle_down  )
	self.anim_idle_right = Animation(.3, Pnj.frames_idle_right )

	self:every(3, function()
		self:set_state(table.random_value({'idle_left', 'idle_right', 'idle_up', 'idle_down'}))
	end, _, 'change_direction')
end

function Pnj:update(dt)
	Pnj.super.update(self, dt)

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

function Pnj:draw()
	Pnj.super.draw(self)

	if self.state == 'move_left' then 
		self.anim_move_left:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'move_right' then
		self.anim_move_right:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'move_up'    then
		self.anim_move_up:draw(self.pos.x, self.pos.y, _, 5, 5)

	elseif self.state == 'move_down'  then
		self.anim_move_down:draw(self.pos.x, self.pos.y, _, 5, 5)

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