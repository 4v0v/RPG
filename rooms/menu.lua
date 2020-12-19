Menu = Room:extend('Menu')

function Menu:new(id)
	Menu.super.new(self, id)
	
	self:add('txt', Text(lg.getWidth()/2, lg.getHeight()/2, "Spring\x21", 
		{
			font           = lg.newFont('assets/fonts/fixedsystem.ttf', 32),
			radian         = 0.2,
			centered       = true,
			outside_camera = true,
		})
	)
end

function Menu:update(dt)
	Menu.super.update(self, dt)

	local text = self:get('txt')

	if point_rect_collision({lm.getX(), lm.getY()}, text:aabb()) then
		self:once(fn()
			text.scale_spring:pull(0.25)
			self.is_inside = true
		end, 'is_inside')
	else 
		self.timer:remove('is_inside')
	end
end
