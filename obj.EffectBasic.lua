cEffectBasic = CreateClass()

function cEffectBasic:Init(sprite, x, y, direction)
	self.ps = cPartSys:New()	
	self.posx = x
	self.posy = y
	self.spr = sprite
end

function cEffectBasic:Draw()
	self.ps:Draw(self.posx+gCamShakeAddX, self.posy+gCamShakeAddY)
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