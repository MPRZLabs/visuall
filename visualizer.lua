VisualizerState = class('VisualizerState', State)

function VisualizerState:initialize()
	self.delta = 0
	self.mainbeat = {1}
	self.upbeat = true
	self.twid = nil
	self.color = {100,100,100,100}
end

function VisualizerState:update(dt)
	self.delta = self.delta + dt
	local bps = 60/(2*bpm)
	if self.delta > bps then
		self.delta = 0
		if self.twid ~= nil then
			tween.stop(self.twid)
			tween.reset(self.twid)
		end
		if self.upbeat then
			self.twid = tween(bps, self.mainbeat, {-1}, "linear")
		else
			self.twid = tween(bps, self.mainbeat, {1}, "inOutElastic")
		end
		self.upbeat = not self.upbeat
	end
end

function VisualizerState:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.rectangle("fill",0,0,700,700)
	love.graphics.setBlendMode("multiplicative")
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
	love.graphics.circle("fill", 350, 350, 150+20*self.mainbeat[1], 3)
	love.graphics.setColor(self.color[2], self.color[3], self.color[1], self.color[4])
	love.graphics.circle("fill", 350, 350, 60-20*self.mainbeat[1], 4)
	love.graphics.setColor(self.color[3], self.color[1], self.color[2], self.color[4])
	love.graphics.circle("fill", 350, 350, 24+20*self.mainbeat[1], 5)
	love.graphics.setBlendMode("alpha")
end

function VisualizerState:keypressed(key, unicode)
	if key == " " then
		tween.resetAll()
		tween.stopAll()
		self.upbeat = false
		self.delta = 0
		self.mainbeat = {1}
		self.twid = tween(60/(2*bpm), self.mainbeat, {-1}, "linear")
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
