cExplosion = CreateClass(cEffectBasic)

function cExplosion:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()
	--slower particles
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (2000  )
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (0.5)
	self.partSystem:setPosition              (0, 0)
	self.partSystem:setDirection             (0)
	self.partSystem:setSpread                (180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (30)
	self.partSystem:setTangentialAcceleration(0)
	self.partSystem:setSizes                 (1, 0.5)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (255, 0, 0, 240, 255, 0, 0, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, 0)
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (2000  )
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (0.5)
	self.partSystem:setPosition              (0, 0)
	self.partSystem:setDirection             (0)
	self.partSystem:setSpread                (180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (30)
	self.partSystem:setTangentialAcceleration(0)
	self.partSystem:setSizes                 (1, 0.5)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (255, 0, 0, 240, 255, 0, 0, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, 0.1)
	--faster particles
	--self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	--self.partSystem:setEmissionRate          (1000  )
	--self.partSystem:setLifetime              (0.1)
	--self.partSystem:setParticleLife          (0.3)
	--self.partSystem:setPosition              (0, 0)
	--self.partSystem:setDirection             (0)
	--self.partSystem:setSpread                (180)
	--self.partSystem:setSpeed                 (400, 400)
	--self.partSystem:setGravity               (0)
	--self.partSystem:setRadialAcceleration    (30)
	--self.partSystem:setTangentialAcceleration(0)
	--self.partSystem:setSizes                 (1, 0.5)
	--self.partSystem:setRotation              (0)
	--self.partSystem:setSpin                  (0)
	--self.partSystem:setSpinVariation         (0)
	--self.partSystem:setColors                (255, 0, 0, 240, 255, 0, 0, 10)
	--self.partSystem:stop();
	--self.ps:AddEmitter(self.partSystem, 0)
	
	self.ps:Start()
	
	self.posx = x
	self.posy = y
end