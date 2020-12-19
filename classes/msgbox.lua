Msgbox = Class:extend('Msgbox')

function Msgbox:new()
	self.timer         = Timer()
	self.font          = lg.newFont('assets/fonts/fixedsystem.ttf', 32)
	self.default_font  = lg.newFont()
	self.typing_sound  = la.newSource("assets/sounds/typewriter.wav", "static")
	self.opt_char      = '-'
	self.padding       = 10
	self.msg_color     = {1, 1, 1, 1}
	self.title_color   = {0, 1, 1, 1}
	self.box_color     = {0, 0, 0, .4}
	self.messages      = {}
	self.current_text  = ''
	self.current_index = 0
	self.is_blinking   = true
	self.is_typing     = true

	self.timer:every(.4, fn() 
		self.is_blinking = !self.is_blinking 
	end, _, 'blink')

	self.timer:every(.03, fn() 
		if self:is_empty() then return end
		local text = self.messages[1].text

		if text == self.current_text then
			if self.is_typing then self.is_typing = false end
		else 
			local next_letter = text:sub(self.current_index, self.current_index)
			self.current_text ..= next_letter
			self.current_index += 1
			self.typing_sound:play()
		end
	end, _, 'push_new_letter')
end

function Msgbox:update(dt)
	self.timer:update(dt)
end

function Msgbox:draw()
	if self:is_empty() then return end
	local message = self.messages[1]

	local width, height = lg.getDimensions()
	local text   = message.text
	local title  = message.title
	local box_w  = width - (2 * self.padding)
	local box_h  = (height / 3) - (2 * self.padding)
	local box_x  = self.padding
	local box_y  = height - (box_h + self.padding)
	local text_x = self.padding * 2
	local text_y = height - (box_h + self.padding )
	local text_w = width - (2 * (self.padding * 2))

	if title then
		local title_box_x = self.padding
		local title_box_y = box_y - self.padding - self.font:getHeight()
		local title_box_w = self.font:getWidth(title) + (self.padding * 2)
		local title_box_h = self.font:getHeight()
		local title_x     = self.padding * 2
		local title_y     = title_box_y

		lg.setColor(self.box_color)
		lg.rectangle('fill', title_box_x, title_box_y, title_box_w, title_box_h) 

		lg.setFont(self.font)
		lg.setColor(self.title_color)
		lg.print(title, title_x, title_y )
	end

	lg.setColor(self.box_color)
	lg.rectangle('fill', box_x, box_y, box_w, box_h)

	lg.setFont(self.font)
	lg.setColor(self.msg_color)
	lg.printf(self.current_text, text_x, text_y, text_w ) 

	if self.is_blinking && !self.is_typing then
		local char_x = width - self.padding * 2 - self.font:getWidth('>')
		local char_y = height - self.padding * 2 - self.font:getHeight()
		lg.setColor(1, 1, 1)
		lg.setFont(self.font)
		lg.print('>', char_x, char_y )
	end

	lg.setFont(self.default_font)
end

function Msgbox:add(...)
	local messages = {...}
	for messages do 
		table.insert(self.messages, it)
	end
end

function Msgbox:next()
	if self:is_empty() then return end
	local text = self.messages[1].text

	if self.current_text == text then 
		table.remove(self.messages, 1)
		self.current_text = ''
		self.current_index = 0
		self.is_typing = true
	else
		self.current_text = text
	end
end

function Msgbox:is_empty()
	return #self.messages == 0
end
