cSpawner = CreateClass()

function cSpawner:Init()
    print "Spawm me"
    self.formations = {
                    {
                       {enemy = "blutplatt",offsetX = 80, offsetY = 80},
                       {enemy = "blutplatt",offsetX = -80, offsetY = -80},
                       {enemy = "red",offsetX = 80, offsetY = -80},
                       {enemy = "red",offsetX = -80, offsetY = 80},
                       {enemy = "white",offsetX = 0, offsetY = 0},
                    },
                    {
                       {enemy = "red",offsetX = 0, offsetY = 200},
                       {enemy = "red",offsetX = 0, offsetY = 100},
                       {enemy = "white",offsetX = 0, offsetY = 0},
                       {enemy = "red",offsetX = 0, offsetY = -100},
                       {enemy = "red",offsetX = 0, offsetY = -200},
                    },
                    {
                       {enemy = "boss",offsetX = 0, offsetY = 0}
                    }
                   }
end

function cSpawner:spawnFormation()
    rand = math.random(1,#self.formations)
    print ("Spawning formation " .. rand)
    formation = self.formations[rand]
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local center = randf() * h

    for k,v in pairs(formation) do
        if (v['enemy'] == "blutplatt") then
            cEnemyBlutPlatt:New(0.7*w + v['offsetX'],center + v['offsetY'])
        elseif (v['enemy'] == "red") then
            cEnemyRed:New(0.7*w + v['offsetX'],center + v['offsetY'])
        elseif (v['enemy'] == "white") then
            cEnemyWhite:New(0.7*w + v['offsetX'],center + v['offsetY'])
        elseif (v['enemy'] == "boss") then
            cEnemyBossBase:New(0.7*w + v['offsetX'],center + v['offsetY'])
        end
    end
end

function cSpawner:Update()
    if (count(gEnemies) < 1) then
        self:spawnFormation()
    end
end


