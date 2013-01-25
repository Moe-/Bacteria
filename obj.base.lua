cBase = CreateClass()

function cBase:Init() 
	print("base init")
	self.x = 0
	self.y = 0
end


function cBase:DistToPos(x,y)
	local dx = x-self.x
	local dy = y-self.y
	return math.sqrt(dx*dx+dy*dy)
end

function cBase:DistToObj(o) return self:DistToPos(o.x,o.y) end
