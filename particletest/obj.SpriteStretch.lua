cStretch = CreateClass()

stretches = {}

function cStretch:Init(spr, x, y, rot, mins, maxs)
	self.min = mins--0.1
	self.max = maxs--1.5
	self.growtime = 0.25
	self.fadetime = 1
	self.alpha = 160
	self.sprite = spr
	self.xpos = x
	self.ypos = y
	self.angl = rot
	
	stretches[self] = true
	
	self.dscale = (self.max - self.min) / self.growtime
	self.dfade = self.alpha / self.fadetime
	
	self.cscale = self.min
	self.calpha = self.alpha
end

function cStretch:Update(dt)
	if self.cscale < self.max then
		self.cscale = self.cscale + self.dscale * dt
	elseif self.calpha > 0 then
		self.calpha = self.calpha - self.dfade * dt
	else
		self.calpha = 0
		stretches[self] = nil
	end
end

function cStretch:Draw()
	if self.calpha > 0 then
		love.graphics.setColor(255, 255, 255, self.calpha)
		love.graphics.draw(self.sprite, self.xpos - self.sprite:getWidth() / 2 * self.cscale, self.ypos - self.sprite:getHeight() / 2 * self.cscale, self.angl, self.cscale, self.cscale)
		love.graphics.setColor(255, 255, 255, 255)
	end
end

function DrawStretches()
	for o,_ in pairs(stretches) do 
		o:Draw()
	end 
end

function UpdateStretches(dt)
	for o,_ in pairs(stretches) do 
		o:Update(dt)
	end 
end