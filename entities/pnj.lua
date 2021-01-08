Pnj = Entity:extend('Pnj')

Pnj.spritesheet = lg.newImage('assets/images/nun.png')

Pnj.frames_move_up    = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{1, 1},  {3, 1}})
Pnj.frames_move_right = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{1, 2},  {3, 2}})
Pnj.frames_move_down  = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{1, 3},  {3, 3}})
Pnj.frames_move_left  = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{1, 4},  {3, 4}})
Pnj.frames_idle_up    = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{2, 1}})
Pnj.frames_idle_right = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{2, 2}})
Pnj.frames_idle_down  = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{2, 3}})
Pnj.frames_idle_left  = AnimationFrames(Pnj.spritesheet, 24,  32, _, _, {{2, 4}})

function Pnj:new(x, y)
	Pnj.super.new(@, {x = x, y = y, z = 5})
	
	@.speed       = 500
	@.direction   = Vec2(-1, 0)
	@.state       = 'idle_down'

	@.anim_move_up    = Animation(.3, Pnj.frames_move_up    )
	@.anim_move_left  = Animation(.3, Pnj.frames_move_left  )
	@.anim_move_down  = Animation(.3, Pnj.frames_move_down  )
	@.anim_move_right = Animation(.3, Pnj.frames_move_right )
	@.anim_idle_up    = Animation(.3, Pnj.frames_idle_up    )
	@.anim_idle_left  = Animation(.3, Pnj.frames_idle_left  )
	@.anim_idle_down  = Animation(.3, Pnj.frames_idle_down  )
	@.anim_idle_right = Animation(.3, Pnj.frames_idle_right )

	@:every(3, function()
		@:set_state(random_value({'idle_left', 'idle_right', 'idle_up', 'idle_down'}))
	end, _, 'change_direction')
end

function Pnj:update(dt)
	Pnj.super.update(@, dt)

	if @.state == 'move_left' then 
		@.anim_move_left:update(dt)
		@.pos.x -= @.speed * dt
		@.dir    = Vec2(-1, 0)

	elseif @.state == 'move_right' then
		@.anim_move_right:update(dt)
		@.pos.x += @.speed * dt 
		@.dir    = Vec2(1, 0)

	elseif @.state == 'move_up'    then
		@.anim_move_up:update(dt)
		@.pos.y -= @.speed * dt
		@.dir    = Vec2(0, -1)

	elseif @.state == 'move_down'  then
		@.anim_move_down:update(dt)
		@.pos.y += @.speed * dt
		@.dir    = Vec2(0, 1)

	elseif @.state == 'idle_left'  then
		@.anim_idle_left:update(dt)
		@.dir = Vec2(-1, 0)

	elseif @.state == 'idle_right' then
		@.anim_idle_right:update(dt)
		@.dir = Vec2(1, 0)

	elseif @.state == 'idle_up'    then
		@.anim_idle_up:update(dt)
		@.dir = Vec2(0, -1)

	elseif @.state == 'idle_down'  then
		@.anim_idle_down:update(dt)
		@.dir = Vec2(0, 1)
	end

	@.z = (@.pos.y - (32 * 5)/2 + 120) + (32 * 5 - 120)
end

function Pnj:draw()
	Pnj.super.draw(@)

	if @.state == 'move_left' then 
		@.anim_move_left:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'move_right' then
		@.anim_move_right:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'move_up'    then
		@.anim_move_up:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'move_down'  then
		@.anim_move_down:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'idle_left'  then
		@.anim_idle_left:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'idle_right' then
		@.anim_idle_right:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'idle_up'    then
		@.anim_idle_up:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'idle_down'  then
		@.anim_idle_down:draw(@.pos.x, @.pos.y, _, 5, 5)
	end
end

function Pnj:aabb()
	return {
		x = @.pos.x - (24 * 5)/2 + 20,
		y = @.pos.y - (32 * 5)/2 + 120,
		w = 24 * 5 - 40,
		h = 32 * 5 - 120,
	}
end