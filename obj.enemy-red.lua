cEnemyRed = CreateClass(cEnemyBase)

function cEnemyRed:Init(x,y) 
	self.x = x
	self.y = y
	self.gfx = gfx_rotbk
	self:Register()
end

function cEnemyRed:Draw() self:DrawWobble(0.2,0.1) end
