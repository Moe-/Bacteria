cEnemyBase = CreateClass(cBase)

gEnemies = {}

function Enemies_Update (dt) for o,_ in pairs(gEnemies) do o:Update(dt) end end

function Enemies_Draw () for o,_ in pairs(gEnemies) do o:Draw() end end


function cEnemyBase:Destroy()
	gEnemies[self] = nil
end
	
function cEnemyBase:Register()
	gEnemies[self] = true
end

function cEnemyBase:Init() 
end

