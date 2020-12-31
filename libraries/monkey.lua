table.insert(package.loaders, 2, function(name)
	local name = name:gsub("%.", "/") .. ".lua"
	local file = love.filesystem.read(name)
	if not file then return end

	local number = "([%d]+)"
	local var = "([%w%.:_%[%]'\"]+)"
	local simple_var = "([%w_]+)"
	local var_with_parenthesis = "([%w%.:_%[%]'\"%(%)]+)"

	local patterns = {
		{ pattern = "%-%-[^\n]+"     , replacement = ""}, -- remove comments
		{ pattern = "@"              , replacement = "self"},
		{ pattern = var .. "%s*%+="  , replacement = "%1 = %1 + "}, -- +=
		{ pattern = var .. "%s*%-="  , replacement = "%1 = %1 - "}, -- -=
		{ pattern = var .. "%s*%*="  , replacement = "%1 = %1 * "}, -- *=
		{ pattern = var .. "%s*/="   , replacement = "%1 = %1 / "}, -- /=
		{ pattern = var .. "%s*^="   , replacement = "%1 = %1 ^ "}, -- ^=
		{ pattern = var .. "%s*%%="  , replacement = "%1 = %1 %% "}, -- %=
		{ pattern = var .. "%s*%.%.=", replacement = "%1 = %1 .. "}, -- ..=
		{ pattern = var .. "%s*%+%+" , replacement = "%1 = %1 + 1"}, -- ++
		{ pattern = "&&"             , replacement = " and "},
		{ pattern = "||"             , replacement = " or "},
		{ pattern = "!="             , replacement = "~="},
		{ pattern = "!" .. var_with_parenthesis, replacement = " not %1"},
		{ pattern = "([%s,={%(])fn%(", replacement = "%1function("}, -- fn() end
		{ pattern = "for[%s]+".. number .. "[%s]+do", replacement = "for it = 1, %1 do"}, -- for 100 do end
		{ pattern = "for[%s]+".. var_with_parenthesis .. "[%s]+do", replacement = "for key, it in pairs(%1) do"}, -- for table do end
		{ pattern = "for[%s]+".. simple_var .. "[%s]+in[%s]+" .. var .. "[%s]+do", replacement = "for key, %1 in pairs(%2) do"}, -- for value in table do end
		{ pattern = "for[%s]+".. simple_var .. ",[%s]?" .. simple_var .. "[%s]+in[%s]+" .. var .. "[%s]+do", replacement = "for %1, %2 in pairs(%3) do"}, -- for key, value in table do end
	}

	for i, v in ipairs(patterns) do file = file:gsub(v.pattern, v.replacement) end
	return assert(loadstring(file))
end)
