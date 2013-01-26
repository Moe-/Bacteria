cHighscores = CreateClass()

function cHighscores:Init()
	self.enemy_kind = "base"
    self.boolServerAvailable = true
    self.address = "ec2-54-246-10-94.eu-west-1.compute.amazonaws.com"
    self.port = 80

    local socket = require "socket"

    local udp = socket.udp()
    udp:settimeout(2)
    udp:setpeername(self.address, self.port)
    udp :send("getScores()")

    data, msg = udp:receive()
    if data then
        self.ranks = {}
        data:gsub("([^&]*)&", function (c)
                                local r,n,s = c:match("([^|]*)|([^|]*)|([^|]*)")
                                table.insert (self.ranks,{r,n,s})
                              end)
    else --data = nil
        print "Server nicht da"
        self.boolServerAvailable = false
    end

end

function cHighscores:serverAvailable()
    return self.boolServerAvailable
end

function cHighscores:draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(gFontTitle)
    love.graphics.printf("Highscores",0, 50, w, "center")

    local rh = 50
    local roy = 100
    local rox = 20
    local r = 1
    local cw = math.floor((w)/3)

    if (self.ranks) then
        for k,v in pairs(self.ranks) do
            love.graphics.setFont(gFontTitle)

            love.graphics.printf(v[1],rox + cw * 0, r*rh + roy, cw * 1, "left")
            love.graphics.printf(v[2],rox + cw * 1, r*rh + roy, cw * 2, "left")
            love.graphics.printf(v[3],rox + cw * 2, r*rh + roy, cw * 3, "left")
            r = r + 1
        end
    end

end
function cHighscores:sendScore(name, score)
    local socket = require "socket"

    local udp = socket.udp()
    udp:setpeername(self.address, self.port)
    udp:send("sendScore(\"" .. name .. "\"," .. score .. ")")
end

