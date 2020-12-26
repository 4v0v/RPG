House = Entity:extend('House')
House.sprite = lg.newImage('assets/images/house.png')

function House:new(x, y, opts)
	House.super.new(@, {x = x, y = y, z = -1})
end

function House:update(dt)
	House.super.update(@, dt)

	@.z = @.pos.y
end

function House:draw()
	lg.draw(House.sprite, @.pos.x, @.pos.x, _, 4)
end

function House:aabb()
end
