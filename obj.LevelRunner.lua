cLevelRunner = CreateClass()

function cLevelRunner:Init(length, bigwaves, maxscore)
	self.t = 0
	self.maxt = length
	self.bw = bigwaves
	self.dbw = length / (bigwaves + 1)
	self.msc = maxscore
	self.nextbig = self.dbw
end 

function cLevelRunner:Update(dt)
	self.t = self.t + dt
	
	if self.t >= self.maxt then
		self:End() --end the level
	elseif self.t >= self.nextbig then
		--spawn a big wave
		self.nextbig = self.nextbig + self.dbw
	end
end

function cLevelRunner:End()

end