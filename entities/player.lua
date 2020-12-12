Player = Entity:extend('Player')

function Player:new(x, y)
	Player.super.new(self, {x = x, y = y})
	
	self.speed       = 500
	self.direction   = Vec2(0, 1)
end

function Player:update(dt)
	Player.super.update(self, dt)
	if     down("q") then 
		self.pos.x = self.pos.x - self.speed * dt
		self.direction = Vec2(-1, 0)
	elseif down("d") then 
		self.pos.x = self.pos.x + self.speed * dt 
		self.direction = Vec2(1, 0)
	end
	
	if     down("z") then 
		self.pos.y = self.pos.y - self.speed * dt
		self.direction = Vec2(0, -1)
	elseif down("s") then 
		self.pos.y = self.pos.y + self.speed * dt
		self.direction = Vec2(0, 1)
	end
end

function Player:draw()
	Player.super.draw(self)

	lg.setColor(1, 0, 0)
	lg.circle('fill', self.pos.x, self.pos.y, 25)
	lg.setColor(0, 1, 1)
	lg.line(self.pos.x, self.pos.y, self.pos.x + self.direction.x * 50, self.pos.y + self.direction.y * 50)
	lg.setColor(1, 1, 1)
end