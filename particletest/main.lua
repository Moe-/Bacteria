--tests for diverse particlesystems

PI = math.pi

love.filesystem.load("lib.oop.lua")()
love.filesystem.load("obj.EffectSys.lua")()

function love.load ()
	ef = cEffectSys:New()
	
	gfx_player = love.graphics.newImage("player.png")
end

function love.draw ()
	ef:DrawBelow()
	--love.graphics.draw(gfx_player, love.mouse.getX() - 128,love.mouse.getY() - 128)
	ef:DrawAbove()
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
end


function love.mousepressed(x, y, button)
	if button == "l" then
		ef:CreateEffect("sparkle", x, y, 0, true)
	end
end

function love.update(dt)
	ef:Update(dt)
end