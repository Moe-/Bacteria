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
	self.gfx:Draw(self.x,self.y,r,s,s)
end

function cBase:Update(dt) end

function cBase:DistToPos(x,y)
	local dx = x-self.x
	local dy = y-self.y
	return math.sqrt(dx*dx+dy*dy)
end

function cBase:DistToObj(o) return self:DistToPos(o.x,o.y) end

function cBase:ShotTest(shot, stype)
	if shot.sType == stype and shot:DistToPos(self.x, self.y) < 25 then
		self.energy = self.energy - 20
		if (self.energy <= 0) then return false end
	end
	return true
end

