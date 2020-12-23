Signpost = Entity:extend('Signpost')
Signpost.spritesheet  = lg.newImage('assets/images/signpost.png')


function Signpost:new(x, y)
	Signpost.super.new(self, { x = x, y = y})
end

function Signpost:update(dt)
	Signpost.super.update(self, dt)
end

function Signpost:draw()
	lg.draw(Signpost.spritesheet, self.pos.x, self.pos.y, _, 3)
end

function Signpost:aabb()
	return {
		x = self.pos.x,
		y = self.pos.y + 100,
		w = Signpost.spritesheet:getWidth() * 3,
		h = Signpost.spritesheet:getHeight() * 3 - 100,
	}
end
