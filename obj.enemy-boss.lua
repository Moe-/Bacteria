cEnemyBossBase = CreateClass(cEnemyBase)

function cEnemyBossBase:Init(x,y) 
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
	local o = cEnemyBossPartBase:New(self.x+x,self.y+y,gfx)
	self.parts[o] = true
end

function cEnemyBossBase:Draw()
	for o,_ in pairs(self.parts) do o:Draw() end
end

-- ***** ***** ***** ***** ***** cEnemyBossPartBase
cEnemyBossPartBase = CreateClass(cBase)

function cEnemyBossPartBase:Init	(x,y,gfx)
	self.x = x
	self.y = y
	self.gfx = gfx
end

function cEnemyBossPartBase:Draw() self:DrawWobble(0.1,0.1,gEnemyBossGfxScale) end

