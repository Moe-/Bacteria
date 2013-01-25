cEnemyWhite = CreateClass(cEnemyBase)

function cEnemyWhite:Init(x,y) 
	self.x = x
	self.y = y
	self.gfx = gfx_weissbk
	self:Register()
end

function cEnemyWhite:Draw() self:DrawWobble(0.2,0.1) end
