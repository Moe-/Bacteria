cBloodTitle = CreateClass(cEffectBasic)

function cBloodTitle:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()
	
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (75)
	self.partSystem:setLifetime              (-1)
	self.partSystem:setParticleLife          (1)
	self.partSystem:setPosition              (390, 200)
	self.partSystem:setDirection (260 * PI / 180)
	self.partSystem:setSpread                (30 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	self.partSystem:setTangentialAcceleration(-500, -1000)
	self.partSystem:setSizes                 (1, 0.5)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (255, 0, 0, 240, 255, 0, 0, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, 0)
	
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (75)
	self.partSystem:setLifetime              (-1)
	self.partSystem:setParticleLife          (1)
	self.partSystem:setPosition              (650, 250)
	self.partSystem:setDirection (315 * PI / 180)
	self.partSystem:setSpread                (30 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	self.partSystem:setTangentialAcceleration(500, 1000)
	self.partSystem:setSizes                 (1, 0.5)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (255, 0, 0, 240, 255, 0, 0, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, 0)
	
	self.ps:Start()
	
	self.posx = x
	self.posy = y
end