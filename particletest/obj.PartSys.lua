cPartSys = CreateClass()

function cPartSys:Init()
	ps  = {}
end

function cPartSys:AddEmitter(e)
	table.insert(ps, e)
end

function cPartSys: