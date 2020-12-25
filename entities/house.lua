House = Entity:extend('House')
House.sprite = lg.newImage('assets/images/house.png')

function House:new(x, y, opts)
	House.super.new(self, {x = x, y = y, z = -1})
end

function House:update(dt)
	House.super.update(self, dt)
end

function House:draw()
	lg.draw(House.sprite, self.pos.x, self.pos.x, _, 4)
end

function House:aabb()
end
