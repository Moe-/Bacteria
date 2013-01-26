cBloodBorder = CreateClass(cEffectBasic)

function cBloodBorder:Init(x, y, up)
	self.ps = cPartSys:New()
	
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (50)
	self.partSystem:setLifetime              (0.1)
	self.partSystem:setParticleLife          (1)
	self.partSystem:setPosition              (0, 0)
	if up then
		self.partSystem:setDirection             (270 * PI / 180)
	else
		self.partSystem:setDirection             (90 * PI / 180)
	end
	self.partSystem:setSpread                (30 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	if up then
		self.partSystem:setTangentialAcceleration(-300, -500)
	else
		self.partSystem:setTangentialAcceleration(300, 500)
	end
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