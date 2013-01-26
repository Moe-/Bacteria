cEnemyBase = CreateClass(cBase)

gEnemies = {}

function Enemies_Update (dt) for o,_ in pairs(gEnemies) do o:Update(dt) end end

function Enemies_ShotTest(shot) for i, v in pairs(gEnemies) do o:ShotTest(shot) end end

function Enemies_Draw () for o,_ in pairs(gEnemies) do o:Draw() end end


function cEnemyBase:Register()
	gEnemies[self] = true
end

function cEnemyBase:Init() 
end

function cEnemyBase:ShotTest(shot)
	self.energy = self.energy - 20
	if (self.energy <= 0) then return false end
	return true
end
