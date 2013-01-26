cShot = CreateClass(cBase)

-- ***** ***** ***** ***** ***** global shot functions

function Shots_Update(dt) for o,_ in pairs(gShots) do o:Update(dt) end end

function Shots_Draw() for o,_ in pairs(gShots) do o:Draw() end end

function Shots_HitTest()  
	for o,_ in pairs(gShots) do 
		Enemies_ShotTest(o)
		gPlayer:ShotTest(o, "white") 
	end 
end

function Shots_BlockPlayerShotsAtPos(x,y,r)
	 for o,_ in pairs(gShots) do 
		if (o.bIsPlayerShot) then
			--~ o:Update(dt)
		end
	end
end  

-- ***** ***** ***** ***** ***** cShot

function cShot:Init(x, y, dirX, dirY, lifetime, sType, colour)
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = dirY
	self.lifetime = lifetime
	self.sType = sType
	self.colour = colour
	if(sType == "player") then
		self.bIsPlayerShot = true
		self.gfx = gfx_shotplayer
	else
		self.gfx = gfx_shotweiss
    end
    love.audio.play(snd_shoot)
	
	-- register
	gShots[self] = true
end

function cShot:Destroy()
	gShots[self] = nil
end

function cShot:Update(dt)
	self.lifetime = self.lifetime - dt
	if (self.lifetime < 0) then self:Destroy() return end
	self.x = self.x + self.dirX * dt * 1000
	self.y = self.y + self.dirY * dt * 1000
	
	if self.sType == "player" then
		if self.colour == "red" then
			effects:CreateEffect("trail_red", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		elseif self.colour == "green" then
			effects:CreateEffect("trail_green", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		elseif self.colour == "blue" then
			effects:CreateEffect("trail_blue", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		elseif self.colour == "white" then
			effects:CreateEffect("trail_white", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		else -- colour type is weird
			effects:CreateEffect("trail_blue", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		end
	else
		if self.colour == "blue" then
			effects:CreateEffect("trail_blue", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		else
			effects:CreateEffect("trail_white", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
		end
	end
	
	return true
end

function cShot:Draw()
	love.graphics.draw(self.gfx.img,self.x,self.y,0,1,1,self.gfx.ox,self.gfx.oy)
end

