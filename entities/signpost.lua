Signpost = Entity:extend('Signpost')
Signpost.spritesheet  = lg.newImage('assets/images/signpost.png')


function Signpost:new(x, y)
	Signpost.super.new(@, { x = x, y = y})
end

function Signpost:update(dt)
	Signpost.super.update(@, dt)

	@.z = (@.pos.y + 100) + (Signpost.spritesheet:getHeight() * 3 - 100)
end

function Signpost:draw()
	lg.draw(Signpost.spritesheet, @.pos.x, @.pos.y, _, 3)
end

function Signpost:aabb()
	return {
		x = @.pos.x,
		y = @.pos.y + 100,
		w = Signpost.spritesheet:getWidth() * 3,
		h = Signpost.spritesheet:getHeight() * 3 - 100,
	}
end
