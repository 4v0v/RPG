Player = Entity:extend('Player')

Player.spritesheet = lg.newImage('assets/images/blk.png')

Player.frames_move_up    = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 1},  {3, 1}})
Player.frames_move_left  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 4},  {3, 4}})
Player.frames_move_down  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 3},  {3, 3}})
Player.frames_move_right = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{1, 2},  {3, 2}})
Player.frames_idle_up    = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 1}})
Player.frames_idle_left  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 4}})
Player.frames_idle_down  = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 3}})
Player.frames_idle_right = AnimationFrames(Player.spritesheet, 24,  32, _, _, {{2, 2}})

function Player:new(x, y)
	Player.super.new(@, {x = x, y = y})
	
	@.speed = 500
	@.dir   = Vec2(0, 1)
	@.state = 'idle_down'

	@.anim_move_up    = Animation(.3, Player.frames_move_up    )
	@.anim_move_left  = Animation(.3, Player.frames_move_left  )
	@.anim_move_down  = Animation(.3, Player.frames_move_down  )
	@.anim_move_right = Animation(.3, Player.frames_move_right )

	@.anim_run_up     = Animation(.1, Player.frames_move_up    )
	@.anim_run_left   = Animation(.1, Player.frames_move_left  )
	@.anim_run_down   = Animation(.1, Player.frames_move_down  )
	@.anim_run_right  = Animation(.1, Player.frames_move_right )

	@.anim_idle_up    = Animation(.3, Player.frames_idle_up    )
	@.anim_idle_left  = Animation(.3, Player.frames_idle_left  )
	@.anim_idle_down  = Animation(.3, Player.frames_idle_down  )
	@.anim_idle_right = Animation(.3, Player.frames_idle_right )
end

function Player:update(dt)
	Player.super.update(@, dt)

	if @.state == 'move_left' then 
		@.anim_move_left:update(dt)
		@.pos.x = @.pos.x - @.speed * dt
		@.dir = Vec2(-1, 0)

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

	elseif @.state == 'run_left' then 
		@.anim_run_left:update(dt)
		@.pos.x -= @.speed * 2 * dt
		@.dir    = Vec2(-1, 0)

	elseif @.state == 'run_right' then
		@.anim_run_right:update(dt)
		@.pos.x += @.speed * 2 * dt 
		@.dir    = Vec2(1, 0)

	elseif @.state == 'run_up'    then
		@.anim_run_up:update(dt)
		@.pos.y -= @.speed * 2 * dt
		@.dir    = Vec2(0, -1)

	elseif @.state == 'run_down'  then
		@.anim_run_down:update(dt)
		@.pos.y += @.speed * 2 * dt
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

	@.z = (@.pos.y - (32 * 5)/2 + 120)  + ( 32 * 5 - 120)
end

function Player:draw()
	Player.super.draw(@)

	if @.state == 'move_left' then 
		@.anim_move_left:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'move_right' then
		@.anim_move_right:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'move_up'    then
		@.anim_move_up:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'move_down'  then
		@.anim_move_down:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'run_left' then 
		@.anim_run_left:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'run_right' then
		@.anim_run_right:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'run_up'    then
		@.anim_run_up:draw(@.pos.x, @.pos.y, _, 5, 5)

	elseif @.state == 'run_down'  then
		@.anim_run_down:draw(@.pos.x, @.pos.y, _, 5, 5)

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

function Player:stop_moving()
	if @:is_state('move_left') || @:is_state('run_left') then 
		@:set_state('idle_left')

	elseif @:is_state('move_right') || @:is_state('run_right') then 
		@:set_state('idle_right')

	elseif @:is_state('move_up') || @:is_state('run_up') then 
		@:set_state('idle_up')

	elseif @:is_state('move_down') || @:is_state('run_down') then 
		@:set_state('idle_down')
	end
end

function Player:aabb()
	return {
		x = @.pos.x - (24 * 5)/2 + 20,
		y = @.pos.y - (32 * 5)/2 + 120,
		w = 24 * 5 - 40,
		h = 32 * 5 - 120,
	}
end
