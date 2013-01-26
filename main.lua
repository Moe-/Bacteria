sin = math.sin
PI = math.pi

gMyTime = love.timer.getTime( )
	
love.filesystem.load("lib.oop.lua")()
love.filesystem.load("lib.util.lua")()
love.filesystem.load("obj.base.lua")()
love.filesystem.load("obj.player.lua")()
love.filesystem.load("obj.shot.lua")()
love.filesystem.load("obj.level.lua")()
love.filesystem.load("obj.enemy-base.lua")()
love.filesystem.load("obj.enemy-blutplatt.lua")()
love.filesystem.load("obj.enemy-white.lua")()
love.filesystem.load("obj.enemy-red.lua")()
love.filesystem.load("obj.EffectSys.lua")()
love.filesystem.load("obj.spawner.lua")()

cGfx = CreateClass(cBase)
function cGfx:Init (img)
	self.img = img
	local w = img:getWidth()
	local h = img:getHeight()
	self.ox = w/2
	self.oy = h/2
end
function cGfx:Draw (x,y,r,sx,sy)
	love.graphics.draw(self.img,x,y,r,sx,sy,self.ox,self.oy)
end

function loadgfx (path) return cGfx:New(love.graphics.newImage(path)) end

function love.load ()
	effects = cEffectSys:New()
	local arr = {1,2,3,4}
	table.insert(arr,5)
	for k,v in ipairs(arr) do print("arr",k,v) end
	
	gfx_blutplatt	= loadgfx("data/blutplatt.png")
	gfx_dnabonus	= loadgfx("data/dnabonus.png")
	gfx_levelpart01	= loadgfx("data/levelpart01.png")
	gfx_player		= loadgfx("data/player.png")
	gfx_rotbk		= loadgfx("data/rotbk.png")
	gfx_shotplayer	= loadgfx("data/shot-player.png")
	gfx_shotweiss	= loadgfx("data/shot-weiss.png")
	gfx_weissbk		= loadgfx("data/weissbk.png")

    snd_background = love.audio.newSource("data/background.mp3")
    snd_background:setLooping(true)
    snd_background:setVolume(0.5)
    love.audio.play(snd_background)

    snd_shoot = love.audio.newSource("data/schuss.mp3", "static")
    snd_explosion = love.audio.newSource("data/explosion.mp3")

	love.graphics.setBackgroundColor( 40,0,0)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	gPlayer = cPlayer:New(w/2,h/2)

	gShots = {}
	gLevel = cLevel:New()

    gSpawner = cSpawner:New()
end

function love.update (dt)
	gMyTime = love.timer.getTime( )
	gLevel:Update(dt)
	gPlayer:Update(dt)
	effects:Update(dt)
    gSpawner:Update(dt)

    local shotsDelete = {}
	for i, v in pairs(gShots) do 
		if v:Update(dt) == false then
			table.insert(shotsDelete, i)
		end
	end

	for i, v in pairs(shotsDelete) do
		table.remove(gShots, v)
	end

	for i, v in pairs(gShots) do 
		Enemies_ShotTest(v)
		gPlayer:ShotTest(v, "white") 
	end
	Enemies_Update(dt)
end

function love.draw ()
	gMyTime = love.timer.getTime( )
	gLevel:Draw()
	effects:Draw()
	gPlayer:Draw()

	for i, v in pairs(gShots) do v:Draw() end
	Enemies_Draw()
	
	love.graphics.print("hello world",40,40)

	if (gPlayer:IsDead() == true) then
		love.graphics.print("DEAD",40,240)
	end
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) 
	elseif (keyname == "left"	or keyname == "a") then gPlayer:SetSpeedX(-2)
	elseif (keyname == "right"	or keyname == "d") then gPlayer:SetSpeedX(2)
	elseif (keyname == "up"		or keyname == "w") then gPlayer:SetSpeedY(-2)
	elseif (keyname == "down"	or keyname == "s") then gPlayer:SetSpeedY(2)
	else print("keypress",keyname)
	end
end

function love.keyreleased (keyname)
	if (keyname == "left") or (keyname == "right") or (keyname == "a") or (keyname == "d") then gPlayer:SetSpeedX(0)
	elseif (keyname == "up") or (keyname == "down") or (keyname == "w") or (keyname == "s") then gPlayer:SetSpeedY(0)
	end
end

function love.mousereleased(x, y, button)
	if (button == "l") then gPlayer:Shoot(x, y) end
end

>>>>>>> 767d0674947ba13bbf900b1dd89617c1a1fae22b
