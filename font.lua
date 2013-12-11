local fonts = {}
fonts.storage = {}
function fonts:get(size)
	if fonts.storage[size] then

	else
		fonts.storage[size] = love.graphics.newFont(size)
	end
	return fonts.storage[size]
end
function fonts:set(size)
	love.graphics.setFont(fonts:get(size))
end
return fonts
