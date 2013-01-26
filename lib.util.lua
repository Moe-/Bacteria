
-- ***** ***** ***** ***** ***** utils


floor	= math.floor
ceil	= math.ceil
atan2	= math.atan2
sin		= math.sin
cos		= math.cos
max		= math.max
min		= math.min
abs		= math.abs
fmod	= math.fmod
function round(x) return floor(x+0.5) end

function randf () return math.random() end
function rand_in_range (vmin,vmax) return vmin+(vmax-vmin)* math.random() end

function SetCol (col) love.graphics.setColor( col[1], col[2], col[3], col[4] ) end
function MkCol (rgb,a) return { floor(rgb/0x10000), fmod(floor(rgb/0x100),256), fmod(rgb,256), a or 255 } end
function ColDark (col) return { col[1]/2, col[2]/2, col[3]/2, col[4] or 255 } end

local function RotX (x,y,ang) return x*cos(ang)-y*sin(ang) end
local function RotY (x,y,ang) return x*sin(ang)+y*cos(ang) end

function table_count (t) local c = 0 for k,v in pairs(t) do c = c + 1 end return c end
function table_empty (t) return next(t) == nil end


function TranslatePolyPoints (ox,oy,ang, x,y, ...)
	if (not x) then return end
	return RotX(x,y,ang)+ox,RotY(x,y,ang)+oy,TranslatePolyPoints(ox,oy,ang,...)
end

function copyarr(arr) local res = {} for k,v in pairs(arr) do res[k] = v end return res end

function count(arr)
    local c = 0
    for k,v in pairs(arr) do
        c = c + 1
    end
    return c
end



-- ***** ***** ***** ***** ***** tausender


function TausenderTrenner (v)
	local txt = tostring(abs(v))
	local len = #txt
	local res = ""
	for i=1,len do 
		local cpos = len-i+1
		local c = string.sub(txt,cpos,cpos)
		res = c .. res
		if ((i % 3) == 0 and i < len) then res = "," .. res end
	end
	
	
	return (v<0) and ("-"..res) or res
end
