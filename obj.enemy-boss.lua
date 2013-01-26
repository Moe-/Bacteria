cEnemyBossBase = CreateClass(cEnemyBase)

function cEnemyBossBase:Init(x,y) 
	enemy_kind = "bossbase"
	self.x = x
	self.y = y
	self.energy = 100
	self:Register()
	
	self.parts = {}
	
	local e = 60 * gEnemyBossGfxScale
	self:MakePart( 0*e,-4*e, gfx_boss_gun)
	self:MakePart( 0*e,-3*e, gfx_boss_mid)
	self:MakePart( 0*e,-2*e, gfx_boss_mid)
	self:MakePart( 0*e,-1*e, gfx_boss_mid)
	self:MakePart( 0*e, 0*e, gfx_boss_core)
	self:MakePart( 0*e, 1*e, gfx_boss_mid)
	self:MakePart( 0*e, 2*e, gfx_boss_mid)
	self:MakePart( 0*e, 3*e, gfx_boss_mid)
	self:MakePart( 0*e, 4*e, gfx_boss_gun)
	
	
	self:MakePart(-3*e, 0*e, gfx_boss_spike)
	self:MakePart(-2*e, 0*e, gfx_boss_mid)
	self:MakePart(-1*e, 0*e, gfx_boss_mid)
	self:MakePart( 1*e, 0*e, gfx_boss_mid)
	self:MakePart( 2*e, 0*e, gfx_boss_mid)
	self:MakePart( 3*e, 0*e, gfx_boss_spike)
end

function cEnemyBossBase:MakePart(x,y,gfx)
	local o = cEnemyBossPartBase:New(x,y,gfx,self)
	self.parts[o] = true
end

function cEnemyBossBase:Update(dt)
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
end

function cEnemyBossPartBase:Update() 
	self.x = self.boss.x + self.x0
	self.y = self.boss.y + self.y0
end

function cEnemyBossPartBase:Draw() self:DrawWobble(0.1,0.1,gEnemyBossGfxScale) end

