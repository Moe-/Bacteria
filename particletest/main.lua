--tests for diverse particlesystems

PI = math.pi

love.filesystem.load("lib.oop.lua")()
love.filesystem.load("obj.PartSys.lua")()
love.filesystem.load("obj.EffectBasic.lua")()
love.filesystem.load("obj.Explosion.lua")()
love.filesystem.load("obj.BloodBorder.lua")()

function love.load ()
	sprite = love.graphics.newImage("particle.png")
	effects = {}
	tr = 0
end

function love.draw ()
	for k,v in ipairs(effects) do
		v:Draw()
	end
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
end


function love.mousepressed(x, y, button)
	if button == "l" then
		e = cExplosion:New(x, y)
		table.insert(effects, e)
	end
end

function love.update(dt)
	tr = tr + dt
	if tr > 0.05 then
		table.insert(effects, cBloodBorder:New(love.mouse.getX(), love.mouse.getY(), true))
		tr = 0
	end
		
	for k,v in ipairs(effects) do
		v:Update(dt)
	end
	
	for k,v in ipairs(effects) do
		if v:isDone() then
			--print("effect",k,"isdone")
			v:Free()
			table.remove(effects, k)
		end
	end
end