Menu = Room:extend('Menu')

function Menu:new(id)
	Menu.super.new(@, id)
	
	@:add('txt', Text(lg.getWidth()/2, lg.getHeight()/2, "Spring\x21", 
		{
			font           = lg.newFont('assets/fonts/fixedsystem.ttf', 32),
			radian         = .2,
			centered       = true,
			outside_camera = true,
		})
	)
end

function Menu:update(dt)
	Menu.super.update(@, dt)

	local text = @:get('txt')

	local _x, _y = lm:getPosition()

	if point_rect_collision({_x, _y}, text:aabb()) then
		@:once(fn()
			text.scale_spring:pull(.25)
		end, 'is_inside')
	else 
		@.timer:remove('is_inside')
	end
end
