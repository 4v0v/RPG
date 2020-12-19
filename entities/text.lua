Text = Entity:extend('Text')

function Text:new(x, y, text, opts)
	Text.super.new(self, { x = x, y = y, outside_camera = get(opts, 'outside_camera', false)})

	self.text         = lg.newText(get(opts, 'font', lg.getFont()), text)
	self.scale        = get(opts, 'scale', 1)
	self.radian       = get(opts, 'radian', 0)
	self.color        = get(opts, 'color', {1, 1, 1})
	self.centered     = get(opts, 'centered', false)
	self.scale_spring = Spring(self.scale)
end

function Text:update(dt)
	Text.super.update(self, dt)
	self.scale_spring:update(dt)
end

function Text:draw()
	lg.setColor(self.color)
	local offset_x, offset_y
	if self.centered then
		offset_x, offset_y = self.text:getWidth() / 2, self.text:getHeight() / 2
	end
	lg.draw(self.text, self.pos.x, self.pos.y, self.radian, self.scale_spring:get(), _, offset_x, offset_y)
	lg.setColor(1, 1, 1, 1)
end

function Text:set_text(text)
	self.text:set(text)
end

function Text:aabb()
	if self.centered then
		return {
			x = self.pos.x - self.text:getWidth() / 2, 
			y = self.pos.y - self.text:getHeight() / 2, 
			w = self.text:getWidth(), 
			h = self.text:getHeight()
		}
	else 
		return { 
			x = self.pos.x, 
			y = self.pos.y, 
			w = self.text:getWidth(), 
			h = self.text:getHeight()
		} 
	end
end
