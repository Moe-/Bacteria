cEnemyWeapon = CreateClass(cEnemyBase)

function cEnemyWeapon:Init(x,y,wType) 
	self.enemy_kind = "weapon"
	self.x = x
	self.y = y
	self.wType = wType
	self.energy = 100
	self.gfx = gfx_dnabonus
	self:Register()
end

function cEnemyWeapon:Draw() self:DrawWobble(0.2,0.1,gEnemyGfxScale) end

function cEnemyWeapon:Update(dt)	
	self.x = self.x - 300 * dt
	if self.x < 0 then
		self:Destroy()
	end
	if(self:DistToObj(gPlayer) < 25) then
		self:Destroy()
		gPlayer:UpdateWeapon(self.wType)
		effects:CreateEffect("powerup", gPlayer.x, gPlayer.y, 0, true)
	end
end

function cEnemyWeapon:ShotTest(shot, stype)
	--if shot.sType == stype and shot:DistToObj(self) < 25 then self:Damage(20) end
end
