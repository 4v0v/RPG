Menu = Room:extend('Menu')

function Menu:new(id)
	Menu.super.new(self, id)
	self.font          = lg.newFont('assets/fonts/fixedsystem.ttf', 32)
	self.default_font  = lg.newFont()
	

	self:add('txt', Text(
		lg.getWidth()/2, 
		lg.getHeight()/2, 
		"Spring\x21",
		{
			font = lg.newFont('assets/fonts/fixedsystem.ttf', 32),
			outside_camera = true,
			centered = true,
			radian = 0.2
		}
	))
	
	
	self.is_inside = false
end

function Menu:update(dt)
	Menu.super.update(self, dt)

	local text = self:get('txt')

	if point_rect_collision({lm.getX(), lm.getY()}, text:aabb()) then
		if !self.is_inside then 
			text.scale_spring:pull(0.25)
			self.is_inside = true
		end
	else 
		self.is_inside = false 
	end

end
