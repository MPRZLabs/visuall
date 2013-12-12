MenuState = class('MenuState', State)

function MenuState:initialize()
	self.beattime = {0,{255,255,255,255}}
	bpm = 144
end

function MenuState:update(dt)
	self.beattime[1] = self.beattime[1] + dt
	if self.beattime[1] >= 60/bpm then
		self.beattime[1] = self.beattime[1] - 60/bpm
		self.beattime[2][4] = 255-self.beattime[1]*255
		self.beattime[2] = {255,255,255,self.beattime[2][4]}
	else
		self.beattime[2][4] = 255-self.beattime[1]*255
	end
	print(self.beattime[2][4])
end

function MenuState:draw()
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 0, 0, 700, 700)
	love.graphics.setColor(255,255,255,255)
	f:set(40)
	love.graphics.setColor(0,255,0,self.beattime[2][4])
	love.graphics.printf("Visuall", 50, 150, 600, "center")
	x, y = love.mouse.getPosition()
	love.graphics.setColor(255,0,0,self.beattime[2][4])
	if x>= 50 and x<=300 and y>=300 and y<=400 then
		love.graphics.rectangle("line", 50, 300, 250, 100)
	else
		love.graphics.rectangle("fill", 50, 300, 250, 100)
	end
	love.graphics.setColor(0,0,255,self.beattime[2][4])
	if x>=400 and x<=650 and y>=300 and y<=400 then
		love.graphics.rectangle("line", 400, 300, 250, 100)
	else
		love.graphics.rectangle("fill", 400, 300, 250, 100)
	end
	love.graphics.setColor(255,255,0,self.beattime[2][4])
	if x>= 50 and x<= 300 and y>=450 and y<=550 then
		love.graphics.rectangle("line", 50, 450, 250, 100)
	else
		love.graphics.rectangle("fill", 50, 450, 250, 100)
	end
	love.graphics.setColor(255,255,255,255)
	f:set(40)
	love.graphics.printf("BPM Counter",   50, 300, 200, "right")
	love.graphics.printf("Run the beat", 450, 300, 200, "left")
	f:set(30)
	love.graphics.printf("Manual BPM input", 50, 450, 200, "right")
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
