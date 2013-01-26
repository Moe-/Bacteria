cEnemyBase = CreateClass(cBase)

gEnemies = {}

function Enemies_Update (dt) for o,_ in pairs(gEnemies) do o:Update(dt) end end

function Enemies_ShotTest(shot) 
	for o,_ in pairs(gEnemies) do 
		o:ShotTest(shot, "player")
	end 
end



function Enemies_Draw () for o,_ in pairs(gEnemies) do o:Draw() end end


function cEnemyBase:NotifyDamage()
	local dx, dy = 1, 0
	effects:CreateEffect("hit", self.x, self.y, math.atan(dy/dx)*180/PI, true)
end

function cEnemyBase:Die()
	effects:CreateEffect("explosion", self.x, self.y, 0, false)
	self:Destroy()
end

function cEnemyBase:Destroy()
	gEnemies[self] = nil
end
	
function cEnemyBase:Register()
	self.radius = self.gfx and self.gfx.radius or 128
	gEnemies[self] = true
end

function cEnemyBase:Init() 
	enemy_kind = "base"
end

