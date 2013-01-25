sin = math.sin
PI = math.pi

gMyTime = love.timer.getTime( )
	
love.filesystem.load("lib.oop.lua")()
love.filesystem.load("lib.util.lua")()
love.filesystem.load("obj.base.lua")()
love.filesystem.load("obj.player.lua")()

function loadgfx (path)
	local img = love.graphics.newImage(path)
	local w = img:getWidth()
	local h = img:getHeight()
	return {img=img,ox=w/2,oy=h/2}
end

function love.load ()
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
	
	love.graphics.setBackgroundColor( 40,0,0)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	gPlayer = cPlayer:New(w/2,h/2)
end

function love.update (dt)
	gMyTime = love.timer.getTime( )
	gPlayer:Update(dt)
end

function love.draw ()
	gMyTime = love.timer.getTime( )
	
	gPlayer:Draw()
	
	love.graphics.print("hello world",40,40)
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) 
	elseif (keyname == "left") then gPlayer:SetSpeedX(-2)
	elseif (keyname == "right") then gPlayer:SetSpeedX(2)
	elseif (keyname == "up") then gPlayer:SetSpeedY(-2)
	elseif (keyname == "down") then gPlayer:SetSpeedY(2)
	else print("keypress",keyname)
	end
end

function love.keyreleased (keyname)
	if (keyname == "left") or (keyname == "right") then gPlayer:SetSpeedX(0)
	elseif (keyname == "up") or (keyname == "down") then gPlayer:SetSpeedY(0)
	end
end
