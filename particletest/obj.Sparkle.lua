cSparkle = CreateClass(cEffectBasic)

function cSparkle:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()
	--self.partSystem = love.graphics.newParticleSystem(sprite, 200)
	--self.partSystem:setEmissionRate          (150)
	--self.partSystem:setLifetime              (0.2)
	--self.partSystem:setParticleLife          (0.1)
	--self.partSystem:setPosition              (0, 0)
	--self.partSystem:setDirection             (0 * PI / 180)
	--self.partSystem:setSpread                (360 * PI / 180)
	--self.partSystem:setSpeed                 (300, 300)
	--self.partSystem:setGravity               (0)
	--self.partSystem:setRadialAcceleration    (30)
	--self.partSystem:setTangentialAcceleration(0)
	--self.partSystem:setSizes                 (0.5, 0.1)
	--self.partSystem:setRotation              (0)
	--self.partSystem:setSpin                  (0)
	--self.partSystem:setSpinVariation         (0)
	--self.partSystem:setColors                (255, 255, 0, 240, 255, 255, 0, 10)
	--self.partSystem:stop();
	--self.ps:AddEmitter(self.partSystem, 0)
	
	self:addSparkle(sprite, x, y, 0)
	self:addSparkle(sprite, x, y, 0.2)
	self:addSparkle(sprite, x, y, 0.4)
	self:addSparkle(sprite, x, y, 0.3)
	
	self.ps:Start()
	
	self.posx = x
	self.posy = y
end

function cSparkle:addSparkle(sprite, x, y, delay)
	self.partSystem = love.graphics.newParticleSystem(sprite, 200)
	self.partSystem:setEmissionRate          (150)
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (0.1)
	self.partSystem:setPosition              (math.random(-50, 50), math.random(-50, 50))
	self.partSystem:setDirection             (0 * PI / 180)
	self.partSystem:setSpread                (360 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (30)
	self.partSystem:setTangentialAcceleration(0)
	self.partSystem:setSizes                 (0.2, 0.1)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (255, 255, 0, 240, 255, 255, 0, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, delay)
end