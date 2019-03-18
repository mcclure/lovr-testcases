-- Demonstrate a level can be constructed from scratch
-- Expected behavior: todo

namespace "testcase"

local StencilTest = classNamed("StencilTest", Ent)

local discardShader = require("testcase/shader")

function bgColor() lovr.graphics.setBackgroundColor(0.55,0.75,0.75) end

function StencilTest:onLoad()
	bgColor(0.55,0.75,0.75)
	self.wscale = 1/3
	self.xs = 6
	self.ys = 4
	self.time = 0
end

function StencilTest:onUpdate(dt)
	dt = math.min(dt, 0.2)
	self.time = self.time + dt
end

function StencilTest:onDraw()
	lovr.graphics.setStencilTest()
	lovr.graphics.cube('fill', 0, 0, 1, 0.125) -- Draw cube at 0,0,0 for comparison

	local w, h = self.xs, self.ys

	lovr.graphics.push()

	lovr.graphics.translate(math.sin(self.time/2)/2, 0.5, 0)

	-- Set stencil area to a plane, set test to only draw in stencil area
	lovr.graphics.stencil(function()
		lovr.graphics.plane('fill', 0, 0, 0, w*self.wscale, h*self.wscale)
	end)
	lovr.graphics.setStencilTest("equal", 1)

	-- Clear screen
	lovr.graphics.setDepthTest()
	lovr.graphics.setColor(1,0,0)
	lovr.graphics.fill()
	lovr.graphics.setDepthTest('lequal', true)


	-- Draw some garbage behind the stencil. It should be larger than the stencil area
	lovr.graphics.setShader(discardShader)
	for i=0,4 do
		local color = 0.75-i/8
		lovr.graphics.setColor(color, color, color, 1)
		lovr.graphics.plane('fill', 0, 0, -0.5-i/2, w*self.wscale*4, h*self.wscale*4)
	end
	lovr.graphics.setShader(nil)

	lovr.graphics.pop()
end

return StencilTest
