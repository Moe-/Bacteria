

function love.load ()
end

function love.draw ()

	love.graphics.print("hello world",40,40)
end

function love.keypressed (keyname)
	if (keyname == "escape") then love.event.quit( ) end
	print("keypress",keyname)
end
