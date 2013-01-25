cPlayer = CreateClass(cBase)

function cPlayer:Draw() 
	local t = gMyTime
	local s = 1.0 + 0.2 * sin(t*PI)
	local r = PI * 0.1 * sin(t*0.9*PI)
	self.gfx:Draw(self.x,self.y,r,s,s)
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

