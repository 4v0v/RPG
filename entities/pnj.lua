Pnj = Entity:extend('Pnj')

function Pnj:new(x, y)
	Pnj.super.new(self, {x = x, y = y, z = 5})
	
	self.speed       = 500
	self.direction   = Vec2(-1, 0)
	self.w           = 60

	self:every(3, function() self.direction = table.random_value({Vec2(1, 0), Vec2(-1, 0), Vec2(0, 1), Vec2(0, -1)}) end, _, 'change_direction')
end

function Pnj:update(dt)
	Pnj.super.update(self, dt)

end

function Pnj:draw()
	Pnj.super.draw(self)

	lg.setColor(0, .5, .5)
	lg.rectangle('fill', self.pos.x, self.pos.y, self.w, self.w)


	lg.setColor(0, 1, 0)
	local _x, _y = rect_center({x = self.pos.x, y = self.pos.y, w = self.w, h = self.w})
	lg.line(_x, _y, _x + self.direction.x * 50, _y + self.direction.y * 50)
end