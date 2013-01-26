cEffectSys = CreateClass()

love.filesystem.load("obj.PartSys.lua")()
love.filesystem.load("obj.EffectBasic.lua")()
love.filesystem.load("obj.Explosion.lua")()
love.filesystem.load("obj.BloodBorder.lua")()
love.filesystem.load("obj.PowerUp.lua")()
love.filesystem.load("obj.Trail.lua")()
love.filesystem.load("obj.Sparkle.lua")()
love.filesystem.load("obj.EfHit.lua")()
love.filesystem.load("obj.EfSlowTrail.lua")()

function cEffectSys:Init()
	self.sprite = love.graphics.newImage("particle.png")
	self.ef_below = {}
	self.ef_above = {}
end

function cEffectSys:DrawBelow()
	for k,v in ipairs(self.ef_below) do
		v:Draw()
	end
end

function cEffectSys:DrawAbove()
	for k,v in ipairs(self.ef_above) do
		v:Draw()
	end
end

function cEffectSys:Update(dt)
	for k,v in ipairs(self.ef_below) do
		v:Update(dt)
	end
	
	for k,v in ipairs(self.ef_below) do
		if v:isDone() then
			v:Free()
			table.remove(self.ef_below, k)
		end
	end
	
	for k,v in ipairs(self.ef_above) do
		v:Update(dt)
	end
	
	for k,v in ipairs(self.ef_above) do
		if v:isDone() then
			v:Free()
			table.remove(self.ef_above, k)
		end
	end
end

function cEffectSys:CreateEffect(kind, x, y, direction, above)
	if kind == "explosion" then
		if above then table.insert(self.ef_above, cExplosion:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cExplosion:New(self.sprite, x, y, direction)) end
	elseif kind == "bloodborder" then
		if above then table.insert(self.ef_above, cBloodBorder:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cBloodBorder:New(self.sprite, x, y, direction)) end
	elseif kind == "powerup" then
		if above then table.insert(self.ef_above, cPowerUp:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cPowerUp:New(self.sprite, x, y, direction)) end
	elseif kind == "trail" then
		if above then table.insert(self.ef_above, cTrail:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cTrail:New(self.sprite, x, y, direction)) end
	elseif kind == "sparkle" then
		if above then table.insert(self.ef_above, cSparkle:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cSparkle:New(self.sprite, x, y, direction)) end
	elseif kind == "hit" then
		if above then table.insert(self.ef_above, cHit:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cHit:New(self.sprite, x, y, direction)) end
	elseif kind == "slowtrail" then
		if above then table.insert(self.ef_above, cSlowTrail:New(self.sprite, x, y, direction))
		else table.insert(self.ef_below, cSlowTrail:New(self.sprite, x, y, direction)) end
	end
end