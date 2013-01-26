cEnemyBlutPlatt = CreateClass(cEnemyBase)

function cEnemyBlutPlatt:Init(x,y) 
	self.enemy_kind = "blutplatt"
	self.x = x
	self.y = y
	self.energy = 120
	self.gfx = gfx_blutplatt
	self:Register()
	
	self.xdir = math.random(50, 150)
	self.ydir = math.random(-50, 50)
	self.bCanLeaveScreen = true
	self.bDieLeftOfScreen = true
end

function cEnemyBlutPlatt:Draw() self:DrawWobble(0.2,0.1,gEnemyGfxScale) end

function cEnemyBlutPlatt:Update(dt)
	self.x = self.x - self.xdir * dt
	self.y = self.y - self.ydir * dt
	
	if self.x < 0 then
		self.x = 0
		self.xdir = -self.xdir
	elseif self.x > 1024 then
		self.x = 1024
		self.xdir = -self.xdir
	end
	
	if self.y < 0 then
		self.y = 0
		self.ydir = -self.ydir
	elseif self.y > 768 then
		self.y = 768
		self.ydir = -self.ydir
	end
	
	local dist = 50 * 50
	
	for o,_ in pairs(gEnemies) do 
		if ((self.x - o.x) * (self.x - o.x) + (self.y - o.y) * (self.y - o.y)) < dist then
			o.xdir = self.xdir
			o.ydir = self.ydir
		end
	end
end
