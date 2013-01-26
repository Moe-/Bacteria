cEffectSys = CreateClass()

love.filesystem.load("obj.PartSys.lua")()
love.filesystem.load("obj.EffectBasic.lua")()
love.filesystem.load("obj.EfExplosion.lua")()
love.filesystem.load("obj.EfBloodBorder.lua")()
love.filesystem.load("obj.EfPowerUp.lua")()
love.filesystem.load("obj.EfTrail.lua")()
love.filesystem.load("obj.EfSparkle.lua")()

function cEffectSys:Init()
	self.sprite = love.graphics.newImage("data/particle.png")
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
	end
end