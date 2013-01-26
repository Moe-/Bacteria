cShot = CreateClass(cBase)

function cShot:Init(x, y, dirX, dirY, lifetime, sType, colour)
	self.x = x
	self.y = y
	self.dirX = dirX
	self.dirY = dirY
	self.lifetime = lifetime
	self.sType = sType
	self.colour = colour
	if(sType == "player") then
		self.gfx = gfx_shotplayer
	else
		self.gfx = gfx_shotweiss
    end
    love.audio.play(snd_shoot)
end

function cShot:Update(dt)
	self.lifetime = self.lifetime - dt
	if (self.lifetime < 0) then return false end
	self.x = self.x + self.dirX * dt * 1000
	self.y = self.y + self.dirY * dt * 1000
	
	if self.sType == "player" then
		effects:CreateEffect("trail_blue", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
	else
		effects:CreateEffect("trail_white", self.x, self.y, math.atan(self.dirY/self.dirX)*180/PI, false)
	end
	
	return true
end

function cShot:Draw()
	love.graphics.draw(self.gfx.img,self.x,self.y,0,1,1,self.gfx.ox,self.gfx.oy)
end

