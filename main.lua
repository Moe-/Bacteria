sin = math.sin
PI = math.pi

gEnemyGfxScale = 0.5
gEnemyBossGfxScale = 0.7
--~ gEnemyGfxScale = 1
gPlayerSpeed = 10

--[[
TODO liste code : 
* wand kollision
* wand teile drehen
* wand rand
* boss teile schaden / sterben  
* gegner formationen spawnen
* waffe rot/gr�n/blau
* waffen wechseln bei bonus gegner einsammeln
* weisse blutk�rperchen resistenz
* boss nach zeit x
* final boss herz !
* background tiled
* rotbk anim ?
]]--

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
love.filesystem.load("obj.enemy-boss.lua")()
love.filesystem.load("obj.enemy-weapon.lua")()
love.filesystem.load("obj.EffectSys.lua")()
love.filesystem.load("obj.spawner.lua")()

cGfx = CreateClass(cBase)
function cGfx:Init (img)
	self.img = img
	local w = img:getWidth()
	local h = img:getHeight()
	self.radius = 0.5*h
	self.ox = w/2
	self.oy = h/2
end
function cGfx:Draw (x,y,r,sx,sy)
	love.graphics.draw(self.img,x,y,r,sx,sy,self.ox,self.oy)
end
function cGfx:DrawY0 (x,y,r,sx,sy)
	love.graphics.draw(self.img,x,y,r,sx,sy,self.ox,0)
end

function loadgfx (path) return cGfx:New(love.graphics.newImage(path)) end

function love.load ()
	effects = cEffectSys:New()
	
	effects:CreateEffect("slowtrail", 500, 0, 0, false)
	
	gfx_blutplatt	= loadgfx("data/blutplatt.png")
	gfx_dnabonus	= loadgfx("data/dnabonus.png")
	--~ gfx_levelpart01	= loadgfx("data/levelpart01.png")
	gfx_player_blau		= loadgfx("data/player_blau.png")
	gfx_player_gruen		= loadgfx("data/player_gruen.png")
	gfx_player_rot		= loadgfx("data/player_rot.png")
	gfx_player_weis		= loadgfx("data/player_weis.png")
	gfx_rotbk		= loadgfx("data/rotbk.png")
	gfx_shotplayer	= loadgfx("data/shot-player.png")
	gfx_shotweiss	= loadgfx("data/shot-weiss.png")
	gfx_weissbk		= loadgfx("data/weissbk.png")
	gfx_dnabonus_blau	= loadgfx("data/dnabonus_blau.png")
	gfx_dnabonus_gruen	= loadgfx("data/dnabonus_gruen.png")
	gfx_dnabonus_rot	= loadgfx("data/dnabonus_rot.png")
	gfx_dnabonus_weis	= loadgfx("data/dnabonus_weis.png")
	gfx_boss_core	= loadgfx("data/boss-core.png")
	gfx_boss_mid	= loadgfx("data/boss-mid.png")
	gfx_boss_gun	= loadgfx("data/boss-gun.png")
	gfx_boss_spike	= loadgfx("data/boss-spike.png")
	gfx_border01	= loadgfx("data/border01.png")
	gfx_wallA	= {	loadgfx("data/border1.png"),
					loadgfx("data/border2.png"),
					loadgfx("data/border3.png"),}
	gfx_wallB	= {	loadgfx("data/border_b_1.png"),
					loadgfx("data/border_b_2.png"),
					loadgfx("data/border_b_3.png"), bFlip=true}
	gfx_background1	= loadgfx("data/background1.png")
	gfx_background2	= loadgfx("data/background2.png")
	gfx_egg			= loadgfx("data/egg.png")
	
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

    gFormationsHistory = {}

	gShootNext = -1
end

function love.update (dt)
	gMyTime = love.timer.getTime( )
	gPlayer:Update(dt)
	effects:Update(dt)
    gSpawner:Update(dt)

	Shots_Update(dt)
	Shots_HitTest()

