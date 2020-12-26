Door = Entity:extend('Door')
Door.spritesheet  = lg.newImage('assets/images/door.png')
Door.closed       = lg.newQuad(0, 0, 32, 64, Door.spritesheet)
Door.opened       = lg.newQuad(160, 0, 32, 64, Door.spritesheet)
Door.frames_open  = AnimationFrames(Door.spritesheet, 32, 64, _, _, {{1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}})
Door.frames_close = AnimationFrames(Door.spritesheet, 32, 64, _, _, {{6, 1}, {5, 1}, {4, 1}, {3, 1}, {2, 1}, {1, 1}})
Door.anim_opening = Animation(.05, Door.frames_open, 'once' )
Door.anim_closing = Animation(.05, Door.frames_close, 'once')

function Door:new(x, y)
	Door.super.new(@, { x = x, y = y})
	@.state    = 'closed'
	@.opening  = Door.anim_opening:clone()
	@.closing  = Door.anim_closing:clone()

	@.opening:set_actions({[6] = fn() @.opening:reset() @.state = 'opened' end})
	@.closing:set_actions({[6] = fn() @.closing:reset() @.state = 'closed' end})
end

function Door:update(dt)
	Door.super.update(@, dt)

	if @.state == 'closing' then 
		@.closing:update(dt)

	elseif @.state == 'opening' then 
		@.opening:update(dt)

	elseif @.state == 'opened' then 

	elseif @.state == 'closed' then

	end
end

function Door:draw()
	if @.state == 'closing' then 
		@.closing:draw(@.pos.x, @.pos.y, _, 3)

	elseif @.state == 'opening' then 
		@.opening:draw(@.pos.x, @.pos.y, _, 3)

	elseif @.state == 'opened' then 
		local _x, _y, _w, _h = Door.opened:getViewport()
		lg.draw(Door.spritesheet, Door.opened, @.pos.x, @.pos.y, _, 3, _, _w/2, _h/2)

	elseif @.state == 'closed' then 
		local _x, _y, _w, _h = Door.closed:getViewport()
		lg.draw(Door.spritesheet, Door.closed, @.pos.x, @.pos.y, _, 3, _, _w/2, _h/2)
	end

end

function Door:aabb()
	return {
		x = @.pos.x - (32 * 3)/2,
		y = @.pos.y - (64 * 3)/2 + 150,
		w = 32 * 3,
		h = 64 * 3 - 150
	}
end