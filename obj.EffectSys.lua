cEffectSys = CreateClass()

love.filesystem.load("obj.PartSys.lua")()
love.filesystem.load("obj.EffectBasic.lua")()
love.filesystem.load("obj.Explosion.lua")()
love.filesystem.load("obj.BloodBorder.lua")()

function cEffectSys:Init()
	self.sprite = love.graphics.newImage("data/particle.png")
	self.effects = {}
end

function cEffectSys:Draw()
	for k,v in ipairs(self.effects) do
		v:Draw()
	end
end

function cEffectSys:Update(dt)
	for k,v in ipairs(self.effects) do
		v:Update(dt)
	end
	
	for k,v in ipairs(self.effects) do
		if v:isDone() then
			v:Free()
			table.remove(self.effects, k)
		end
	end
end

function cEffectSys:CreateEffect(kind, x, y)
	if kind == "explosion" then
		table.insert(self.effects, cExplosion:New(self.sprite, x, y))
	elseif kind == "bloodup" then
		table.insert(self.effects, cBloodBorder:New(self.sprite, x, y, true))
	elseif kind == "blooddown" then
		table.insert(self.effects, cBloodBorder:New(self.sprite, x, y, false))
	end
end