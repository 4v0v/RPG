-- The class responsible for holding an animation's graphics.
-- It takes in an already loaded image, the width and height of each frames, and a list of frames in terms of indexed position on the image.
-- player_sheet = Image('player_sheet')
-- player_idle_frames = AnimationFrames(player_sheet, 32, 32, {{1, 1}, {2, 1}})
-- player_run_frames = AnimationFrames(player_sheet, 32, 32, {{1, 2}, {2, 2}, {3, 2}})
-- player_attack_frames = AnimationFrames(player_sheet, 32, 32, {{1, 3}, {2, 3}, {3, 3}, {4, 3}})
--
-- In the example above we first load an image, and then load 3 player animations.
-- Each animation comes from different rows in the same spritesheet, and that's reflected by the last argument in each call.
-- If your animation comes from a single spritesheet that doesn't have multiple animations, then you can omit the last argument and it will automatically go through it.
AnimationFrames = Class:extend('AnimationFrames')

function AnimationFrames:new(image, frame_w, frame_h, frames_list)
  self.image   = image
	self.frame_w = frame_w
	self.frame_h = frame_h

  self.frames = {}
  for i, frame in ipairs(frames_list) do
		self.frames[i] = love.graphics.newQuad(
			(frame[1]-1) * self.frame_w, 
			(frame[2]-1) * self.frame_h, 
			self.frame_w, self.frame_h, 
			self.image:getWidth(), self.image:getHeight()
		)
	end
end

function AnimationFrames:draw(frame, x, y, r, sx, sy, ox, oy)
  love.graphics.draw(
		self.image, 
		self.frames[frame], 
		x, y, r or 0, sx or 1, sy or sx or 1, 
		self.frame_w/2 + (ox or 0), 
		self.frame_h/2 + (oy or 0)
	)
end

AnimationLogic = Class:extend('AnimationLogic')

function AnimationLogic:new(delay, frames, mode, actions)
	self.delay     = delay
	self.pause     = false
  self.frames    = frames
  self.mode      = mode or 'loop'
  self.actions   = actions
  self.timer     = 0
  self.frame     = 1
  self.direction = 1
end

function AnimationLogic:update(dt)
  if self.pause then return end

  self.timer = self.timer + dt
  local delay = self.delay
  if type(self.delay) == 'table' then delay = self.delay[self.frame] end

  if self.timer > delay then
    self.timer = 0
    self.frame = self.frame + self.direction
		if self.frame > self.frames or self.frame < 1 then
      if self.mode == 'once' then
        self.frame = self.frames
				self.pause = true
      elseif self.mode == 'loop' then
				self.frame = 1
      elseif self.mode == 'bounce' then
        self.direction = -self.direction
        self.frame = self.frame + 2 * self.direction
			end
    end
    if self.actions and self.actions[self.frame] then self.actions[self.frame]() end
  end
end

Animation =  Class:extend('Animation')

function Animation:new(delay, frames, mode, actions)
  self.delay      = delay
  self.frames     = frames
  self.size       = #frames.frames
  self.mode       = mode
  self.actions    = actions
  self.anim_logic = AnimationLogic(self.delay, self.size, self.mode, self.actions)
end

function Animation:update(dt)
  self.anim_logic:update(dt)
end

function Animation:draw(x, y, r, sx, sy, ox, oy, color)
  self.frames:draw(self.anim_logic.frame, x, y, r, sx, sy, ox, oy, color)
end

function Animation:reset()
	self.anim_logic.frame = 1
end

function Animation:set_actions(actions)
	self.anim_logic.actions = actions
end

function Animation:clone()
	return Animation(self.delay, self.frames, self.mode, self.actions)
end
