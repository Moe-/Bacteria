sin = math.sin
PI = math.pi

gEnemyGfxScale = 0.5
gEnemyBossGfxScale = 0.7
--~ gEnemyGfxScale = 1
gPlayerSpeed = 10
cPlayerEnergyMax = 1000
cTStateChange = 1.0

-- music gen : http://www.inudge.net/
-- sound gen : http://www.drpetter.se/project_sfxr.html

--~ SHOW_DEBUG_CIRCLE = true

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

cam shake on player hit
cam slimed (y-stretch)
scroll speed + gegner extra speed = herzschlag.

schleim sieht nicht aus wie auf cam.
particel trails zu intensiv -> alpha : done
boss 1 schiesst nicht ? ok. 

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
love.filesystem.load("obj.SpriteStretch.lua")()
love.filesystem.load("obj.highscores.lua")()
love.filesystem.load("obj.EffBloodTitle.lua")()

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
function cGfx:DrawX0Y0 (x,y,r,sx,sy)
	love.graphics.draw(self.img,x,y,r,sx,sy,0,0)
end

function loadgfx (path) return cGfx:New(love.graphics.newImage(path)) end

function love.load ()
	effects = cEffectSys:New()
	
	effects:CreateEffect("slowtrail", 500, 0, 0, false)
	
	slime = love.graphics.newImage("data/slime1.png")
	
	gfx_titlescreen	= loadgfx("data/Wall.jpg")
	gfx_blutplatt	= loadgfx("data/blutplatt.png")
	gfx_dnabonus	= loadgfx("data/dnabonus.png")
	--~ gfx_levelpart01	= loadgfx("data/levelpart01.png")
	gfx_deco		= { loadgfx("data/bg1.png"),
						loadgfx("data/bg2.png"),
						loadgfx("data/egg.png")}
	gfx_player_blau		= loadgfx("data/player_blau.png")
	gfx_player_gruen		= loadgfx("data/player_gruen.png")
	gfx_player_rot		= loadgfx("data/player_rot.png")
	gfx_player_weis		= loadgfx("data/player_weis.png")
	gfx_rotbk		= loadgfx("data/rotbk.png")
	gfx_shotplayer_blau	= loadgfx("data/shot-player_blau.png")
	gfx_shotplayer_rot	= loadgfx("data/shot-player_rot.png")
	gfx_shotplayer_gruen	= loadgfx("data/shot-player_gruen.png")
	gfx_shotplayer_weis	= loadgfx("data/shot-player_weis.png")
	gfx_shotweiss	= loadgfx("data/shot-weiss.png")
	gfx_weissbk_blau		= loadgfx("data/bk_blau.png")
	gfx_weissbk_rot		= loadgfx("data/bk_rot.png")
	gfx_weissbk_gruen		= loadgfx("data/bk_gruen.png")
	gfx_weissbk_weis		= loadgfx("data/bk_weis.png")
	gfx_dnabonus_blau	= loadgfx("data/pickup_blue.png")
	gfx_dnabonus_gruen	= loadgfx("data/pickup_green.png")
	gfx_dnabonus_rot	= loadgfx("data/pickup_red.png")
	gfx_dnabonus_weis	= loadgfx("data/pickup_yellow.png")
	
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
	gfx_pill_blue			= loadgfx("data/pill_blue.png")
	gfx_pill_green			= loadgfx("data/pill_green.png")
	gfx_pill_red			= loadgfx("data/pill_red.png")
	gfx_pill_white			= loadgfx("data/pill_white.png")
	gfx_startscreen		= loadgfx("data/screen.png")
	gfx_gameover			= loadgfx("data/gameover.png")
	gfx_pause				= loadgfx("data/pause.png")
	
    snd_background = love.audio.newSource("data/background.mp3")
    snd_background:setLooping(true)
    snd_background:setVolume(0.5)
	 love.audio.play(snd_background)

    snd_shoot = love.audio.newSource("data/schuss.mp3", "static")
	 snd_shoot2 = love.audio.newSource("data/schuss2.wav")
	 snd_shoot3 = love.audio.newSource("data/schuss3.wav")
	 snd_shoot4 = love.audio.newSource("data/schuss4.wav")
	 snd_shoot5 = love.audio.newSource("data/schuss5.wav")
	 snd_shoot6 = love.audio.newSource("data/schuss5.wav")

	 snd_powerup = love.audio.newSource("data/powerup.wav")
	 snd_powerup2 = love.audio.newSource("data/powerup2.wav")
	 snd_powerup3 = love.audio.newSource("data/powerup3.wav")
    snd_powerup4 = love.audio.newSource("data/powerup4.wav")

	snd_collision = love.audio.newSource("data/collision.wav")

    snd_explosion = love.audio.newSource("data/explosion.mp3")
	snd_explosion2 = love.audio.newSource("data/explosion2.wav")
	snd_explosion3 = love.audio.newSource("data/explosion3.wav")
	snd_explosion4 = love.audio.newSource("data/explosion4.wav")
	snd_explosion5 = love.audio.newSource("data/explosion5.wav")
	snd_explosion6 = love.audio.newSource("data/explosion6.wav")
	snd_explosion7 = love.audio.newSource("data/explosion7.wav")

    snd_youlose = love.audio.newSource("data/youlose.mp3")

	snd_hit = love.audio.newSource("data/hit.wav")
	snd_hit2 = love.audio.newSource("data/hit2.wav")
	
	effTitle = cBloodTitle:New(love.graphics.newImage("data/particle.png"), 0, 0, 270)
	
	love.graphics.setBackgroundColor( 40,0,0)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	gPlayer = cPlayer:New(w/2,h/2)

	gShots = {}
	gLevel = cLevel:New()

    gSpawner = cSpawner:New()

    gFormationsHistory = {}

    gHighscores = cHighscores:New()

	gShootNext = -1
    gGameState = "titlescreen"
    gStateChangeTime = cTStateChange

    gFontTitle = love.graphics.newFont(30)
    gFontNormal = love.graphics.newFont(15)
    gInitials = ""

