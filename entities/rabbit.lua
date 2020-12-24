Rabbit = Entity:extend('Rabbit')
Rabbit.spritesheet  = lg.newImage('assets/images/rabbit.png')
Rabbit.frames_move_down  = AnimationFrames(Rabbit.spritesheet, 37, 37, _, _,{{1, 1},  {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1}, {8, 1}})


function Rabbit:new(x, y)
	Rabbit.super.new(self, { x = x, y = y})

	self.anim_move_down  = Animation(.3, Rabbit.frames_move_down  )

end

function Rabbit:update(dt)
	Rabbit.super.update(self, dt)
	self.anim_move_down:update(dt)

end

function Rabbit:draw()

	self.anim_move_down:draw(self.pos.x, self.pos.y, _, 5, 5)

end

function Rabbit:aabb()

end