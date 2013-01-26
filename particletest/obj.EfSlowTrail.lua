cSlowTrail = CreateClass(cEffectBasic)

function cSlowTrail:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()
	
	local amt = 10
	local delt = 768 / amt
	
	for i = delt, 768, delt do
		self:addTrail(sprite, x, i)
	end
	
	self.ps:Start()
	
	self.posx = x
	self.posy = y
end

function cSlowTrail:addTrail(sprite, px, py)
	self.partSystem = love.graphics.newParticleSystem(sprite, 100)
	self.partSystem:setEmissionRate          (5)
	self.partSystem:setLifetime              (-1)
	self.partSystem:setParticleLife          (5)
	self.partSystem:setPosition              (px, py)
	
	self.partSystem:setDirection             (180 * PI / 180)
	
	self.partSystem:setSpread                (45 / 2 * PI / 180)
	self.partSystem:setSpeed                 (300, 300)
	self.partSystem:setGravity               (0)
	self.partSystem:setRadialAcceleration    (0)
	
	self.partSystem:setTangentialAcceleration(0, 0)
	
	self.partSystem:setSizes                 (1, 1)
	self.partSystem:setRotation              (0)
	self.partSystem:setSpin                  (0)
	self.partSystem:setSpinVariation         (0)
	self.partSystem:setColors                (100, 0, 0, 100, 100, 0, 0, 10)
	self.partSystem:stop();
	self.ps:AddEmitter(self.partSystem, 0)
end