--	gBoss:Update(dt)
	Enemies_Update(dt)
	gLevel:Update(dt)

	if(gShootNext > -1) then
		gShootNext = gShootNext - dt
		if (gShootNext < 0) then
			local x, y = love.mouse.getPosition()
			gPlayer:Shoot(x, y)
			gShootNext = 0.15
		end
	end
end

function love.draw ()
	gMyTime = love.timer.getTime( )
	
	gLevel:DrawBack()
	
--	gBoss:Draw()
	effects:DrawBelow()
	gPlayer:Draw()
	effects:DrawAbove()

	Shots_Draw()
	Enemies_Draw()
	
	--~ love.graphics.print("hello world",40,40)
	
	gLevel:Draw()

	if (gPlayer:IsDead() == true) then
		love.graphics.print("DEAD",40,240)
	end
	
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) 
	elseif (keyname == "left"	or keyname == "a") then gPlayer:SetSpeedX(-gPlayerSpeed)
	elseif (keyname == "right"	or keyname == "d") then gPlayer:SetSpeedX(gPlayerSpeed)
	elseif (keyname == "up"		or keyname == "w") then gPlayer:SetSpeedY(-gPlayerSpeed)
	elseif (keyname == "down"	or keyname == "s") then gPlayer:SetSpeedY(gPlayerSpeed)
	elseif (keyname == "1") then gLevel.gfx_wall = gfx_wallA
	elseif (keyname == "2") then gLevel.gfx_wall = gfx_wallB
	elseif (keyname == "5") then TestBossSpawn()
	elseif (keyname == "6") then TestBossSpawn(cEnemyBossFinal)
	elseif (keyname == " ") then gShootNext = 0
	else print("keypress",keyname)
	end
end

function TestBossSpawn(bossclass)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	bossclass = bossclass or cEnemyBoss02
	bossclass:New(0.7*w,0.5*h)
end

function love.keyreleased (keyname)
	if ((keyname == "left" or keyname == "a") and not (love.keyboard.isDown("right") or love.keyboard.isDown("d"))) 
		or ((keyname == "right" or keyname == "d") and not (love.keyboard.isDown("left") or love.keyboard.isDown("a"))) then
		gPlayer:SetSpeedX(0)
	elseif (keyname == "left" or keyname == "a") and (love.keyboard.isDown("right") or love.keyboard.isDown("d")) then
		gPlayer:SetSpeedX(gPlayerSpeed)
	elseif (keyname == "right" or keyname == "d") and (love.keyboard.isDown("left") or love.keyboard.isDown("a")) then
		gPlayer:SetSpeedX(-gPlayerSpeed)
	end
	
	if ((keyname == "up" or keyname == "w") and not (love.keyboard.isDown("down") or love.keyboard.isDown("s"))) 
		or ((keyname == "down" or keyname == "s") and not (love.keyboard.isDown("up") or love.keyboard.isDown("w"))) then
		gPlayer:SetSpeedY(0)
	elseif (keyname == "up" or keyname == "w") and (love.keyboard.isDown("down") or love.keyboard.isDown("s")) then
		gPlayer:SetSpeedY(gPlayerSpeed)
	elseif (keyname == "down" or keyname == "s") and (love.keyboard.isDown("up") or love.keyboard.isDown("w")) then
		gPlayer:SetSpeedY(-gPlayerSpeed)
    elseif (keyname == " ") then gShootNext = -1
    end
	


	--if (keyname == "left") or (keyname == "right") or (keyname == "a") or (keyname == "d") then gPlayer:SetSpeedX(0)
	--elseif (keyname == "up") or (keyname == "down") or (keyname == "w") or (keyname == "s") then gPlayer:SetSpeedY(0)
	--end
end

function love.mousereleased(x, y, button)
	if (button == "l") then gPlayer:Shoot(x, y) end
	if (button == "r") then gShootNext = -1 end
end

function love.mousepressed(x, y, button)
	if (button == "r") then gShootNext = 0 end
end
