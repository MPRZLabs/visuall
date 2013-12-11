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
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 0, 0, 700, 700)
	love.graphics.setColor(255,255,255,255)
	f:set(40)
	love.graphics.setColor(0,255,0,MenuState.beattime[2][4])
	love.graphics.printf("Visuall", 50, 50, 600, "center")
	f:set(20)
	love.graphics.setColor(255,0,0,MenuState.beattime[2][4])
	love.graphics.printf("BPM Counter", 50, 300, 250, "right")
	love.graphics.setColor(0,0,255,MenuState.beattime[2][4])
	love.graphics.printf("Run the beat", 400, 300, 250, "left")
end
