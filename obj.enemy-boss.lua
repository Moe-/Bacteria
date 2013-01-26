cEnemyBossBase = CreateClass(cEnemyBase)

kBossUnit = 60*gEnemyBossGfxScale
kEnemyBossMidBlockShotRadius = 0.8*kBossUnit
kTentacleRespawnInterval = 3.0

-- ***** ***** ***** ***** ***** boss variants

cEnemyBoss01 = CreateClass(cEnemyBossBase)

cEnemyBoss02 = CreateClass(cEnemyBossBase)

function cEnemyBoss02:Init(x,y) 
	self:BossInitBase(x,y)
	
	local e = kBossUnit
	
	local ry = 2
	for i=-ry,ry do 
		if (abs(i) == ry) then
			local o = self:MakePart( 0*e, i*e, gfx_boss_core) self.cores[o] = true
			local core = o
			if (i < 0) then 
				local o = self:MakeTentacle( 0,-2, 4,-1, -0.5, core, gfx_boss_spike)
				local o = self:MakeTentacle( 0,-2, 4, 1, -0.5, core, gfx_boss_gun)
			else 
				local o = self:MakeTentacle( 0, 2, 4,-1,  0.5, core, gfx_boss_spike)
				local o = self:MakeTentacle( 0, 2, 4, 1,  0.5, core, gfx_boss_gun)
			end
		else
			local o = self:MakePart( 0, i*e, gfx_boss_mid)
		end
	end
	
	
	self:UpdatePartsStatus()
end

cEnemyBossFinal = CreateClass(cEnemyBossBase)

function cEnemyBossFinal:Init(x,y) 
	self:BossInitBase(x,y)
	
	local e = kBossUnit
	local rx,ry = 2,2
	for ix=-rx,rx do
	for iy=-ry,ry do
		if (abs(ix) == rx and abs(iy) == ry) then
			local o = self:MakePart( ix*e, iy*e, gfx_boss_core) self.cores[o] = true
			local core = o 
			local o = self:MakeTentacle(ix,iy,   4,sgn(ix), sgn(iy)*0.5, core, gfx_boss_gun)
		else
			local o = self:MakePart( ix*e, iy*e, gfx_boss_mid)
		end
		--~ if (ix ~= 0 or iy ~= 0) then local o = self:MakePart( ix*e, iy*e, gfx_boss_mid)  end
	end
	end
	
	
	self:UpdatePartsStatus()
end

-- ***** ***** ***** ***** ***** boss variants

function cEnemyBossBase:Init(x,y) 
	self:BossInitBase(x,y)
	
	local e = kBossUnit
	local o = self:MakePart( 0*e, 0*e, gfx_boss_core) self.cores[o] = true
	
	local core = o
	local o = self:MakeTentacle( 0,0, 4,-1, 0, core, gfx_boss_spike)
	local o = self:MakeTentacle( 0,0, 4, 1, 0, core, gfx_boss_spike)
	local o = self:MakeTentacle( 0,0, 4, 0,-1, core, gfx_boss_gun)
	local o = self:MakeTentacle( 0,0, 4, 0, 1, core, gfx_boss_gun)
	
	self:UpdatePartsStatus()
end

function cEnemyBossBase:BossInitBase(x,y) 
	self.enemy_kind = "bossbase"
	self.x = x
	self.y = y
	self.x0 = x
	self.y0 = y
	self.energy = 100
	self:Register()
	self.bInvulnerable = true
	self.bIgnoreWalls = true
	
	self.parts = {}
	self.cores = {}
	self.tentacles = {}
end

function cEnemyBossBase:MakeTentacle(x,y,num,vx,vy,core,gfx_head)
	return cTentacle:New(x,y,num,vx,vy,gfx_head,core,self)
end

function cEnemyBossBase:MakePart(x,y,gfx,tentacle)
	local o = cEnemyBossPartBase:New(x,y,gfx,self,tentacle)
	self.parts[o] = true
	return o
end

function cEnemyBossBase:NotifyPartDie(o)
	self.parts[o] = nil
	self.cores[o] = nil
	self:UpdatePartsStatus()
end

function cEnemyBossBase:UpdatePartsStatus()	
	-- set cores invul if guns/spikes alive
	local bCoresAlive = false
	for o,_ in pairs(self.cores) do bCoresAlive = true o:CoreCheckInvul() end
	
	-- death if no cores left
	if (not bCoresAlive) then 
		for o,_ in pairs(self.parts) do o:Die() end
		self:Die()
	end
