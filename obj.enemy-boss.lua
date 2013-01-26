cEnemyBossBase = CreateClass(cEnemyBase)

function cEnemyBossBase:Init(x,y) 
	self.enemy_kind = "bossbase"
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
	
	self:UpdatePartsStatus()
end

function cEnemyBossBase:MakePart(x,y,gfx)
	local o = cEnemyBossPartBase:New(x,y,gfx,self)
	self.parts[o] = true
	return o
end

function cEnemyBossBase:NotifyPartDie(o)
	self.parts[o] = nil
	self.cores[o] = nil
	self:UpdatePartsStatus()
end

function cEnemyBossBase:UpdatePartsStatus()
	local bCoresInvul = false
	for o,_ in pairs(self.parts) do 
		if (o.gfx == gfx_boss_gun or o.gfx == gfx_boss_spike) then bCoresInvul = true end
	end
	
	-- set cores invul if guns/spikes alive
	local bCoresAlive = false
	--~ print("boss:bCoresInvul",bCoresInvul)
	for o,_ in pairs(self.cores) do bCoresAlive = true o.bInvulnerable = bCoresInvul end
	
	-- death if no cores left
	if (not bCoresAlive) then 
		for o,_ in pairs(self.parts) do 
			o:Die()
		end
		self:Die()
	end
end

function cEnemyBossBase:Update(dt)
	self.y = self.y0 + 50 * sin(0.35*gMyTime*PI)
	
	for o,_ in pairs(self.parts) do
		if (o.gfx == gfx_boss_gun) then
			local rnd = math.random()
			if(rnd * dt < 0.0025) then
				local x = o.x
				local y = o.y
				local dirX = gPlayer.x - x
				local dirY = gPlayer.y - y + math.random(-250, 250)
				local norm = math.sqrt(dirX*dirX + dirY*dirY)
				local lifetime = 5.0
				table.insert(gShots, cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "white", "blue"))
			end
		end
	end
	
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
	local x = self.x0
	local y = self.y0
	
	local ang_per_pixel = PI / 100
	local ang_phase = gMyTime / 1.5 * PI
	local bHorz = abs(x) > abs(y)
	local d = max(abs(x),abs(y))
	local waber_d = 20*min(1.0,d / 100)
	iOff = waber_d * sin(d * ang_per_pixel + ang_phase)
	
	self.x = self.boss.x + x + (bHorz and 0 or iOff)
	self.y = self.boss.y + y + (bHorz and iOff or 0)
end

function cEnemyBossPartBase:Die() 
	cEnemyBase.Die(self)
	self.boss:NotifyPartDie(self) 
end

function cEnemyBossPartBase:Draw() self:DrawWobble(0.1,0.1,gEnemyBossGfxScale) end

-- ***** ***** ***** ***** ***** *****

cEnemyEgg = CreateClass(cEnemyBase)

function cEnemyEgg:Init(x,y) 
	self.enemy_kind = "egg"
	self.x = x
	self.y = y
	self.energy = 100
	self.gfx = gfx_egg
	self:Register()
end

function cEnemyEgg:Draw() self:DrawWobble(0.1,0.1,gEnemyGfxScale) end