end

function play_sound(sound)
	love.audio.rewind(sound)
	love.audio.play(sound)
end

function love.update (dt)
	effTitle:Update(dt)
	if gGameState ~= "game" then 
		gStateChangeTime = gStateChangeTime - dt
	else
		UpdateStretches(dt)
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

		if (gPlayer:IsDead() == true) then
			gGameState = "gameover"
            love.audio.stop(snd_background)
            love.audio.play(snd_youlose)

			gStateChangeTime = cTStateChange
		end

	end
end

function resetgame()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	gPlayer = cPlayer:New(w/2,h/2)

	gShots = {}
	gLevel = cLevel:New()

   gSpawner = cSpawner:New()

   gFormationsHistory = {}
	gEnemies = {}
end

function draw_game ()
	gMyTime = love.timer.getTime( )
	
	gLevel:DrawBack()
	
--	gBoss:Draw()
	effects:DrawBelow()
	gPlayer:Draw()

	Shots_Draw()
	Enemies_Draw()
	effects:DrawAbove()
	
	--~ love.graphics.print("hello world",40,40)
	
	gLevel:Draw()
	
	DrawStretches()
	-- draw life line
	for i = 0, gPlayer.energy, 20 do
		local gfx
		if gPlayer.wType == "red" then gfx = gfx_pill_red
		elseif gPlayer.wType == "blue" then gfx = gfx_pill_blue
		elseif gPlayer.wType == "green" then gfx = gfx_pill_green
		elseif gPlayer.wType == "white" then gfx = gfx_pill_white
		end
		gfx:Draw(250 + i/2, gfx.oy,0,1,1)
	end

	-- draw score
	love.graphics.setFont(gFontNormal)
	love.graphics.print(gPlayer:GetPoints(), 50, 50)
	
	-- draw controls :
	local txt = "move: w-a-s-d   shoot:click left, or hold right"
	txt = txt.."\n".."enemies of the same color will resist, collect colored mutagens to change your attack"
	txt = txt.."\n".."in boss fights kill the tentacles protecting a core cells first"
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	love.graphics.print(txt, 10, h-20*3)
end

function draw_title_screen()
	local img = gfx_titlescreen.img
	local iw = img:getWidth()
	local ih = img:getHeight()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	local s = min(w / iw,h / ih)
	gfx_titlescreen:DrawX0Y0(0, h/2-ih*s/2, 0, s,s)
end

function draw_start_screen()
	gfx_startscreen:DrawX0Y0(0, 0)
	effTitle:Draw()
end

function draw_gameover_screen()
	gfx_gameover:DrawX0Y0(0, 0)
	effTitle:Draw()
    if (gHighscores:serverAvailable() == true) then
        love.graphics.setFont(gFontTitle)
        love.graphics.print("Enter initials: " .. gInitials, 10,20)
    end


end

function draw_pause_screen()
	gfx_pause:DrawX0Y0(0, 0)
end

--~ gGameFinished = true
function love.draw ()
	if gGameState == "titlescreen" then draw_title_screen()
	elseif gGameState == "startscreen" then draw_start_screen()
	elseif gGameState == "gameover" then draw_gameover_screen()
	elseif gGameState == "game" then draw_game() 
	elseif gGameState == "pause" then draw_pause_screen()
    elseif gGameState == "highscores" then gHighscores:draw()
	end
	
	if (gGameFinished) then 
		local txt = "!!! GAME OVER, YOU WON !!!"
		local w = love.graphics.getWidth()
		local h = love.graphics.getHeight()
		
		--~ local x = w/2 - w/8
		local x = 40
		local y = h/2
		local s = 5
		love.graphics.print( txt, x, y, 0, s, s)

		--~ love.graphics.print()
		--~ local limit = 400
		--~ love.graphics.printf( txt, w/2, h/2, limit, "center" )
	end
