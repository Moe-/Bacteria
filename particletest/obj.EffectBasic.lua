cEffectBasic = CreateClass()

function cEffectBasic:Init(x, y, up)
	self.ps = cPartSys:New()	
	self.posx = x
	self.posy = y
end

function cEffectBasic:Draw()
	self.ps:Draw(self.posx, self.posy)
end

function cEffectBasic:Update(dt)
	self.ps:Update(dt)
end

function cEffectBasic:isDone()
	return self.ps:isDone()
end

function cEffectBasic:Free()
	self.ps:Stop()
	self.ps:Reset()
end