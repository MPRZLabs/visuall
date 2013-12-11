VisualizerState = class('VisualizerState', State)

function VisualizerState:initialize()
	self.delta = 0
	self.mainbeat = {1}
	self.upbeat = true
	self.twid = nil
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
			self.twid = tween(bps, self.mainbeat, {-1}, "inOutElastic")
		else
			self.twid = tween(bps, self.mainbeat, {1}, "linear")
		end
		self.upbeat = not self.upbeat
	end
end

function VisualizerState:draw()
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill",0,0,700,700)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.circle("fill", 350, 350, 150+20*self.mainbeat[1], 15)
end
