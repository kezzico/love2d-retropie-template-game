Controller = class:new()

function Controller:init(joystick)
	self.down = { }

	self.joystick = joystick
	
	self.lastButton = 0
end

function Controller:isExitDown()
	local backdown = self.down["back"]
	
	local startdown = self.down["start"]

	return backdown and startdown
end

function Controller:leftAxes()
	local tolerance = 0.1

	local x_axis = self.joystick:getAxis(1)

	local y_axis = self.joystick:getAxis(2)

	if math.abs(x_axis) < tolerance then
		x_axis = 0
	end

	if math.abs(y_axis) < tolerance then
		y_axis = 0
	end

	return {x=x_axis, y=y_axis}
end

function Controller:rightAxes()
	local tolerance = 0.1

	local x_axis = self.joystick:getAxis(3)

	local y_axis = self.joystick:getAxis(4)

	if math.abs(x_axis) < tolerance then
		x_axis = 0
	end

	if math.abs(y_axis) < tolerance then
		y_axis = 0
	end
end
