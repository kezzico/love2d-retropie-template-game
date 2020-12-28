Player = class:new()

function Player:init(controller, name)
	self.name = name

	self.controller = controller

	self.cursor = { x=0, y=0 }

	self.position = { x=0, y=0 }

	self.color = { r=1, g=1, b=1 }
end
