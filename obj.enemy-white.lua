cEnemyWhite = CreateClass(cEnemyBase)

function cEnemyWhite:Init(x,y) 
	self.x = x
	self.y = y
	self.gfx = gfx_weissbk
	self:Register()
end

function cEnemyWhite:Draw() self:DrawWobble(0.2,0.1) end

function cEnemyWhite:Update (dt)
	local rnd = math.random()
	if(rnd * dt < 0.0005) then
		local x = self.x
		local y = self.y
		local dirX = gPlayer.x - x
		local dirY = gPlayer.y - y + math.random(-250, 250)
		local norm = math.sqrt(dirX*dirX + dirY*dirY)
		local lifetime = 5.0
		table.insert(gShots, cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "white"))
	end
end

