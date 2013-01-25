sin = math.sin
PI = math.pi

function loadgfx (path)
	local img = love.graphics.newImage(path)
	local w = img:getWidth()
	local h = img:getHeight()
	return {img=img,ox=w/2,oy=h/2}
end
function love.load ()
	
	gfx_blutplatt	= loadgfx("data/blutplatt.png")
	gfx_dnabonus	= loadgfx("data/dnabonus.png")
	gfx_levelpart01	= loadgfx("data/levelpart01.png")
	gfx_player		= loadgfx("data/player.png")
	gfx_rotbk		= loadgfx("data/rotbk.png")
	gfx_shotplayer	= loadgfx("data/shot-player.png")
	gfx_shotweiss	= loadgfx("data/shot-weiss.png")
	gfx_weissbk		= loadgfx("data/weissbk.png")
	
	love.graphics.setBackgroundColor( 40,0,0)
end

function love.draw ()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	local t = love.timer.getTime( )
	
	local s = 1.0 + 0.2 * sin(t*PI)
	local r = PI * 0.1 * sin(t*0.9*PI)
	local gfx = gfx_player love.graphics.draw(gfx.img,w/2,h/2,r,s,s,gfx.ox,gfx.oy)

	love.graphics.print("hello world",40,40)
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
	print("keypress",keyname)
end
