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
	self.energy = 100*100
	self.dx = 0
	self.dy = 0
	self.alpha = 255
	self.gfx = gfx_player
end

function cPlayer:Update(dt)
	self.x = self.x + self.dx
	self.y = self.y + self.dy
	if (self:IsDead() == true) and self.alpha > 0 then
		self.alpha = self.alpha - 5
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
	table.insert(gShots, cShot:New(x, y, dirX/norm, dirY/norm, lifetime, "player"))
end

function cPlayer:IsDead()
	if (self.energy <= 0) then return true end
	return false
end


