cSpawner = CreateClass()
love.filesystem.load("obj.formation.lua")()

function cSpawner:Init()

    self.formations = {}
    local e = 80

    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("blutplatt", 0 * e, -2 * e)
    formation:addEnemy("blutplatt", 0 * e, -1 * e)
    formation:addEnemy("blutkoerper", 0 * e, 0 * e)
    formation:addEnemy("blutplatt", 0 * e, 1 * e)
    formation:addEnemy("blutplatt", 0 * e, 2 * e)

    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("red" , 1 * e, -1 * e)
    formation:addEnemy("blue", 0 * e, 0 * e)
    formation:addEnemy("red" , 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("blue", 0 * e, 0 * e)
    formation:addEnemy("blue", 1 * e, 0 * e)
    formation:addEnemy("yellow", 0 * e, 1 * e)
    formation:addEnemy("yellow", 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("blue", 0 * e, 0 * e)
    formation:addEnemy("blue", 1 * e, 0 * e)
    formation:addEnemy("yellow", 0 * e, 1 * e)
    formation:addEnemy("yellow", 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("red", 0 * e, 0 * e)
    formation:addEnemy("red", 0 * e, 1 * e)
    formation:addEnemy("yellow", 1 * e, 0 * e)
    formation:addEnemy("yellow", 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("yellow", 2 * e,-1 * e)
    formation:addEnemy("green", 1 * e,-1 * e)
    formation:addEnemy("green", 0 * e, 0 * e)
    formation:addEnemy("green", 1 * e, 1 * e)
    formation:addEnemy("yellow", 2 * e, 1 * e)
	
	-- red,green,blue,yellow
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("boss", 0 , 0)
    formation:addConstraint(cFormationConstraintNumberSpawns:New(formation, 1))
    formation:addConstraint(cFormationConstraintSpawnOnce:New(formation))

end

function cSpawner:spawnFormation()
    local counter = 0
    local maySpawn = false
    local formation = nil
    local index = 0
    repeat
        counter = counter + 1
        index = math.random(1,#self.formations)
        formation = self.formations[index]
        maySpawn = formation:maySpawn()
        if (maySpawn == false) then
            formation = nil
        else
            if (gFormationsHistory[formation] == nil) then
                gFormationsHistory[formation] = 1
            else
                gFormationsHistory[formation] = gFormationsHistory[formation] + 1
            end
        end
    until (maySpawn) or (counter > 100)

    if (formation == nil) then
        print ("Obviously no more formations left - or murphy is a bitch ;))")
    end


    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local center = randf() * h

	local startx = 1.1*w
	local startxboss = 0.7*w
    for k,v in pairs(formation.enemies) do
        if (v.enemy == "blutplatt") then
            cEnemyBlutPlatt:New(startx + v.offsetX,center + v.offsetY)
        elseif (v.enemy == "blutkoerper") then
            cEnemyRed:New(startx + v.offsetX,center + v.offsetY)
        elseif (v.enemy == "red"	) then cEnemyWhite:New(startx + v.offsetX,center + v.offsetY, "red")
        elseif (v.enemy == "green"	) then cEnemyWhite:New(startx + v.offsetX,center + v.offsetY, "green")
        elseif (v.enemy == "blue"	) then cEnemyWhite:New(startx + v.offsetX,center + v.offsetY, "blue")
        elseif (v.enemy == "yellow"	) then cEnemyWhite:New(startx + v.offsetX,center + v.offsetY, "yellow")
        elseif (v.enemy == "boss") then
            cEnemyBossBase:New(startxboss + v.offsetX,center + v.offsetY)
        end
    end
end

function cSpawner:spawnWeapons()
    local rand = math.random(1,100)
    if (rand == 1) then
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()

        cEnemyWeapon:New(0.9*w,randf()*h, rand_in_arr({"red", "green", "blue", "white"}))
    end
end

function cSpawner:EnemiesOnScreen()
    local found = false
    for k,v in pairs(gEnemies) do
        if ((v == true) and (k.enemy_kind ~= "weapon")) then
            found = true
            break
        end
    end
    return found
end


function cSpawner:Update()
    self:spawnWeapons()

    if (self:EnemiesOnScreen() == false) then
        self:spawnFormation()
    end
end


