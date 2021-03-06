cPlayer = CreateClass(cBase)

function cPlayer:Draw() 
	local t = gMyTime
	local s = 1.0 + 0.2 * sin(t*PI)
	local r = PI * 0.1 * sin(t*0.9*PI)

	love.graphics.setColor(255, 255, 255, self.alpha)
	self.gfx:Draw(self.x+gCamShakeAddX,self.y+gCamShakeAddY,r,s,s)
	love.graphics.setColor(255, 255, 255, 255)
	
	if (SHOW_DEBUG_CIRCLE) then love.graphics.circle("line",self.x,self.y,self.radius,11) end
end

function cPlayer:Init(x,y) 
	--~ print("player init")
	self.bIsPlayer = true
	self.kind = "player"
	self.x = x
	self.y = y
	self.energy = cPlayerEnergyMax
	self.dx = 0
	self.dy = 0
	self.alpha = 255
	self.playSounds = false
	self:UpdateWeapon("white")
	self.radius = self.gfx.radius * 0.35
	self.points = 0
	--~ print("player init r=",self.radius)
	
	
	self.weaponPower = 2.0
	self.decaytime = 10
	self.dwp = self.weaponPower / self.decaytime
	self.playSounds = true
end

function cPlayer:Update(dt)
	self.x = clamp(self.x + self.dx, 0, love.graphics.getWidth())
	self.y = clamp(self.y + self.dy, 0, love.graphics.getHeight())
	if (self:IsDead() == true) and self.alpha > 0 then
		self.alpha = self.alpha - 5
	end

	if self.weaponPower > 0 then
		self.weaponPower = max(0, self.weaponPower - self.dwp * dt) -- 30 seconds until weapon suxx
	end

 	if self.bCollidingWithTop then
 		self.bCollidingWithTop = false
 		effects:CreateEffect("bloodborder", self.x, self.y - 50, 90, false)
 	elseif self.bCollidingWithBottom then
 		self.bCollidingWithBottom = false
 		effects:CreateEffect("bloodborder", self.x, self.y + 50, 270, false)
	end
end

function cPlayer:SetSpeedX(val)
	self.dx = val
end

function cPlayer:SetSpeedY(val)
	self.dy = val
end

function cPlayer:Shoot(cx, cy)
	local x = self.x
	local y = self.y
	local dirX = cx - x
	local dirY = cy - y
	local norm = math.sqrt(dirX*dirX + dirY*dirY)
	local lifetime = 5.0
	cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "player", self.wType)
end

function cPlayer:IsDead()
	if (self.energy <= 0) then
		if (self.playSounds == true) then
			love.audio.play(snd_explosion)
			self.playSounds = false
		end
		return true 
	end
	return false
end

function cPlayer:UpdateWeapon(wType)
	if (self.wType ~= wType) then
		self.weaponPower = 2.0
		self.wType = wType
		
		if (wType == "red") then 
			self.gfx = gfx_player_rot
			if (self.playSounds == true) then play_sound(snd_powerup) end
		elseif (wType == "green") then 
			self.gfx = gfx_player_gruen
			if (self.playSounds == true) then play_sound(snd_powerup2) end
		elseif (wType == "blue") then 
			self.gfx = gfx_player_blau
			if (self.playSounds == true) then play_sound(snd_powerup3) end
		elseif (wType == "white") then 
			self.gfx = gfx_player_weis
			if (self.playSounds == true) then play_sound(snd_powerup4) end
		end
	end
end

function cPlayer:GetWeaponPower()
	return self.weaponPower
end

function cPlayer:AddPoints(points)
	self.points = self.points + points
end

function cPlayer:GetPoints()
	return self.points
end
