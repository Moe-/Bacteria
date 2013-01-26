cPlayer = CreateClass(cBase)

function cPlayer:Draw() 
	local t = gMyTime
	local s = 1.0 + 0.2 * sin(t*PI)
	local r = PI * 0.1 * sin(t*0.9*PI)

	love.graphics.setColor(255, 255, 255, self.alpha)
	self.gfx:Draw(self.x,self.y,r,s,s)
	love.graphics.setColor(255, 255, 255, 255)
end

function cPlayer:Init(x,y) 
	print("player init")
	self.x = x
	self.y = y
	self.energy = 1000
	self.dx = 0
	self.dy = 0
	self.alpha = 255
	self:UpdateWeapon("white")
	self.radius = self.gfx.radius * 0.5
end

function cPlayer:Update(dt)
	self.x = clamp(self.x + self.dx, 0, love.graphics.getWidth())
	self.y = clamp(self.y + self.dy, 0, love.graphics.getHeight())
	if (self:IsDead() == true) and self.alpha > 0 then
		self.alpha = self.alpha - 5
	end

	if self.weaponPower > 0 then
		self.weaponPower = max(0, self.weaponPower - 0.5 * dt) -- 30 seconds until weapon suxx
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
	if (self.energy <= 0) then return true end
	return false
end

function cPlayer:UpdateWeapon(wType)
	if (self.wType ~= wType) then
		self.weaponPower = 2.0
		self.wType = wType
		
		if (wType == "red") then self.gfx = gfx_player_rot
		elseif (wType == "green") then self.gfx = gfx_player_gruen
		elseif (wType == "blue") then self.gfx = gfx_player_blau
		elseif (wType == "white") then self.gfx = gfx_player_weis
		end
	end
end

function cPlayer:GetWeaponPower()
	return self.weaponPower
end
