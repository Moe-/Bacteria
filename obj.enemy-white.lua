cEnemyWhite = CreateClass(cEnemyBase)

function cEnemyWhite:Init(x,y) 
	self.enemy_kind = "white"
	self.x = x
	self.y = y
	self.dx = math.random(-100, 100)
	self.dy = math.random(-100, 100)
	self.energy = 100
	self.gfx = gfx_weissbk
	self:Register()
end

function cEnemyWhite:Draw() self:DrawWobble(0.2,0.1,gEnemyGfxScale) end

function cEnemyWhite:Update (dt)
	local rnd = math.random()
	if(rnd * dt < 0.0005) then
		local x = self.x
		local y = self.y
		local dirX = gPlayer.x - x
		local dirY = gPlayer.y - y + math.random(-250, 250)
		local norm = math.sqrt(dirX*dirX + dirY*dirY)
		local lifetime = 5.0
		table.insert(gShots, cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "white", "white"))
	end

	self.dx = clamp(self.dx + math.random(-20, 20), -100, 100)
	self.dy = clamp(self.dy + math.random(-20, 20), -100, 100)
	self.x = self.x + dt * self.dx
	self.y = self.y + dt * self.dy
end

