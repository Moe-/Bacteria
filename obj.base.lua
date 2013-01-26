cBase = CreateClass()

function cBase:Init() 
	print("base init")
	self.x = 0
	self.y = 0
end

function cBase:DrawWobble(ws,wr,scalefactor) -- scale,rotate
	scalefactor = scalefactor or 1
	local wrand = self.wobble_random
	if (wrand == nil) then wrand = 0.9+0.2*randf() self.wobble_random = wrand end
	
	local t = gMyTime + 5
	local s = scalefactor * (1.0 + ws * sin(t*wrand*PI))
	local r = PI * wr * sin(t*wrand*0.9*PI)
	local gfx = self.gfx
	if (gfx.bIsAnim) then
		gfx = gfx[1+math.mod(floor(gMyTime / self.time_per_frame),#gfx)]
	end
	gfx:Draw(self.x,self.y,r,s,s)
	
	local d = self.radius or 25
	love.graphics.circle("line",self.x,self.y,d,11)
	
end

function cBase:Update(dt) end

function cBase:DistToPos(x,y)
	local dx = x-self.x
	local dy = y-self.y
	return math.sqrt(dx*dx+dy*dy)
end

function cBase:DistToObj(o) return self:DistToPos(o.x,o.y) end



function cBase:Damage(dmg)
	if self.kind == "player" then
		cStretch:New(slime, math.random(0, 1024), math.random(0, 768), math.random(0, 2 * PI), math.random(0.01, 0.4), math.random(1.4, 2.0))
		cStretch:New(slime, math.random(0, 1024), math.random(0, 768), math.random(0, 2 * PI), math.random(0.01, 0.4), math.random(1.4, 2.0))
		cStretch:New(slime, math.random(0, 1024), math.random(0, 768), math.random(0, 2 * PI), math.random(0.01, 0.4), math.random(1.4, 2.0))
	end
	
	if (self.bInvulnerable) then return end
	self.energy = self.energy - dmg
	
	if (self.energy <= 0) then self:Die() else self:NotifyDamage() end
end

function cBase:NotifyDamage()
	-- todo: overload me
end

function cBase:Die()
	-- todo: overload me
end

function cBase:ShotTest(shot, stype)
	local damage = 20
	if (self.enemy_kind ~= nil and self.enemy_kind == "white") then 
		damage = 5 + 15 * gPlayer:GetWeaponPower()
	end
	local d = self.radius or 25
	if shot.sType == stype and shot:DistToObj(self) < d then self:Damage(damage) end
end

