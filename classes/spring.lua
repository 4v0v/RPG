Spring = Class:extend('Spring')

function Spring:new(value, stiffness, dampening)
    self.target = value
    self.value  = value
    self.v      = 0
    self.stiffness = stiffness or 100
    self.dampening = dampening or 10
end

function Spring:update(dt)
		local diff = self.value - self.target
		local a    = -self.stiffness * diff - self.dampening * self.v
		
    self.v     = self.v + a * dt
    self.value = self.value + self.v * dt
end

function Spring:pull(force)
    self.value = self.value + force
end

function Spring:get() 
	return self.value
end

function Spring:set(x) 
	self.target, self.value = x, x 
end
