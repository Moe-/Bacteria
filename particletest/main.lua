--tests for diverse particlesystems

PI = math.pi

love.filesystem.load("lib.oop.lua")()
love.filesystem.load("obj.EffectSys.lua")()

function love.load ()
	ef = cEffectSys:New()
end

function love.draw ()
	ef:Draw()
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
end


function love.mousepressed(x, y, button)
	if button == "l" then
		ef:CreateEffect("powerup", x, y)
	end
end

function love.update(dt)
	ef:Update(dt)
end