MenuState = class('MenuState', State)

function MenuState:initialize()
	MenuState.beattime = {0,{255,255,255,255}}
end

function MenuState:update(dt)
	MenuState.beattime[1] = MenuState.beattime[1] + dt
	if MenuState.beattime[1] >= 60/144 then
		MenuState.beattime[1] = MenuState.beattime[1] - 60/144
		MenuState.beattime[2][4] = 255-MenuState.beattime[1]*255
		MenuState.beattime[2] = {255,255,255,MenuState.beattime[2][4]}
	else
		MenuState.beattime[2][4] = 255-MenuState.beattime[1]*255
	end
	print(MenuState.beattime[2][4])
end

function MenuState:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill", 0, 0, 700, 700)
end
