cEnemyRed = CreateClass(cEnemyBase)

function cEnemyRed:Init(x,y) 
	self.x = x
	self.y = y
	self.energy = 100
	self.gfx = gfx_rotbk
	self:Register()
end

function cEnemyRed:Draw() self:DrawWobble(0.2,0.1,gEnemyGfxScale) end

function cEnemyRed:Update(dt)
	self.x = self.x - 300 * dt
	if self.x < 0 then
		self:Destroy()
	end
end