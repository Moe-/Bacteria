--tests for diverse particlesystems

PI = math.pi

love.filesystem.load("lib.oop.lua")()
love.filesystem.load("obj.EffectSys.lua")()

function love.load ()
	ef = cEffectSys:New()
	
	gfx_player = love.graphics.newImage("player.png")
	white = love.graphics.newImage("weissbk.png")
	
	t = 0
end

function love.draw ()
	ef:DrawBelow()
	--love.graphics.draw(gfx_player, love.mouse.getX() - 128,love.mouse.getY() - 128)
	ef:DrawAbove()
	
	love.graphics.setColor(150 + 105 * math.sin(t * 2), 0, 0, 50)
	love.graphics.draw(white, love.mouse.getX() - 128 * 1.1, love.mouse.getY() - 128 * 1.1, 0, 1.2, 1.2)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(white, love.mouse.getX() - 128, love.mouse.getY() - 128)
	
	
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
end


function love.mousepressed(x, y, button)
	if button == "l" then
		ef:CreateEffect("slowtrail", 100, 0, 0, true)
	end
end

function love.update(dt)
	ef:Update(dt)
	t = t + dt
end