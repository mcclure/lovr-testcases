-- Simple "draw some cubes" test
namespace("cubetest", "standard")

local CubeTest = classNamed("CubeTest", Ent)
local shader = require "shader/shader"
local Hand = require "app/debug/hand"

function CubeTest:onLoad(dt)
	self.time = 0
	Hand{guideline=function() return true end}:insert(self)
end

function CubeTest:onUpdate(dt)
	self.time = self.time + math.max(dt, 0.05)
end

function CubeTest:onDraw(dt)
	lovr.graphics.clear(1,1,1)

	local count, width, spacing = 5, 0.4, 2
	local LIMIT = 10 + math.floor(lovr.timer.getTime())
	local function toColor(i) return (i-1)/(count-1) end
	local function toCube(i) local span = count*spacing return -span/2 + span*toColor(i) end

	lovr.graphics.setShader(nil)
	lovr.graphics.setColor(0,0,0)
	lovr.graphics.print(LIMIT, 0, 1, -3)

	lovr.graphics.setShader(shader)

	for z=1,count do for y=1,count do for x=1,count do
		lovr.graphics.setColor(toColor(x), toColor(y), toColor(z))
		lovr.graphics.cube('fill', toCube(x),toCube(y),toCube(z), cubeWidth, self.time/8, -y, x, -z)
		lovr.graphics.flush()

		LIMIT = LIMIT - 1 -- Bail when too many drawn
		if LIMIT <= 1 then return end
	end end end
end

return CubeTest
