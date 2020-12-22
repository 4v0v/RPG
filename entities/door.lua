Door = Entity:extend('Door')
Door.spritesheet  = lg.newImage('assets/images/door.png')
Door.closed       = lg.newQuad(0, 0, 32, 64, Door.spritesheet)
Door.opened       = lg.newQuad(160, 0, 32, 64, Door.spritesheet)
Door.frames_open  = AnimationFrames(Door.spritesheet, 32, 64, {{1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}})
Door.frames_close = AnimationFrames(Door.spritesheet, 32, 64, {{6, 1}, {5, 1}, {4, 1}, {3, 1}, {2, 1}, {1, 1}})
-- Door.anim_opening = Animation(.3, Door.frames_open, 'once'  , {[6] = fn() self.state = 'opened' end})
-- Door.anim_closing = Animation(.3, Door.frames_close, 'once' , {[6] = fn() self.state = 'closed' end})

function Door:new(x, y)
	Door.super.new(self, { x = x, y = y})
	self.state    = 'closed'
	self.opening  = Animation(.3, Door.frames_open, 'once'  , {[6] = fn() self.state = 'opened' end})
	self.closing  = Animation(.3, Door.frames_close, 'once' , {[6] = fn() self.state = 'closed' end})


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
	print(self.state)

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
