--tests for diverse particlesystems

PI = math.pi

love.filesystem.load("lib.oop.lua")()
love.filesystem.load("obj.EffectSys.lua")()

function love.load ()
	ef = cEffectSys:New()
	tr = 0
end

function love.draw ()
	ef:Draw()
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
end


function love.mousepressed(x, y, button)
	if button == "l" then
	end
end

function love.update(dt)
	tr = tr + dt
	if tr > 0.05 then
		tr = 0
		ef:CreateEffect("bloodup", love.mouse.getX(), love.mouse.getY())
	end
	ef:Update(dt)
end