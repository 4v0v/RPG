Msgbox = Class:extend('Msgbox')

function Msgbox:new()
	self.font = lg.newFont("assets/fonts/fixedsystem.ttf", 32)
	self.default_font = lg.newFont()
	self.ind_char = ">"
	self.opt_char = "-"
	self.padding  = 10
	self.msg_color = {1, 1, 1, 1}
	self.msxbox_color = {0, 0, 0, .4}


	self.messages = {}
end

function Msgbox:update(dt)
end

function Msgbox:draw()
	local width, height = lg.getDimensions()
	local box_w   = width - (2 * self.padding)
	local box_h   = (height / 3) - (2 * self.padding)
	local box_x   = self.padding
	local box_y   = height - (box_h + self.padding)

	local text_x  = self.padding * 2
	local text_y  = height - (box_h + self.padding )
	local text_w  = width - (2 * (self.padding * 2))

	local message = self.messages[1]

	if !message then return end

	local text  = self.messages[1].text
	local title = self.messages[1].title

	-- msg box
	lg.setColor(self.msxbox_color)
	lg.rectangle("fill", box_x, box_y, box_w, box_h) 

	-- msg text
	lg.setFont(self.font)
	lg.setColor(self.msg_color)
	lg.printf(text, text_x, text_y, text_w ) 
	lg.setFont(self.default_font)
end


function Msgbox:add(msg)
	table.insert(self.messages, msg)
end

function Msgbox:next()
	table.remove(self.messages, 1)
end

function Msgbox:is_empty()
	return #self.messages == 0
end
