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
	-- todo: effect
end

function cEnemyBase:Die()
	effects:CreateEffect("explosion", self.x, self.y, 0, false)
	self:Destroy()
end

function cEnemyBase:Destroy()
	gEnemies[self] = nil
end
	
function cEnemyBase:Register()
	gEnemies[self] = true
end

function cEnemyBase:Init() 
end