end

function cEnemyBossBase:Update(dt)
	self.y = self.y0 + 50 * sin(0.35*gMyTime*PI)
end

function cEnemyBossBase:Draw()
end


-- ***** ***** ***** ***** ***** cTentacle

cTentacle = CreateClass()

function cTentacle:Init (x,y,num,vx,vy,gfx_head,core,boss)
	self.parts = {}
	self.x = x
	self.y = y
	self.num = num
	self.vx = vx
	self.vy = vy
	self.gfx_head = gfx_head
	self.core = core
	self.boss = boss
	core.tentacles[self] = true
	self:Respawn()
end


function cTentacle:TryRespawn ()
	if (self.bIsAlive) then return end
	self:Respawn()
	return true
end

function cTentacle:Respawn ()
	self.bIsAlive = true
	local e = kBossUnit
	local boss = self.boss
	local x = self.x
	local y = self.y
	local vx = self.vx
	local vy = self.vy
	local num = self.num
	local gfx_head = self.gfx_head
	
	for i = 0,num do 
		local gfx = (i == num) and gfx_head or gfx_boss_mid
		local o = boss:MakePart( (x+i*vx)*e, (y+i*vy)*e, gfx, self)
	end
end
	
function cTentacle:NotifyPartDie (o)
	--~ print("tentacle part die",o)
	self.parts[o] = nil
	if (o.gfx ~= gfx_boss_mid) then 
		self.bIsAlive = false
		self:KillAll() 
		self.core:UpdateCoreTentacleRespawnTimer()
	end
end

function cTentacle:KillAll ()
	for o,_ in pairs(self.parts) do o:Die() end
end

function cTentacle:Add (o)
	self.parts[o] = true
end

function cTentacle:CoreCheckInvul ()
	for o,_ in pairs(self.parts) do
		if (o.gfx == gfx_boss_gun or o.gfx == gfx_boss_spike) then return true end
	end
end

-- ***** ***** ***** ***** ***** cEnemyBossPartBase
cEnemyBossPartBase = CreateClass(cEnemyBase)

function cEnemyBossPartBase:Init	(x,y,gfx,boss,tentacle)
	self.x = boss.x+x
	self.y = boss.y+y
	self.x0 = x
	self.y0 = y
	self.gfx = gfx
	self.energy = 100
	self.boss = boss
	self.tentacles = {}
	self.tentacle = tentacle
	if (tentacle) then tentacle:Add(self) end
	self:Register()
	if (self.gfx == gfx_boss_mid) then self.bInvulnerable = true end
	self.respawn_t = 0
end


function cEnemyBossPartBase:UpdateCoreTentacleRespawnTimer()
	self.respawn_t = gMyTime + kTentacleRespawnInterval
end

function cEnemyBossPartBase:Update(dt)
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
	
	if (self.gfx == gfx_boss_mid) then 
		Shots_BlockPlayerShotsAtPos(self.x,self.y,kEnemyBossMidBlockShotRadius)
	end
	
	-- respawn tentacles if core
	if (self.gfx == gfx_boss_core and gMyTime > self.respawn_t) then
		for o,_ in pairs(self.tentacles) do 
			if (o:TryRespawn()) then 
				self:UpdateCoreTentacleRespawnTimer() 
				self:CoreCheckInvul() 
				break 
			end
		end
	end
	
	-- shot if gun 
	if (self.gfx == gfx_boss_gun) then
		local rnd = math.random()
		if(rnd * dt < 0.0025) then
			local x = self.x
			local y = self.y
			local dirX = gPlayer.x - x
			local dirY = gPlayer.y - y + math.random(-250, 250)
			local norm = math.sqrt(dirX*dirX + dirY*dirY)
			local lifetime = 5.0
			cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "white", "blue")
		end
	end
end

function cEnemyBossPartBase:CoreCheckInvul()
	self.bInvulnerable = false
	for o,_ in pairs(self.tentacles) do 
		if (o:CoreCheckInvul()) then self.bInvulnerable = true end
	end
end

function cEnemyBossPartBase:Die()
	cEnemyBase.Die(self)
	self.boss:NotifyPartDie(self)
	if (self.tentacle) then self.tentacle:NotifyPartDie(self) end
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

