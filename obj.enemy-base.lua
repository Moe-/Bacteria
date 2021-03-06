cEnemyBase = CreateClass(cBase)

gEnemies = {}

function Enemies_Update (dt) 
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	
	for o,_ in pairs(gEnemies) do 
		local r = o.radius or 10
		if (not o.bCanLeaveScreen) then 
			o.x = max(r,min(w-r,o.x))
			o.y = max(r,min(h-r,o.y))
		end
		o:Update(dt)
		o:CheckCollisionWithPlayer(dt)
		if (o.bDieLeftOfScreen and o.x < -r - 10) then 
			o:Die()
		end
	end 
end

function Enemies_ShotTest(shot) 
	for o,_ in pairs(gEnemies) do 
		o:ShotTest(shot, "player")
	end 
end



function Enemies_Draw () for o,_ in pairs(gEnemies) do o:Draw() end end


function cEnemyBase:NotifyDamage(bResist)
	local dx, dy = 1, 0
	if (bResist) then 
		print("resist hit!")
		effects:CreateEffect("resist", self.x, self.y, math.atan(dy/dx)*180/PI, true)
	else
		effects:CreateEffect("hit", self.x, self.y, math.atan(dy/dx)*180/PI, true)
	end
end

function cEnemyBase:Die()
	effects:CreateEffect("explosion", self.x, self.y, 0, false)

	if self.enemy_kind ~= nil then
		if self.enemy_kind == "bossbase" then 
			gPlayer:AddPoints(10000)
			play_sound(snd_explosion)
		elseif self.enemy_kind == "blutplatt" then 
			gPlayer:AddPoints(125)
			play_sound(snd_explosion2)
		elseif self.enemy_kind == "egg" then 
			gPlayer:AddPoints(15)
			play_sound(snd_explosion3)
		elseif self.enemy_kind == "red" then 
			gPlayer:AddPoints(150)
			play_sound(snd_explosion4)
		elseif self.enemy_kind == "weapon" then 
			gPlayer:AddPoints(50)
			play_sound(snd_explosion5)
		elseif self.enemy_kind == "white" then 
			gPlayer:AddPoints(225)
			play_sound(snd_explosion6)
		elseif self.enemy_kind == "base" then 
			gPlayer:AddPoints(123)
			play_sound(snd_explosion7)
		else 
			gPlayer:AddPoints(11)
			play_sound(snd_explosion7)
		end
	end
	
	self:Destroy()
end

function cEnemyBase:Destroy()
	gEnemies[self] = nil
end
	
function cEnemyBase:Register()
	self.radius = self.gfx and self.gfx.radius and (self.gfx.radius * 0.5) or 128
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
		if gPlayer:IsDead() == false then
			play_sound(snd_collision)
		end
	end
end

