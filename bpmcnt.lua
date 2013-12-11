BpmState = class('BpmState', State)

function BpmState:initialize()
	self.bpmsum = 0
	self.delta = 0
	self.taps = -2
	self.paused = false
end

function BpmState:update(dt)
	if not self.paused and self.taps > -2 then
		self.delta = self.delta + dt
	end
end

function BpmState:draw()
	local bps = self.taps / self.bpmsum
	local bpm = bps * 60
	local colorfactor = 255*self.delta/bps
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 0, 0, 700, 700)
	if self.taps > 15 then
		love.graphics.setColor(colorfactor,colorfactor,colorfactor,255)
	else
		love.graphics.setColor(0,0,0,255)
	end
	love.graphics.rectangle("fill", 10, 10, 80, 680)
	f:set(40)
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf("sum:    "..self.bpmsum, 100, 200, 300)
	love.graphics.printf("taps:   "..self.taps, 100, 300, 300)
	love.graphics.printf("BPM:    "..bpm, 100, 400, 300)
	love.graphics.printf("offset: "..self.delta, 100, 600, 300)
end

function BpmState:keypressed(key, unicode)
	if key == "s" then
		self.paused = not self.paused
	else
		if not self.paused then
			self.taps = self.taps + 1
			if self.taps > -1 then
				self.bpmsum = self.bpmsum + self.delta
			end
			self.delta = 0
		end
	end
end
