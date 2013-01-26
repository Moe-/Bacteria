


cLevel = CreateClass()

kLevelBorderBackOffset = 20
kLevelStepX = 110
kLevelCollOff = 0

function cLevel:Init() 
	self.walls = {}
	self.speed = 300
	self.scrollx = 0
	self.scrolly = 0
	self.spawned_i = 0
	self.stepx = kLevelStepX
	
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	
	self.tunnel_h = cValueSpline:New(h*0.7,h*0.2,10,5)
	self.tunnel_y = cValueSpline:New(h*0.5,h*0.3,10,5)
	
	self:SpawnWalls()
	
end

function DrawPattern (gfx,e,xoff)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	for x = -xoff,w+e,e do
	for y = 0,h+e,e do
		gfx:Draw(x,y)
	end
	end
end

function cLevel:DrawBack()
	local e = 256
	DrawPattern(gfx_background1,e,math.mod(self.scrollx*0.8,e))
	DrawPattern(gfx_background2,e,math.mod(self.scrollx*0.7,e))
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
	--~ print("num walls",table_count(self.walls))
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
	self.gfx = rand_in_arr(gfx_border)
	self.dy_per_x = sin(ang) / cos(ang)
end

function cWall:Destroy () gLevel.walls[self] = nil end

function cWall:Collide (x,y,o,r)
	if (o.bIgnoreWalls) then return end
	local halfw = 0.5*kLevelStepX
	local relx = o.x - x
	if (relx >= -halfw and relx <= halfw) then 
		local y2 = y + relx * self.dy_per_x
		local oldy = o.y
		if (self.bTop) then
			o.y = max(o.y,y2+kLevelCollOff+r)
			if (oldy ~= o.y) then o.bCollidingWithTop = true end
		else 
			o.y = min(o.y,y2-kLevelCollOff-r)
			if (oldy ~= o.y) then o.bCollidingWithBottom = true end
		end
	end
end

function cWall:Update (dt)
	local x = self.x-gLevel.scrollx
	local y = self.y-gLevel.scrolly
	--~ print("wall",x,y)
	for o,_ in pairs(gEnemies) do self:Collide(x,y,o,o.radius or 0) end
	local o = gPlayer self:Collide(x,y,o,o.radius or 0)
end



function cWall:DrawPre (xa,ya)
	local gfx = gfx_border01
	if (self.bTop) then 
		gfx:DrawY0(self.x+xa,self.y+ya-kLevelBorderBackOffset,PI)
	else
		gfx:DrawY0(self.x+xa,self.y+ya+kLevelBorderBackOffset)
	end
end

function cWall:Draw (xa,ya)
	local x,y = self.x+xa,self.y+ya
	if (x < -100) then self:Destroy() end
	self.gfx:Draw(x,y,self.ang)
	--~ love.graphics.circle( "line", x, y, 5, 11 )
	--~ local h = 0.5*kLevelStepX
	--~ local y2 = y + self.dy_per_x * h
	--~ love.graphics.circle( "line", x+h, y2, 3, 11 )
	
end

