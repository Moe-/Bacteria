cEnemyBossBase = CreateClass(cEnemyBase)

function cEnemyBossBase:Init(x,y) 
	enemy_kind = "bossbase"
	self.x = x
	self.y = y
	self.x0 = x
	self.y0 = y
	self.energy = 100
	self:Register()
	self.bInvulnerable = true
	
	self.parts = {}
	self.cores = {}
	
	local e = 60 * gEnemyBossGfxScale
	local o = self:MakePart( 0*e,-4*e, gfx_boss_gun)
	local o = self:MakePart( 0*e,-3*e, gfx_boss_mid)
	local o = self:MakePart( 0*e,-2*e, gfx_boss_mid)
	local o = self:MakePart( 0*e,-1*e, gfx_boss_mid)
	local o = self:MakePart( 0*e, 0*e, gfx_boss_core) self.cores[o] = true
	local o = self:MakePart( 0*e, 1*e, gfx_boss_mid)
	local o = self:MakePart( 0*e, 2*e, gfx_boss_mid)
	local o = self:MakePart( 0*e, 3*e, gfx_boss_mid)
	local o = self:MakePart( 0*e, 4*e, gfx_boss_gun)
	
	
	local o = self:MakePart(-3*e, 0*e, gfx_boss_spike)
	local o = self:MakePart(-2*e, 0*e, gfx_boss_mid)
	local o = self:MakePart(-1*e, 0*e, gfx_boss_mid)
	local o = self:MakePart( 1*e, 0*e, gfx_boss_mid)
	local o = self:MakePart( 2*e, 0*e, gfx_boss_mid)
	local o = self:MakePart( 3*e, 0*e, gfx_boss_spike)
end

function cEnemyBossBase:MakePart(x,y,gfx)
	local o = cEnemyBossPartBase:New(x,y,gfx,self)
	self.parts[o] = true
	return o
end

function cEnemyBossBase:NotifyPartDie(o)
	local bCoresInvul = false
	self.parts[o] = nil
	for o,_ in pairs(self.parts) do 
		if (o.gfx == gfx_boss_gun or o.gfx == gfx_boss_spike) then bCoresInvul = true end
	end
	for o,_ in pairs(self.cores) do o.bInvulnerable = bCoresInvul end
end

function cEnemyBossBase:Update(dt)
	self.y = self.y0 + 50 * sin(0.35*gMyTime*PI)
end

function cEnemyBossBase:Draw()
	--~ for o,_ in pairs(self.parts) do o:Draw() end
end

-- ***** ***** ***** ***** ***** cEnemyBossPartBase
cEnemyBossPartBase = CreateClass(cEnemyBase)

function cEnemyBossPartBase:Init	(x,y,gfx,boss)
	self.x = boss.x+x
	self.y = boss.x+y
	self.x0 = x
	self.y0 = y
	self.gfx = gfx
	self.energy = 100
	self.boss = boss
	self:Register()
	if (self.gfx == gfx_boss_mid) then self.bInvulnerable = true end
end

function cEnemyBossPartBase:Update() 
	self.x = self.boss.x + self.x0
	self.y = self.boss.y + self.y0
end

function cEnemyBossPartBase:Die() 
	cEnemyBase.Die(self)
	self.boss:NotifyPartDie(self) 
end

function cEnemyBossPartBase:Draw() self:DrawWobble(0.1,0.1,gEnemyBossGfxScale) end

