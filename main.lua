require 'req'

function love.load()
	statechange(gamestates['menu'])
end

function love.update(dt)
	gamestate:update(dt)
	tween.update(dt)
end

function love.draw()
	gamestate:draw(dt)
end

function love.mousepressed(x, y, button)
	gamestate.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	gamestate.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.quit()
	end
	gamestate.keypressed(key)
end

function love.keyreleased(key)
	gamestate.keyreleased(key)
end

function statechange(state)
	gamestate = state
end
