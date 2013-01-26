cEnemyBase = CreateClass(cBase)

gEnemies = {}

function Enemies_Update (dt) for o,_ in pairs(gEnemies) do o:Update(dt) end end

function Enemies_ShotTest(shot) 
	for o,_ in pairs(gEnemies) do 
		if (o:ShotTest(shot) == false) then
			o:Destroy()
		end 
	end 
end

function Enemies_Draw () for o,_ in pairs(gEnemies) do o:Draw() end end


function cEnemyBase:Destroy()
	gEnemies[self] = nil
end
	
function cEnemyBase:Register()
	gEnemies[self] = true
end

function cEnemyBase:Init() 
end

function cEnemyBase:ShotTest(shot)
	if shot.sType == "player" and shot:DistToPos(self.x, self.y) < 25 then
		self.energy = self.energy - 20
		if (self.energy <= 0) then return false end
	end
	return true
end
