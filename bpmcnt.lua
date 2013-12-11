BpmState = class('BpmState', State)

function BpmState:initialize()
	BpmState.bpmsum = 0
	BpmState.delta = 0
	BpmState.taps = -2
	BpmState.paused = false
end

function BpmState:update(dt)
	if not BpmState.paused and BpmState.taps > -2 then
		BpmState.delta = BpmState.delta + dt
	end
end

function BpmState:draw()
	local bps = BpmState.taps / BpmState.bpmsum
	local bpm = bps * 60
	local colorfactor = 255*BpmState.delta/bps
	love.graphics.setColor(0,0,0,255)
	love.graphics.rectangle("fill", 0, 0, 700, 700)
	if BpmState.taps > 15 then
		love.graphics.setColor(colorfactor,colorfactor,colorfactor,255)
	else
		love.graphics.setColor(0,0,0,255)
	end
	love.graphics.rectangle("fill", 10, 10, 80, 680)
	f:set(40)
	love.graphics.setColor(255,255,255,255)
	love.graphics.printf("sum:    "..BpmState.bpmsum, 100, 200, 300)
	love.graphics.printf("taps:   "..BpmState.taps, 100, 300, 300)
	love.graphics.printf("BPM:    "..bpm, 100, 400, 300)
	love.graphics.printf("offset: "..BpmState.delta, 100, 600, 300)
end

function BpmState:keypressed(key, unicode)
	if key == "s" then
		BpmState.paused = not BpmState.paused
	else
		if not BpmState.paused then
			BpmState.taps = BpmState.taps + 1
			if BpmState.taps > -1 then
				BpmState.bpmsum = BpmState.bpmsum + BpmState.delta
			end
			BpmState.delta = 0
		end
	end
end
