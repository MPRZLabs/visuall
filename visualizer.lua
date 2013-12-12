VisualizerState = class('VisualizerState', State)

function VisualizerState:initialize()
	self.delta = 0
	self.mainbeat = {1}
	self.upbeat = true
	self.twid = nil
	self.color = {100,100,100,100}
	self.bgcolordef = {255, 255, 255}
	self.bgcolor = self.bgcolordef
	self.maintaps = 0
	self:rndBg()
end

function VisualizerState:update(dt)
	self.delta = self.delta + dt
end

function VisualizerState:draw()
	love.graphics.setColor(self.bgcolor)
	love.graphics.rectangle("fill",0,0,700,700)
	love.graphics.setBlendMode("multiplicative")
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
	love.graphics.circle("fill", 350, 350, 150+20*self.mainbeat[1], 6 + self.maintaps)
	love.graphics.setColor(self.color[2], self.color[3], self.color[1], self.color[4])
	love.graphics.circle("fill", 350, 350, 60-20*self.mainbeat[1], 5 + self.maintaps)
	love.graphics.setColor(self.color[3], self.color[1], self.color[2], self.color[4])
	love.graphics.circle("fill", 350, 350, 24+20*self.mainbeat[1], 4 + self.maintaps)
	love.graphics.setBlendMode("alpha")
end

function VisualizerState:rndBg()
	self.bgcolordef = {math.random(0,255),math.random(0,255),math.random(0,255)}
	tween(60/bpm, self.bgcolor, self.bgcolordef, "inOutSine")
end

function VisualizerState:rndCl()
	self.bgcolordef = {math.random(0,255),math.random(0,255),math.random(0,255), 100}
end

function VisualizerState:keypressed(key, unicode)
	if key == "f" then
		tween.reset(self.twid)
		tween.stop(self.twid)
		self.upbeat = false
		self.delta = 0
		self.mainbeat = {1}
		self.maintaps = self.maintaps + 1
		self.twid = tween(60/bpm, self.mainbeat, {-2}, "linear")
	end
	if key == "g" then
		tween.reset(self.themetwid)
		tween.stop(self.themetwid)
		self.bgcolor = {self.bgcolor[1] - 255/4, self.bgcolor[2] - 255/4, self.bgcolor[3] - 255/4}
		self.themetwid = tween(60/bpm, self.bgcolor, self.bgcolordef, "inOutSine")
	end
	if key == "u" then
		self:rndBg()
	end
	if key == "y" then
		self:rndCl()
	end
	if key == "t" then
		self:rndBg()
		self:rndCl()
	end
	if key == "i" then
		self.color = {255, 0, 0, 100}
	end
	if key == "o" then
		self.color = {0, 255, 0, 100}
	end
	if key == "p" then
		self.color = {0, 0, 255, 100}
	end
	if key == "k" then
		self.color = {255, 255, 0, 100}
	end
	if key == "l" then
		self.color = {0, 255, 255, 100}
	end
	if key == ";" then
		self.color = {255, 0, 255, 100}
	end
end
