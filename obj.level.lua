


cLevel = CreateClass()


function cLevel:Init() 
	self.walls = {}
	self.speed = 300
	self.scrollx = 0
	self.scrolly = 0
	self.spawned_i = 0
	self.stepx = 110
	
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	
	self.tunnel_h = cValueSpline:New(h*0.7,h*0.2,10,5)
	self.tunnel_y = cValueSpline:New(h*0.5,h*0.3,10,5)
	
	self:SpawnWalls()
end

function cLevel:MakeWall(x,y,bTop)
	local o = cWall:New(x,y,bTop)
	self.walls[o] = true
end

function cLevel:SpawnWalls()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	local stepx = self.stepx
	local endx = self.scrollx + w + stepx
	while (self.spawned_i * stepx < endx) do 
		local i = self.spawned_i
		local x = i * stepx
		local h = self.tunnel_h:Get(i)
		local y = self.tunnel_y:Get(i)
		self:MakeWall(x,y-0.5*h,true)
		self:MakeWall(x,y+0.5*h,false)
		self.spawned_i = self.spawned_i + 1
	end
end

function cLevel:Update(dt)
	self.scrollx = self.scrollx + dt * self.speed
	self:SpawnWalls()
	for o,_ in pairs(self.walls) do o:Update(dt,self) end
end

function cLevel:Draw()
	-- scroll 
	for o,_ in pairs(self.walls) do o:DrawPre(-self.scrollx,-self.scrolly) end
	for o,_ in pairs(self.walls) do o:Draw(-self.scrollx,-self.scrolly) end
end


-- ***** ***** ***** ***** ***** cValueSpline
cValueSpline = CreateClass()

function cValueSpline:Init (avg,var,tavg,tvar)
	self.avg = avg
	self.var = var
	self.tavg = tavg
	self.tvar = tvar
	
	self.v0 = self.avg + self.var*rand_in_range(-1,1)
	self.v1 = self.avg + self.var*rand_in_range(-1,1)
	self.t0 = 0
	self.dt = self.tavg + self.tvar*rand_in_range(-1,1)
	self.cur = avg
end

function cValueSpline:Get (t)
	while (t >= self.t0+self.dt) do
		self.t0 = self.t0 + self.dt
		self.dt = self.tavg + self.tvar*rand_in_range(-1,1)
		self.v0 = self.v1
		self.v1 = self.avg + self.var*rand_in_range(-1,1)
	end
	local f = (t - self.t0) / self.dt
	return self.v0 + (self.v1 - self.v0) * f
end

-- ***** ***** ***** ***** ***** cWall

cWall = CreateClass(cBase)

function cWall:Init (x,y,bTop)
	self.x = x
	self.y = y
	self.bTop = bTop
	self.gfx = gfx_levelpart01
end

function cWall:Update (dt)
end

function cWall:DrawPre (xa,ya)
	local gfx = gfx_border01
	if (not self.bTop) then 
		gfx:DrawY0(self.x+xa,self.y+ya)
	else
		gfx:DrawY0(self.x+xa,self.y+ya,PI)
	end
end

function cWall:Draw (xa,ya)
	self.gfx:Draw(self.x+xa,self.y+ya)
	
end

