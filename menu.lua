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
	love.graphics.printf("Visuall", 50, 150, 600, "center")
	x, y = love.mouse.getPosition()
	love.graphics.setColor(255,0,0,MenuState.beattime[2][4])
	if x>= 50 and x<=300 and y>=300 and y<=400 then
		love.graphics.rectangle("line", 50, 300, 250, 100)
	else
		love.graphics.rectangle("fill", 50, 300, 250, 100)
	end
	love.graphics.setColor(0,0,255,MenuState.beattime[2][4])
	if x>=400 and x<=650 and y>=300 and y<=400 then
		love.graphics.rectangle("line", 400, 300, 250, 100)
	else
		love.graphics.rectangle("fill", 400, 300, 250, 100)
	end
	love.graphics.setColor(0,0,0,255)
	love.graphics.printf("BPM Counter",   50, 300, 200, "right")
	love.graphics.printf("Run the beat", 450, 300, 200, "left")
end

function MenuState:mousepressed(x,y,b)
	if b == "l" then
		if x>= 50 and x<=300 and y>=300 and y<=400 then
			statechange(gamestates['beat'])
		end
		if x>=400 and x<=650 and y>=300 and y<=400 then
			statechange(gamestates['visu'])
		end
	end
end
