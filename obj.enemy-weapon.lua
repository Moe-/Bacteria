cEnemyWeapon = CreateClass(cEnemyBase)

function cEnemyWeapon:Init(x,y,wType) 
	self.enemy_kind = "weapon"
	self.x = x
	self.y = y
	self.dx = 300
	self.dy = 0
	self.wType = wType
	self.energy = 100
	self.gfx = gfx_dnabonus
	self:Register()
end

function cEnemyWeapon:Draw() self:DrawWobble(0.2,0.1,gEnemyGfxScale) end

function cEnemyWeapon:Update(dt)
	self.dx = clamp(self.dx + math.random(-20, 20), 300, 600)
	self.x = self.x - self.dx * dt
	if self.x < 0 then
		self:Destroy()
	end

	local dy = self.y - gPlayer.y
	if (math.abs(dy) < 250) then
		self.dy = clamp(self.dy + sign(dy) * math.random(15, 30), -50, 50)
		if self.bCollidingWithTop == true then
			self.dy = -self.dy
			self.bCollidingWithTop = false
		elseif self.bCollidingWithBottom == true then
			self.dy = -self.dy
			self.bCollidingWithBottom = false
		end
		self.y = self.y + self.dy * dt
	end

	if(self:DistToObj(gPlayer) < 25) then
		self:Destroy()
		gPlayer:UpdateWeapon(self.wType)
	end
end

function cEnemyWeapon:ShotTest(shot, stype)
	--if shot.sType == stype and shot:DistToObj(self) < 25 then self:Damage(20) end
end
