Rabbit = Entity:extend('Rabbit')
Rabbit.spritesheet  = lg.newImage('assets/images/rabbit.png')

Rabbit.frames_move_up    = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 1},  {2, 1}, {3, 1}, {4, 1}})
Rabbit.frames_move_left  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 2},  {2, 2}, {3, 2}, {4, 2}})
Rabbit.frames_move_down  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 3},  {2, 3}, {3, 3}, {4, 3}})
Rabbit.frames_move_right = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 4},  {2, 4}, {3, 4}, {4, 4}})
Rabbit.frames_idle_up    = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 5},  {2, 5}, {3, 5}, {4, 5}})
Rabbit.frames_idle_left  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 6},  {2, 6}, {3, 6}, {4, 6}})
Rabbit.frames_idle_down  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 7},  {2, 7}, {3, 7}, {4, 7}})
Rabbit.frames_idle_right = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 8},  {2, 8}, {3, 8}, {4, 8}})

function Rabbit:new(x, y)
	Rabbit.super.new(self, { x = x, y = y})

	self.anim_move_up    = Animation(.2, Rabbit.frames_move_up    )
	self.anim_move_left  = Animation(.2, Rabbit.frames_move_left  )
	self.anim_move_down  = Animation(.2, Rabbit.frames_move_down  )
	self.anim_move_right = Animation(.2, Rabbit.frames_move_right )
	self.anim_idle_up    = Animation(.2, Rabbit.frames_idle_up    )
	self.anim_idle_left  = Animation(.2, Rabbit.frames_idle_left  )
	self.anim_idle_down  = Animation(.2, Rabbit.frames_idle_down  )
	self.anim_idle_right = Animation(.2, Rabbit.frames_idle_right )
end

function Rabbit:update(dt)
	Rabbit.super.update(self, dt)
	self.anim_move_up:update(dt)
	self.anim_move_left:update(dt)
	self.anim_move_down:update(dt)
	self.anim_move_right:update(dt)
	self.anim_idle_up:update(dt)
	self.anim_idle_left:update(dt)
	self.anim_idle_down:update(dt)
	self.anim_idle_right:update(dt)
end

function Rabbit:draw()
	-- self.anim_move_up:draw(self.pos.x, self.pos.y, _, 5, 5)
	self.anim_move_left:draw(self.pos.x, self.pos.y, _, 5, 5)
	-- self.anim_move_down:draw(self.pos.x, self.pos.y, _, 5, 5)
	-- self.anim_move_right:draw(self.pos.x, self.pos.y, _, 5, 5)
	-- self.anim_idle_up:draw(self.pos.x, self.pos.y, _, 5, 5)
	-- self.anim_idle_left:draw(self.pos.x, self.pos.y, _, 5, 5)
	-- self.anim_idle_down:draw(self.pos.x, self.pos.y, _, 5, 5)
	-- self.anim_idle_right:draw(self.pos.x, self.pos.y, _, 5, 5)
end

function Rabbit:aabb()
end
