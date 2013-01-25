function love.load()
  --sorry, too lazy to pick an image, just skip point 1a and 1b when you use an image file
  --1a. create a blank 32px*32px image data
  id = love.image.newImageData(32, 32)
  --1b. fill that blank image data
  for x = 0, 31 do
    for y = 0, 31 do
      local gradient = 1 - ((x-15)^2+(y-15)^2)/40
      id:setPixel(x, y, 255, 255, 255, 255*(gradient<0 and 0 or gradient))
    end
  end
  
  --2. create an image from that image data
  i = love.graphics.newImage(id)
  
  --3a. create a new particle system which uses that image, set the maximum amount of particles (images) that could exist at the same time to 256
  p = love.graphics.newParticleSystem(i, 256)
  --3b. set various elements of that particle system, please refer the wiki for complete listing
  p:setEmissionRate          (20  )
  p:setLifetime              (1)
  p:setParticleLife          (4)
  p:setPosition              (50, 50)
  p:setDirection             (0)
  p:setSpread                (2)
  p:setSpeed                 (10, 30)
  p:setGravity               (30)
  p:setRadialAcceleration    (10)
  p:setTangentialAcceleration(0)
  p:setSize                  (1)
  p:setSizeVariation         (0.5)
  p:setRotation              (0)
  p:setSpin                  (0)
  p:setSpinVariation         (0)
  p:setColor                 (200, 200, 255, 240, 255, 255, 255, 10)
  p:stop();--this stop is to prevent any glitch that could happen after the particle system is created
end

function love.update(dt)
  --4a. on each frame, the particle system should be started/burst. try to move this line to love.load instead and see what happens
  p:start();
  --4b. on each frame, the particle system needs to update its particles's positions after dt miliseconds
  p:update(dt);
end

function love.draw()
  --5. draw the particle system, with its origin (0, 0) located at love's 20, 20. Compare this origin position with the particle system's emitter position being set by "p:setPosition(50, 50)" in love.load
  love.graphics.draw(p, 20, 20)
  love.graphics.print("origin (20, 20)", 20, 20)
  love.graphics.print("emitter (20+50, 20+50)", 70, 70)
  
  local mx, my = love.mouse.getPosition()
  love.graphics.setCaption("mouse: (" .. mx .. ", " .. my .. ")")
end

function love.keypressed(k)
  if k == "q" or k == "escape" then--quit
    love.event.push("q")
  elseif k == "f5" then--restart
    love.filesystem.load("main.lua")()
    love.load()
  end
end
