Player = Entity:extend('Player')

Player.spritesheet = lg.newImage('assets/images/blk.png')

Player.frames_move_up    = AnimationFrames(Player.spritesheet, 24,  32, {{1, 1},  {3, 1}})
Player.frames_move_left  = AnimationFrames(Player.spritesheet, 24,  32, {{1, 2},  {3, 2}})
Player.frames_move_down  = AnimationFrames(Player.spritesheet, 24,  32, {{1, 3},  {3, 3}})
Player.frames_move_right = AnimationFrames(Player.spritesheet, 24,  32, {{1, 4},  {3, 4}})

Player.frames_idle_up    = AnimationFrames(Player.spritesheet, 24,  32, {{2, 1}})
Player.frames_idle_left  = AnimationFrames(Player.spritesheet, 24,  32, {{2, 2}})
Player.frames_idle_down  = AnimationFrames(Player.spritesheet, 24,  32, {{2, 3}})
Player.frames_idle_right = AnimationFrames(Player.spritesheet, 24,  32, {{2, 4}})



function Player:new(x, y)
	Player.super.new(self, {x = x, y = y})
	
	self.speed = 500
	self.dir   = Vec2(0, 1)
	self.r     = 25

	self.anim_move_up    = Animation(.3, Player.frames_move_up    )
	self.anim_move_left  = Animation(.3, Player.frames_move_left  )
	self.anim_move_down  = Animation(.3, Player.frames_move_down  )
	self.anim_move_right = Animation(.3, Player.frames_move_right )
	self.anim_idle_up    = Animation(.3, Player.frames_idle_up    )
	self.anim_idle_left  = Animation(.3, Player.frames_idle_left  )
	self.anim_idle_down  = Animation(.3, Player.frames_idle_down  )
	self.anim_idle_right = Animation(.3, Player.frames_idle_right )
end

function Player:update(dt)
	Player.super.update(self, dt)
	-- self.anim_move_up:update(dt)
	-- self.anim_move_left:update(dt)
	self.anim_move_down:update(dt)
	-- self.anim_move_right:update(dt)
end

function Player:draw()
	Player.super.draw(self)

	lg.setColor(1, 0, 0)
	lg.circle('fill', self.pos.x, self.pos.y, self.r)
	lg.setColor(0, 1, 1)
	lg.line(self.pos.x, self.pos.y, self.pos.x + self.dir.x * 50, self.pos.y + self.dir.y * 50)
	lg.setColor(1, 1, 1)

	self.anim_move_down:draw(self.pos.x, self.pos.y, _, 5, 5)

end

function Player:move_left(dt)
	self.pos.x = self.pos.x - self.speed * dt
	self.dir = Vec2(-1, 0)
end

function Player:move_right(dt)
	self.pos.x = self.pos.x + self.speed * dt 
	self.dir = Vec2(1, 0)
end

function Player:move_up(dt)
	self.pos.y = self.pos.y - self.speed * dt
	self.dir = Vec2(0, -1)
end

function Player:move_down(dt) 
	self.pos.y = self.pos.y + self.speed * dt
	self.dir = Vec2(0, 1)
end