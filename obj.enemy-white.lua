cEnemyWhite = CreateClass(cEnemyBase)

kShotInterval_Enemy = 1.5

function cEnemyWhite:Init(x,y,colour) 
	self.enemy_kind = "white"
	self.enemy_resist_colour = colour
	self.x = x
	self.y = y
	self.dx = math.random(-100, 100)
	self.dy = math.random(-100, 100)
	self.energy = 100
	self.colour = colour

	if (self.colour == "blue") then self.gfx = gfx_weissbk_blau
	elseif (self.colour == "green") then self.gfx = gfx_weissbk_gruen
	elseif (self.colour == "red") then self.gfx = gfx_weissbk_rot
	elseif (self.colour == "white") then self.gfx = gfx_weissbk_weis
	elseif (self.colour == "yellow") then self.gfx = gfx_weissbk_weis
	end

	self:Register()
	
	self.t = 0
	self.next_shot_t = gMyTime + (0.8 + 0.4*randf()) * kShotInterval_Enemy
end

function cEnemyWhite:Draw() 
	--if gPlayer.weaponPower <= 0.1 then
		if gPlayer.wType == "red" and self.colour == "red" then
			love.graphics.setColor(150 + 105 * math.sin(self.t * 2), 0, 150 + 105 * math.sin(self.t * 2), 50)
			self:DrawWobble(0.2,0.1,gEnemyGfxScale + 0.3) 
		elseif gPlayer.wType == "green" and self.colour == "green" then
			love.graphics.setColor(0, 150 + 105 * math.sin(self.t * 2), 0, 50)
			self:DrawWobble(0.2,0.1,gEnemyGfxScale + 0.3) 
		elseif gPlayer.wType == "blue" and self.colour == "blue" then
			love.graphics.setColor(0, 0, 150 + 105 * math.sin(self.t * 2), 50)
			self:DrawWobble(0.2,0.1,gEnemyGfxScale + 0.3) 
		elseif gPlayer.wType == "white" and self.colour == "yellow" then
			love.graphics.setColor(150 + 105 * math.sin(self.t * 2), 150 + 105 * math.sin(self.t * 2), 150 + 105 * math.sin(self.t * 2), 50)
			self:DrawWobble(0.2,0.1,gEnemyGfxScale + 0.3) 
		end
		love.graphics.setColor(255, 255, 255, 255)
	--end
	self:DrawWobble(0.2,0.1,gEnemyGfxScale) 
end

function cEnemyWhite:Update (dt)
	self.t = self.t + dt
	if self.t >= 1000 then self.t = 0 end
	
	local rnd = math.random()
	if (gMyTime > self.next_shot_t) then
		self.next_shot_t = gMyTime + (0.8 + 0.4*randf()) * kShotInterval_Enemy
		local x = self.x
		local y = self.y
		local dirX = gPlayer.x - x
		local dirY = gPlayer.y - y + math.random(-250, 250)
		local norm = math.sqrt(dirX*dirX + dirY*dirY)
		local lifetime = 5.0
		cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "white", "white")
	end

	self.dx = clamp(self.dx + math.random(-20, 20), -100, 100)
	self.dy = clamp(self.dy + math.random(-20, 20), -100, 100)
	self.x = min(self.x + dt * self.dx, love.graphics.getWidth())
	self.y = self.y + dt * self.dy
end

