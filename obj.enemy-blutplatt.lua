cEnemyBlutPlatt = CreateClass(cEnemyBase)

function cEnemyBlutPlatt:Init(x,y) 
	self.x = x
	self.y = y
	self.energy = 120
	self.gfx = gfx_blutplatt
	self:Register()
end

function cEnemyBlutPlatt:Draw() self:DrawWobble(0.2,0.1,gEnemyGfxScale) end
