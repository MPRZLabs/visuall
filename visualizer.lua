VisualizerState = class('VisualizerState', State)

function VisualizerState:initialize()
	self.delta = 0
	self.mainbeat = {1}
	self.upbeat = true
	self.twid = nil
	self.color = {100,100,100,100}
	self.bgcolordef = {255, 255, 255}
	self.bgcolor = self.bgcolordef
	self.melodystatus = {a = 0.5, b = 0.5, c = 0.5, d = 0.5, e = 0.5, f = 0.5, g = 0.5}
	self.melodytwid = {a = nil, b = nil, c = nil, d = nil, e = nil, f = nil, g = nil}
	self.maintaps = 0
	self:rndBg()
	self:rndCl()
	self.autobeat = false
	self.autotimer = 0
	self.melodytwid['a'] = tween(60/bpm, self.melodystatus, {a = 0})
	self.melodytwid['b'] = tween(60/bpm, self.melodystatus, {b = 0})
	self.melodytwid['c'] = tween(60/bpm, self.melodystatus, {c = 0})
	self.melodytwid['d'] = tween(60/bpm, self.melodystatus, {d = 0})
	self.melodytwid['e'] = tween(60/bpm, self.melodystatus, {e = 0})
	self.melodytwid['f'] = tween(60/bpm, self.melodystatus, {f = 0})
	self.melodytwid['g'] = tween(60/bpm, self.melodystatus, {g = 0})
	self.rctngl = love.image.newImageData(50, 500)
	self.rctngl:mapPixel(function() return 255, 255, 255, 255 end)
	self.rctngl = love.graphics.newImage(self.rctngl)
end

function VisualizerState:update(dt)
	self.delta = self.delta + dt
	if self.autobeat then
		self.autotimer = self.autotimer + dt
		if self.autotimer > 60/bpm then
			self.autotimer = self.autotimer - 60/bpm
			self:keypressed("f", 102)
		end
	end		
end

function VisualizerState:draw()
	love.graphics.setColor(self.bgcolor)
	love.graphics.rectangle("fill",0,0,700,700)
	love.graphics.setBlendMode("premultiplied")
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
	love.graphics.circle("fill", 350, 350, 150+20*self.mainbeat[1], 6 + self.maintaps)
	love.graphics.setColor(self.color[2], self.color[3], self.color[1], self.color[4])
	love.graphics.circle("fill", 350, 350, 60-20*self.mainbeat[1], 5 + self.maintaps)
	love.graphics.setColor(self.color[3], self.color[1], self.color[2], self.color[4])
	love.graphics.circle("fill", 350, 350, 24+20*self.mainbeat[1], 4 + self.maintaps)
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(-60), 1, self.melodystatus['a'], 25, 250)
	love.graphics.setColor(255, 165, 0, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(-40), 1, self.melodystatus['b'], 25, 250)
	love.graphics.setColor(255, 255, 0, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(-20), 1, self.melodystatus['c'], 25, 250)
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(0), 1, self.melodystatus['d'], 25, 250)
	love.graphics.setColor(0, 0, 255, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(20), 1, self.melodystatus['e'], 25, 250)
	love.graphics.setColor(75, 0, 130, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(40), 1, self.melodystatus['f'], 25, 250)
	love.graphics.setColor(143, 0, 255, 255)
	love.graphics.draw(self.rctngl, 350, 350, math.rad(60), 1, self.melodystatus['g'], 25, 250)
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
	if key == "1" then
		tween.stop(self.melodytwid['a'])
		tween.reset(self.melodytwid['a'])
		tween(60/bpm/4, self.melodystatus, {a = 1})
	end
	if key == "2" then
		tween.stop(self.melodytwid['b'])
		tween.reset(self.melodytwid['b'])
		tween(60/bpm/4, self.melodystatus, {b = 1})
	end
	if key == "3" then
		tween.stop(self.melodytwid['c'])
		tween.reset(self.melodytwid['c'])
		tween(60/bpm/4, self.melodystatus, {c = 1})
	end
	if key == "4" then
		tween.stop(self.melodytwid['d'])
		tween.reset(self.melodytwid['d'])
		tween(60/bpm/4, self.melodystatus, {d = 1})
	end
	if key == "5" then
		tween.stop(self.melodytwid['e'])
		tween.reset(self.melodytwid['e'])
		tween(60/bpm/4, self.melodystatus, {e = 1})
	end
	if key == "6" then
		tween.stop(self.melodytwid['f'])
		tween.reset(self.melodytwid['f'])
		tween(60/bpm/4, self.melodystatus, {f = 1})
	end
	if key == "7" then
		tween.stop(self.melodytwid['g'])
		tween.reset(self.melodytwid['g'])
		tween(60/bpm/4, self.melodystatus, {g = 1})
	end
	if key == "a" then
		self.autobeat = not self.autobeat
		self.autotimer = 0
	end
end

function VisualizerState:keyreleased(key, unicode)
	if key == "1" then
		tween.stop(self.melodytwid['a'])
		tween.reset(self.melodytwid['a'])
		tween(60/bpm, self.melodystatus, {a = 0})
	end
	if key == "2" then
		tween.stop(self.melodytwid['b'])
		tween.reset(self.melodytwid['b'])
		tween(60/bpm, self.melodystatus, {b = 0})
	end
	if key == "3" then
		tween.stop(self.melodytwid['c'])
		tween.reset(self.melodytwid['c'])
		tween(60/bpm, self.melodystatus, {c = 0})
	end
	if key == "4" then
		tween.stop(self.melodytwid['d'])
		tween.reset(self.melodytwid['d'])
		tween(60/bpm, self.melodystatus, {d = 0})
	end
	if key == "5" then
		tween.stop(self.melodytwid['e'])
		tween.reset(self.melodytwid['e'])
		tween(60/bpm, self.melodystatus, {e = 0})
	end
	if key == "6" then
		tween.stop(self.melodytwid['f'])
		tween.reset(self.melodytwid['f'])
		tween(60/bpm, self.melodystatus, {f = 0})
	end
	if key == "7" then
		tween.stop(self.melodytwid['g'])
		tween.reset(self.melodytwid['g'])
		tween(60/bpm, self.melodystatus, {g = 0})
	end
end
