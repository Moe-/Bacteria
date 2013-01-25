cPlayer = CreateClass(cBase)

function cPlayer:Draw() 
	local t = gMyTime
	local s = 1.0 + 0.2 * sin(t*PI)
	local r = PI * 0.1 * sin(t*0.9*PI)
	local gfx = self.gfx
	love.graphics.draw(gfx.img,self.x,self.y,r,s,s,gfx.ox,gfx.oy)
end

function cPlayer:Init(x,y) 
	print("player init")
	self.x = x
	self.y = y
	self.dx = 0
	self.dy = 0
	self.gfx = gfx_player
end

function cPlayer:Update(dt)
	self.x = self.x + self.dx
	self.y = self.y + self.dy
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
	table.insert(gShots, cShot:New(x, y, dirX/norm, dirY/norm, lifetime))
end

