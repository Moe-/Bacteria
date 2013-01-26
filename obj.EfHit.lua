cHit = CreateClass(cEffectBasic)

function cHit:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()
	
	self.partSystem = love.graphics.newParticleSystem(sprite, 800)
	self.partSystem:setEmissionRate          (400)
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (1)
	self.partSystem:setPosition              (0, 0)
	self.partSystem:setDirection             (direction * PI / 180)
	self.partSystem:setSpread                (45 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	self.partSystem:setTangentialAcceleration(-700, 700)
	self.partSystem:setSizes                 (0.8, 0.1)
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