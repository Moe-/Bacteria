cPartSys = CreateClass()

function cPartSys:Init()
	self.ps  = {}
	self.ts = {}
	self.act = {}
	self.t = 0
	self.started = false
	self.biggest = 0
end

function cPartSys:AddEmitter(e, dt)
	if not self.started then
		table.insert(self.ps, e)
		table.insert(self.ts, dt)
		table.insert(self.act, false)
		if self.biggest < dt then
			self.biggest = dt
		end
	end
end

function cPartSys:Draw(x, y)
	for k,v in ipairs(self.ps) do
		love.graphics.draw(v, x+gCamShakeAddX, y+gCamShakeAddY)
	end
end

function cPartSys:Update(dt)
	if self.started then
		if self.t < self.biggest then
			self.t = self.t + dt
		end
		for k,v in ipairs(self.ps) do	
			if self.ts[k] <= self.t and not self.act[k] then
				--~ print("starting emitter", k)
				v:start()
				self.act[k] = true
			end
			
			if self.act[k] then
				v:update(dt)
			end
			
			if v:isEmpty() and not v:isActive() then
				v:stop()
			end
		end
	end
end

function cPartSys:Start()
	self.started = true
end

function cPartSys:Stop()
	for k,v in ipairs(self.ps) do
		v:stop()
	end
end

function cPartSys:Reset()
	self.started = false
	self.t = 0
	for k,v in ipairs(self.ps) do
		v:reset()
		self.act[k] = false
	end
end

function cPartSys:isDone()
	local active = false
	for k,v in ipairs(self.ps) do
		if not v:isEmpty() or v:isActive() then
			active = true
		end
	end
	return not active
end