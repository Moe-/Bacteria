cPowerUp = CreateClass(cEffectBasic)

function cPowerUp:Init(sprite, x, y)
	self.ps = cPartSys:New()
	
	for angle = 0, 360, 20 do
		self.partSystem = love.graphics.newParticleSystem(sprite, 500)
		self.partSystem:setEmissionRate          (200)
		self.partSystem:setLifetime              (0.1)
		self.partSystem:setParticleLife          (1)
		self.partSystem:setPosition              (0 + math.cos(angle * PI / 180) * 100, 0 + math.sin(angle * PI / 180) * 100)
		self.partSystem:setDirection             (angle * PI / 180)
		self.partSystem:setSpread                (10 * PI / 180)
		self.partSystem:setSpeed                 (100, 100)
		self.partSystem:setGravity               (0)
		self.partSystem:setRadialAcceleration    (-5, -5)
		self.partSystem:setTangentialAcceleration(500, 500)
		self.partSystem:setSizes                 (0.5, 0.1)
		self.partSystem:setRotation              (0)
		self.partSystem:setSpin                  (0)
		self.partSystem:setSpinVariation         (0)
		self.partSystem:setColors                (255, 0, 0, 240, 0, 0, 255, 10)
		self.partSystem:stop();
		self.ps:AddEmitter(self.partSystem, 0)
		
		self.partSystem = love.graphics.newParticleSystem(sprite, 500)
		self.partSystem:setEmissionRate          (200)
		self.partSystem:setLifetime              (0.1)
		self.partSystem:setParticleLife          (1)
		self.partSystem:setPosition              (0 + math.cos(angle * PI / 180) * 100, 0 + math.sin(angle * PI / 180) * 100)
		self.partSystem:setDirection             (angle * PI / 180)
		self.partSystem:setSpread                (10 * PI / 180)
		self.partSystem:setSpeed                 (100, 100)
		self.partSystem:setGravity               (0)
		self.partSystem:setRadialAcceleration    (-5, -5)
		self.partSystem:setTangentialAcceleration(-500, -500)
		self.partSystem:setSizes                 (0.5, 0.1)
		self.partSystem:setRotation              (0)
		self.partSystem:setSpin                  (0)
		self.partSystem:setSpinVariation         (0)
		self.partSystem:setColors                (255, 0, 0, 240, 0, 0, 255, 10)
		self.partSystem:stop();
		self.ps:AddEmitter(self.partSystem, 0)
	end
	
	self.ps:Start()
	
	self.posx = x
	self.posy = y
end