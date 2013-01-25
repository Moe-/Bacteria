cBase = CreateClass()

function cBase:Init() 
	print("base init")
	self.x = 0
	self.y = 0
end

function cBase:DrawWobble(ws,wr)
	local t = gMyTime
	local s = 1.0 + ws * sin(t*PI)
	local r = PI * wr * sin(t*0.9*PI)
	self.gfx:Draw(self.x,self.y,r,s,s)
end

function cBase:Update(dt) end

function cBase:DistToPos(x,y)
	local dx = x-self.x
	local dy = y-self.y
	return math.sqrt(dx*dx+dy*dy)
end

function cBase:DistToObj(o) return self:DistToPos(o.x,o.y) end
