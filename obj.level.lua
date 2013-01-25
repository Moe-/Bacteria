


cLevel = CreateClass()

function cLevel:Init() 
end

function cLevel:Update(dt)
	
end

function cLevel:Draw()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	local gfx = gfx_levelpart01
	local stepx = 112
	for x = stepx/2,w,stepx do 
		gfx:Draw(x,10)
		gfx:Draw(x,h-10)
	end
end
