Play = Room:extend('Play')

function Play:new(id)
	Play.super.new(self, id)

	self:add('player', Player(0, 0))
	self:add('pnj1', Pnj(-100, 0))

end

function Play:update(dt)
	Play.super.update(self, dt)

end

function Play:draw_outside_cam()
	Play.super.draw_outside_cam()

end

function Play:draw_inside_cam()
	Play.super.draw_inside_cam()

end
