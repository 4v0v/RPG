Msgbox = Entity:extend('Msgbox')

function Msgbox:new()
	House.super.new(@, {x = 0, y = 0, z = 100, outside_camera = true})
	@.font          = lg.newFont('assets/fonts/fixedsystem.ttf', 32)
	@.default_font  = lg.newFont()
	@.typing_sound  = la.newSource("assets/sounds/typewriter.wav", "static")
	@.opt_char      = '-'
	@.padding       = 10
	@.msg_color     = {1, 1, 1, 1}
	@.title_color   = {0, 1, 1, 1}
	@.box_color     = {0, 0, 0, .4}
	@.messages      = {}
	@.current_text  = ''
	@.current_index = 0
	@.is_blinking   = true
	@.is_typing     = true

	@.timer:every(.4, fn() 
		@.is_blinking = !@.is_blinking 
	end, _, 'blink')

	@.timer:every(.03, fn() 
		if @:is_empty() then return end
		local text = @.messages[1].text

		if text == @.current_text then
			if @.is_typing then @.is_typing = false end
		else 
			local next_letter = text:sub(@.current_index, @.current_index)
			@.current_text ..= next_letter
			@.current_index += 1
			@.typing_sound:play()
		end
	end, _, 'push_new_letter')
end

function Msgbox:update(dt)
	Msgbox.super.update(@, dt)
end

function Msgbox:draw()
	if @:is_empty() then return end
	local message = @.messages[1]

	local width, height = lg.getDimensions()
	local text   = message.text
	local title  = message.title
	local box_w  = width - (2 * @.padding)
	local box_h  = (height / 3) - (2 * @.padding)
	local box_x  = @.padding
	local box_y  = height - (box_h + @.padding)
	local text_x = @.padding * 2
	local text_y = height - (box_h + @.padding )
	local text_w = width - (2 * (@.padding * 2))

	if title then
		local title_box_x = @.padding
		local title_box_y = box_y - @.padding - @.font:getHeight()
		local title_box_w = @.font:getWidth(title) + (@.padding * 2)
		local title_box_h = @.font:getHeight()
		local title_x     = @.padding * 2
		local title_y     = title_box_y

		lg.setColor(@.box_color)
		lg.rectangle('fill', title_box_x, title_box_y, title_box_w, title_box_h) 

		lg.setFont(@.font)
		lg.setColor(@.title_color)
		lg.print(title, title_x, title_y )
	end

	lg.setColor(@.box_color)
	lg.rectangle('fill', box_x, box_y, box_w, box_h)

	lg.setFont(@.font)
	lg.setColor(@.msg_color)
	lg.printf(@.current_text, text_x, text_y, text_w ) 

	if @.is_blinking && !@.is_typing then
		local char_x = width - @.padding * 2 - @.font:getWidth('>')
		local char_y = height - @.padding * 2 - @.font:getHeight()
		lg.setColor(1, 1, 1)
		lg.setFont(@.font)
		lg.print('>', char_x, char_y )
	end

	lg.setFont(@.default_font)
end

function Msgbox:add(...)
	local messages = {...}
	for messages do
		if #it == 1 then 
			it = {text = it[1]}
		elseif #it == 2 then 
			it = {title = it[1], text = it[2]}
		end
		table.insert(@.messages, it)
	end
end

function Msgbox:next()
	if @:is_empty() then return end
	local text = @.messages[1].text

	if @.current_text == text then 
		table.remove(@.messages, 1)
		@.current_text = ''
		@.current_index = 0
		@.is_typing = true
	else
		@.current_text = text
	end
end

function Msgbox:is_empty()
	return #@.messages == 0
end
