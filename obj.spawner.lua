cSpawner = CreateClass()
love.filesystem.load("obj.formation.lua")()
kBossSpawn_MinTotal		= 6
kBossSpawn_MinSinceLast	= 4
kWhiteSpawn_MinTotal 	= kBossSpawn_MinTotal/2

function cSpawner:Init()
	
	gFinalBoss = false
	gFormationsSpawnedTotal = 0
	gFormationsSpawnedSinceBoss = 0
	gBossIndex = 1
	gBossArr = {cEnemyBoss01,cEnemyBoss02,cEnemyBossFinal}
	
    self.formations = {}
    local e = 80

    local formation = cFormation:New() table.insert(self.formations, formation)

    formation:addEnemy("blutplatt", 0 * e, -2 * e)
    formation:addEnemy("blutplatt", 0 * e, -1 * e)
    formation:addEnemy("blutkoerper", 0 * e, 0 * e)
    formation:addEnemy("blutplatt", 0 * e, 1 * e)
    formation:addEnemy("blutplatt", 0 * e, 2 * e)

    local formation = cFormation:New() table.insert(self.formations, formation)

    formation.min_total_spawned = 2
    formation:addEnemy("red" , 1 * e, -1 * e)
    formation:addEnemy("blue", 0 * e, 0 * e)
    formation:addEnemy("red" , 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation.min_total_spawned = kWhiteSpawn_MinTotal
    formation:addEnemy("blue", 0 * e, 0 * e)
    formation:addEnemy("blue", 1 * e, 0 * e)
    formation:addEnemy("yellow", 0 * e, 1 * e)
    formation:addEnemy("yellow", 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation.min_total_spawned = kWhiteSpawn_MinTotal
    formation:addEnemy("blue", 0 * e, 0 * e)
    formation:addEnemy("blue", 1 * e, 0 * e)
    formation:addEnemy("green", 0 * e, 1 * e)
    formation:addEnemy("green", 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation.min_total_spawned = kWhiteSpawn_MinTotal
    formation:addEnemy("red", 0 * e, 0 * e)
    formation:addEnemy("red", 0 * e, 1 * e)
    formation:addEnemy("yellow", 1 * e, 0 * e)
    formation:addEnemy("yellow", 1 * e, 1 * e)
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation.min_total_spawned = kBossSpawn_MinTotal
    formation:addEnemy("yellow", 2 * e,-1 * e)
    formation:addEnemy("green", 1 * e,-1 * e)
    formation:addEnemy("green", 0 * e, 0 * e)
    formation:addEnemy("green", 1 * e, 1 * e)
    formation:addEnemy("yellow", 2 * e, 1 * e)
	
	-- red,green,blue,yellow
	
    local formation = cFormation:New() table.insert(self.formations, formation)

    formation.min_total_spawned = kBossSpawn_MinTotal
    formation.min_spawned_since_boss = kBossSpawn_MinSinceLast
    formation:addEnemy("boss", 0 , 0)
    --~ formation:addConstraint(cFormationConstraintNumberSpawns:New(formation, 1))
    --~ formation:addConstraint(cFormationConstraintSpawnOnce:New(formation))

end

function cSpawner:spawnFormation()
    local counter = 0
    local maySpawn = false
    local formation = nil
    local index = 0
	
	print("gFormationsSpawnedTotal",gFormationsSpawnedTotal)
	print("gFormationsSpawnedSinceBoss",gFormationsSpawnedSinceBoss)
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
			local bossclass = gBossArr[gBossIndex] or gBossArr[#gBossArr]
			gBossIndex = gBossIndex + 1
			
            bossclass:New(startxboss + v.offsetX,center + v.offsetY)
			gFormationsSpawnedSinceBoss = 0 -- reset for next boss
        end
    end
end

function cSpawner:spawnWeapons()
	if (self:BossOnScreen()) then return end
    local rand = math.random(1,100)
    if (rand == 1) then
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()

        cEnemyWeapon:New(1.1*w,randf()*h, rand_in_arr({"red", "green", "blue", "white"}))
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

function cSpawner:BossOnScreen()
    for o,_ in pairs(gEnemies) do
        if (o.bIsBossPart) then return true end
    end
end


function cSpawner:Update()
    self:spawnWeapons()

    if (self:EnemiesOnScreen() == false) then
        self:spawnFormation()
		gFormationsSpawnedTotal = gFormationsSpawnedTotal + 1
		gFormationsSpawnedSinceBoss = gFormationsSpawnedSinceBoss + 1
    end
end


