


cLevel = CreateClass()

function cLevel:Init() 
	self.walls = {}
	self.speed = 300
	self.scrollx = 0
	self.scrolly = 0
	self.spawned_i = 0
	self:SpawnWalls()
end

function cLevel:MakeWall(x,y)
	local o = cWall:New(x,y)
	self.walls[o] = true
end

function cLevel:SpawnWalls()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	local stepx = 115
	local endx = self.scrollx + w + stepx
	while (self.spawned_i * stepx < endx) do 
		local x = self.spawned_i * stepx
		self:MakeWall(x,10)
		self:MakeWall(x,h-10)
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
	for o,_ in pairs(self.walls) do o:Draw(-self.scrollx,-self.scrolly) end
end

-- ***** ***** ***** ***** ***** cWall

cWall = CreateClass(cBase)

function cWall:Init (x,y)
	self.x = x
	self.y = y
	self.gfx = gfx_levelpart01
end

function cWall:Update (dt)
	--~ self.x = 
	
end

function cWall:Draw (xa,ya)
	self.gfx:Draw(self.x+xa,self.y+ya)
end

