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
	self.gfx = gfx_player
end
