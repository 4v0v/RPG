Spring = Class:extend('Spring')

function Spring:new(value, stiffness, dampening)
    @.target = value
    @.value  = value
    @.v      = 0
    @.stiffness = stiffness or 100
    @.dampening = dampening or 10
end

function Spring:update(dt)
		local diff = @.value - @.target
		local a    = -@.stiffness * diff - @.dampening * @.v
		
    @.v     = @.v + a * dt
    @.value = @.value + @.v * dt
end

function Spring:pull(force)
    @.value = @.value + force
end

function Spring:set(x) 
	@.target = x
end

function Spring:set_immediate(x) 
	@.target, @.value = x, x 
end

function Spring:get() 
	return @.value
end