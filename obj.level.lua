


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


function cLevel:DrawBack()
	local gfx = gfx_background1
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	local e = 256
	local xoff = math.mod(self.scrollx*0.8,e)
	for x = -xoff,w+e,e do
	for y = 0,h+e,e do
		gfx:Draw(x,y)
	end
	end
end

function cLevel:MakeWall(x,y,ang,bTop)
	local o = cWall:New(x,y,ang,bTop)
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
		local y_top = y-0.5*h
		local y_bot = y+0.5*h
		self:MakeWall(x,y_top,(self.last_y_top and (atan2(y_top-self.last_y_top,stepx)) or 0)   ,true)
		self:MakeWall(x,y_bot,(self.last_y_bot and (atan2(y_bot-self.last_y_bot,stepx)) or 0)+PI,false)
		self.last_y_top = y_top
		self.last_y_bot = y_bot
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

function cWall:Init (x,y,ang,bTop)
	self.x = x
	self.y = y
	self.ang = ang
	self.bTop = bTop
	self.gfx = gfx_levelpart01
end

function cWall:Destroy () gLevel.walls[self] = nil end

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
	local x,y = self.x+xa,self.y+ya
	if (x < -100) then self:Destroy() end
	self.gfx:Draw(x,y,self.ang)
end