end

function love.keypressed (keyname, unicode)
	if (keyname == "escape") then love.event.quit( ) end
	if gGameState == "game" then
        if (keyname == "left"	or keyname == "a") then gPlayer:SetSpeedX(-gPlayerSpeed)
		elseif (keyname == "left"	or keyname == "a") then gPlayer:SetSpeedX(-gPlayerSpeed)
		elseif (keyname == "right"	or keyname == "d") then gPlayer:SetSpeedX(gPlayerSpeed)
		elseif (keyname == "up"		or keyname == "w") then gPlayer:SetSpeedY(-gPlayerSpeed)
		elseif (keyname == "down"	or keyname == "s") then gPlayer:SetSpeedY(gPlayerSpeed)
		elseif (keyname == "1") then gLevel.gfx_wall = gfx_wallA
		elseif (keyname == "2") then gLevel.gfx_wall = gfx_wallB
		elseif (keyname == "5") then TestBossSpawn(cEnemyBoss01)
		elseif (keyname == "6") then TestBossSpawn(cEnemyBoss02)
		elseif (keyname == "7") then TestBossSpawn(cEnemyBossFinal)
		elseif (keyname == "f3") then gPlayer:UpdateWeapon("red")
		elseif (keyname == "f4") then gPlayer:UpdateWeapon("green")
		elseif (keyname == "f5") then gPlayer:UpdateWeapon("blue")
		elseif (keyname == "f6") then gPlayer:UpdateWeapon("white")
		elseif (keyname == "o") then SHOW_DEBUG_CIRCLE = not SHOW_DEBUG_CIRCLE 	elseif (keyname == " ") then gShootNext = 0
	        elseif (keyname == " ") then gShootNext = 0
		else print("keypress",keyname)
		end
	elseif gGameState == "gameover" and gHighscores:serverAvailable() then
        	if (unicode > 31 and unicode < 127) then
            	if (gInitials:len() < 3) then
                	gInitials = gInitials .. string.char(unicode)
            	end
            	if (gInitials:len() >= 3) then
                	gHighscores:sendScore(gInitials, gPlayer:GetPoints())
            	end
        end
   	 end
end

function TestBossSpawn(bossclass)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	bossclass = bossclass or cEnemyBoss02
	bossclass:New(0.7*w,0.5*h)
end

function love.keyreleased (keyname)
	if gGameState == "titlescreen" and gStateChangeTime < 0 then
        love.audio.play(snd_background)
		gGameState = "startscreen"
		gStateChangeTime = cTStateChange
	elseif gGameState == "startscreen" and gStateChangeTime < 0 then 
		gGameState = "game"
		gStateChangeTime = cTStateChange
		resetgame()
	elseif gGameState == "gameover" and gStateChangeTime < 0  then
        if gInitials:len() >= 3 then
            gInitials = ""
            gHighscores = cHighscores:New()
            gGameState = "highscores"
            gStateChangeTime = cTStateChange
        elseif gHighscores:serverAvailable() == false then
            love.audio.play(snd_background)
            gGameState = "startscreen"
            gStateChangeTime = cTStateChange
        end
	elseif gGameState == "highscores" and gStateChangeTime < 0  then
        love.audio.play(snd_background)
        gGameState = "startscreen"
        gStateChangeTime = cTStateChange
	elseif gGameState == "pause" and gStateChangeTime < 0 then
		gGameState = "game"
		gStateChangeTime = cTStateChange
	elseif gGameState == "game" then
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
		elseif (keyname == "p" or keyname == "P") then 
			gGameState = "pause"
			gStateChangeTime = cTStateChange
		 end
	end


	--if (keyname == "left") or (keyname == "right") or (keyname == "a") or (keyname == "d") then gPlayer:SetSpeedX(0)
	--elseif (keyname == "up") or (keyname == "down") or (keyname == "w") or (keyname == "s") then gPlayer:SetSpeedY(0)
	--end
end

function love.mousereleased(x, y, button)
	if gGameState == "titlescreen" and gStateChangeTime < 0 then 
		gGameState = "startscreen"
		gStateChangeTime = cTStateChange
	elseif gGameState == "startscreen" and gStateChangeTime < 0 then 
		gGameState = "game"
		gStateChangeTime = cTStateChange
		resetgame()
	elseif gGameState == "gameover" and gStateChangeTime < 0 then 
		gGameState = "startscreen"
		gStateChangeTime = cTStateChange
	elseif gGameState == "pause" and gStateChangeTime < 0 then 
		gGameState = "game"
		gStateChangeTime = cTStateChange
	elseif gGameState == "game" then
		if (button == "l") then gPlayer:Shoot(x, y) end
		if (button == "r") then gShootNext = -1 end
	end
end

function love.mousepressed(x, y, button)
	if (button == "r") then gShootNext = 0 end
end
