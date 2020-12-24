Door = Entity:extend('Door')
Door.spritesheet  = lg.newImage('assets/images/door.png')
Door.closed       = lg.newQuad(0, 0, 32, 64, Door.spritesheet)
Door.opened       = lg.newQuad(160, 0, 32, 64, Door.spritesheet)
Door.frames_open  = AnimationFrames(Door.spritesheet, 32, 64, _, _, {{1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}})
Door.frames_close = AnimationFrames(Door.spritesheet, 32, 64, _, _, {{6, 1}, {5, 1}, {4, 1}, {3, 1}, {2, 1}, {1, 1}})
Door.anim_opening = Animation(.05, Door.frames_open, 'once' )
Door.anim_closing = Animation(.05, Door.frames_close, 'once')

function Door:new(x, y)
	Door.super.new(self, { x = x, y = y})
	self.state    = 'closed'
	self.opening  = Door.anim_opening:clone()
	self.closing  = Door.anim_closing:clone()

	self.opening:set_actions({[6] = fn() self.opening:reset() self.state = 'opened' end})
	self.closing:set_actions({[6] = fn() self.closing:reset() self.state = 'closed' end})

end

function Door:update(dt)
	Door.super.update(self, dt)

	if self.state == 'closing' then 
		self.closing:update(dt)

	elseif self.state == 'opening' then 
		self.opening:update(dt)

	elseif self.state == 'opened' then 

	elseif self.state == 'closed' then

	end
end

function Door:draw()
	if self.state == 'closing' then 
		self.closing:draw(self.pos.x, self.pos.y, _, 3)

	elseif self.state == 'opening' then 
		self.opening:draw(self.pos.x, self.pos.y, _, 3)

	elseif self.state == 'opened' then 
		local _x, _y, _w, _h = Door.opened:getViewport()
		lg.draw(Door.spritesheet, Door.opened, self.pos.x, self.pos.y, _, 3, _, _w/2, _h/2)

	elseif self.state == 'closed' then 
		local _x, _y, _w, _h = Door.closed:getViewport()
		lg.draw(Door.spritesheet, Door.closed, self.pos.x, self.pos.y, _, 3, _, _w/2, _h/2)
	end

end

function Door:aabb()
	return {
		x = self.pos.x - (32 * 3)/2,
		y = self.pos.y - (64 * 3)/2 + 150,
		w = 32 * 3,
		h = 64 * 3 - 150
	}
end