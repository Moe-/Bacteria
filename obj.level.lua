


cLevel = CreateClass()

function cLevel:Init() 
end

function cLevel:Update(dt)
	
end

function cLevel:Draw()
	local t = gMyTime + 5
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight() 
	local gfx = gfx_levelpart01
	local stepx = 115
	
	local speed = 300
	local xoff = -math.mod(gMyTime*speed,stepx)
	
	for x = stepx/2,w+stepx,stepx do 
		gfx:Draw(xoff+x,10)
		gfx:Draw(xoff+x,h-10)
	end
end
