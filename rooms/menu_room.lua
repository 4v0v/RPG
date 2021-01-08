Menu_room = Room:extend('Menu_room')

function Menu_room:new(id)
	Menu_room.super.new(@, id)
	
	@:add('txt', Text(lg.getWidth()/2, lg.getHeight()/2, "Spring\x21", 
		{
			font           = lg.newFont('assets/fonts/fixedsystem.ttf', 32),
			centered       = true,
			outside_camera = true,
		})
	)
end

function Menu_room:update(dt)
	Menu_room.super.update(@, dt)
	if pressed('1') then game:change_room('play') end

	local text = @:get('txt')

	if point_rect_collision({lm:getX(), lm:getY()}, text:aabb()) then
		@:once(fn()
			text.scale_spring:change(2)
		end, 'is_inside')
	else 
		if @.timer:remove('is_inside') then 
			text.scale_spring:change(1)
		end
	end
end
