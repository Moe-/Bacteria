cBloodBorder = CreateClass(cEffectBasic)

function cBloodBorder:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()
	
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (75)
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (1)
	self.partSystem:setPosition              (0, 0)
	if direction == 270 then
		self.partSystem:setDirection             (240 * PI / 180)
	else
		self.partSystem:setDirection             (120 * PI / 180)
	end
	self.partSystem:setSpread                (30 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	if direction == 270 then
		self.partSystem:setTangentialAcceleration(-500, -1000)
	else
		self.partSystem:setTangentialAcceleration(500, 1000)
	end
	self.partSystem:setSizes                 (0.5, 0.1)
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