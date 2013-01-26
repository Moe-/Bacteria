cEnemyBase = CreateClass(cBase)

gEnemies = {}

function Enemies_Update (dt) 
	for o,_ in pairs(gEnemies) do 
		o:Update(dt)
		o:CheckCollisionWithPlayer(dt)
	end 
end

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
	self.nextCollisionTime = 0
	gEnemies[self] = true
end

function cEnemyBase:Init() 
	self.enemy_kind = "base"
end

function cEnemyBase:CheckCollisionWithPlayer(dt)
	self.nextCollisionTime = max(self.nextCollisionTime - dt, 0)
	if self.enemy_kind ~= "weapon" and (self:DistToObj(gPlayer) < 25 and self.nextCollisionTime == 0) then
		gPlayer:Damage(20)
		self.nextCollisionTime = 0.25
		
		local dy = self.y - gPlayer.y
		local dx = self.x - gPlayer.x
		
		effects:CreateEffect("hit", self.x, self.y, math.atan(dy/dx)*180/PI, true)
	end
end

