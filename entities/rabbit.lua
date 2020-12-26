Rabbit = Entity:extend('Rabbit')
Rabbit.spritesheet  = lg.newImage('assets/images/rabbit.png')

Rabbit.frames_move_up    = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 1}, {2, 1}, {3, 1}, {4, 1}})
Rabbit.frames_move_left  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 2}, {2, 6}, {2, 2}, {3, 2}, {4, 2}, {1, 2}})
Rabbit.frames_move_down  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 3}, {2, 3}, {3, 3}, {4, 3}})
Rabbit.frames_move_right = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 4}, {2, 4}, {3, 4}, {4, 4}, {1, 4}})
Rabbit.frames_idle_up    = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 5}, {2, 5}, {3, 5}, {4, 5}})
Rabbit.frames_idle_left  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 6}, {2, 6}, {3, 6}, {4, 6}})
Rabbit.frames_idle_down  = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 7}, {2, 7}, {3, 7}, {4, 7}})
Rabbit.frames_idle_right = AnimationFrames(Rabbit.spritesheet, 72, 72, _, _,{{1, 8}, {2, 8}, {3, 8}, {4, 8}})

function Rabbit:new(x, y)
	Rabbit.super.new(@, { x = x, y = y})

	@:set_state(random_value({'move_left', 'move_right'}))

	local _speed = love.math.random() * .3

	@.anim_move_up    = Animation(_speed, Rabbit.frames_move_up    )
	@.anim_move_left  = Animation(_speed, Rabbit.frames_move_left  )
	@.anim_move_down  = Animation(_speed, Rabbit.frames_move_down  )
	@.anim_move_right = Animation(_speed, Rabbit.frames_move_right )
	@.anim_idle_up    = Animation(_speed, Rabbit.frames_idle_up    )
	@.anim_idle_left  = Animation(_speed, Rabbit.frames_idle_left  )
	@.anim_idle_down  = Animation(_speed, Rabbit.frames_idle_down  )
	@.anim_idle_right = Animation(_speed, Rabbit.frames_idle_right )

	@.anim_move_left:set_actions({
		[3] = fn() @.pos.x -= 64 end,
		[4] = fn() @.pos.x -= 64 end,
	})

	@.anim_move_right:set_actions({
		[2] = fn() @.pos.x += 64 end,
		[3] = fn() @.pos.x += 64 end,
	})

	@:every(5, fn() 
		if @:is_state('move_left') then 
			@:set_state('move_right')
		elseif @:is_state('move_right') then
			@:set_state('move_left')
		end
	end, _, 'change_direction')
end

function Rabbit:update(dt)
	Rabbit.super.update(@, dt)

	if @:is_state('move_left') then 
		@.anim_move_left:update(dt)
	elseif @:is_state('move_right') then
		@.anim_move_right:update(dt)
	end

	-- @.anim_move_up:update(dt)
	-- @.anim_move_down:update(dt)
	-- @.anim_move_right:update(dt)
	-- @.anim_idle_up:update(dt)
	-- @.anim_idle_left:update(dt)
	-- @.anim_idle_down:update(dt)
	-- @.anim_idle_right:update(dt)

	@.z = @.pos.y

end

function Rabbit:draw()
	if @:is_state('move_left') then 
		@.anim_move_left:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @:is_state('move_right') then
		@.anim_move_right:draw(@.pos.x, @.pos.y, _, 5, 5)
	end

	-- @.anim_move_up:draw(@.pos.x, @.pos.y, _, 5, 5)
	-- @.anim_move_down:draw(@.pos.x, @.pos.y, _, 5, 5)
	-- @.anim_move_right:draw(@.pos.x, @.pos.y, _, 5, 5)
	-- @.anim_idle_up:draw(@.pos.x, @.pos.y, _, 5, 5)
	-- @.anim_idle_left:draw(@.pos.x, @.pos.y, _, 5, 5)
	-- @.anim_idle_down:draw(@.pos.x, @.pos.y, _, 5, 5)
	-- @.anim_idle_right:draw(@.pos.x, @.pos.y, _, 5, 5)
end

function Rabbit:aabb()
end
