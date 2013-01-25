--tests for diverse particlesystems

love.filesystem.load("lib.oop.lua")()

function love.load ()
	sprite = love.graphics.newImage("particle.png")
	partSystem = love.graphics.newParticleSystem(sprite, 100)
	partSystem:setEmissionRate          (1000  )
	partSystem:setLifetime              (0.1)
	partSystem:setParticleLife          (0.5)
	partSystem:setPosition              (0, 0)
	partSystem:setDirection             (0)
	partSystem:setSpread                (180)
	partSystem:setSpeed                 (200, 200)
	partSystem:setGravity               (0)
	partSystem:setRadialAcceleration    (30)
	partSystem:setTangentialAcceleration(0)
	partSystem:setSizes                 (1, 0.5)
	partSystem:setRotation              (0)
	partSystem:setSpin                  (0)
	partSystem:setSpinVariation         (0)
	partSystem:setColors                (200, 200, 255, 240, 255, 255, 255, 10)
	partSystem:stop();	
	px = 0
	py = 0
end

function love.draw ()
	love.graphics.draw(partSystem, px, py)
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
end


function love.mousepressed(x, y, button)
	if button == "l" then
		px = x
		py = y
		partSystem:reset()
		partSystem:start()
	end
end

function love.update(dt)
	partSystem:update(dt);
end