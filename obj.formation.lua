cFormation = CreateClass()

function cFormation:Init()
    self.enemies = {}
    self.constraints = {}
end

function cFormation:addEnemy(enemy, offsetX, offsetY)
    table.insert(self.enemies, {enemy = enemy,  offsetX = offsetX,  offsetY = offsetY})
end

function cFormation:addConstraint(constraint)
    table.insert(self.constraints, constraint)
end

function cFormation:maySpawn()
    local maySpawn = true
	if (self.min_total_spawned and gFormationsSpawnedTotal < self.min_total_spawned) then return false end
	if (self.min_spawned_since_boss and gFormationsSpawnedSinceBoss < self.min_spawned_since_boss) then return false end
    for k,v in pairs(self.constraints) do
        if (v:maySpawn() == false) then
            maySpawn = false
            break
        end
    end
    return maySpawn
end

-- FormationConstraints following
cFormationConstraintNumberSpawns = CreateClass()

function cFormationConstraintNumberSpawns:Init(formation, numberOfSpawns)
    self.numberOfSpawns = numberOfSpawns

end

function cFormationConstraintNumberSpawns:maySpawn()
    local count = 0
    for k,v in pairs(gFormationsHistory) do
        count = count + v
    end
    return (count >= self.numberOfSpawns)
end

cFormationConstraintSpawnOnce = CreateClass()

function cFormationConstraintSpawnOnce:Init(formation)
    self.formation = formation
end

function cFormationConstraintSpawnOnce:maySpawn()
    for k,v in pairs(gFormationsHistory) do
        if (k == self.formation) then -- already was here
            return false
        end
    end
    return true
end







