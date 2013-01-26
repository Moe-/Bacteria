cTrail = CreateClass(cEffectBasic)

function cTrail:Init(sprite, x, y, direction, cr, cg, cb)
	self.ps = cPartSys:New()
	
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (75)
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (1)
	self.partSystem:setPosition              (0, 0)
	
	self.partSystem:setDirection             (direction * PI / 180)
	
	self.partSystem:setSpread                (45 / 2 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	
	self.partSystem:setTangentialAcceleration(0, 0)
	
	self.partSystem:setSizes                 (0.5, 0.1)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (cr, cg, cb, 240, cr, cg, cb, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, 0)
	
	self.ps:Start()
	
	self.posx = x
	self.posy = y
end