local players = { }

local music = nil

local font = nil

function love.load()
	require 'utils'

	require 'class'

	require 'controller'

	require 'player'

	font = love.graphics.newFont("fonts/joystix.ttf", 25)

	love.graphics.setFont(font)

--	music = love.audio.newSource("sounds/mario-overworld.ogg", "stream")

--	music:setLooping(true)

--	love.audio.play(music)
end

-- Player connected a controller/joystick. Do something useful with it
function love.joystickadded(joystick)
	local jid = joystick:getID()
	
	local controller = Controller:new(joystick)

  -- if no player owns this joystick. 
	if not players[jid] then
		-- add a new player object to players
		local name = "Player "..jid

		local player = Player:new(controller, name)

		table.insert(players, jid, player)
		-- assign a color to each player
		--	if jid == 1 then
		--		player.color = { r=1, g=0, b=0 }
		--	end
		--	if jid == 2 then
		--		player.color = { r=0, g=1, b=0 }
		--	end

	-- if a player should own the joystick. not sure if this ever happens? 
	-- (maybe the other joystick ran out of batteries?).
	else
		-- assign the newly connected joystick object to the player
		players[jid].controller = controller

	end
end

-- A joystick/controller disconnected, ran out of battery, lost signal, exploded...
function love.joystickremoved(joystick)
	local jid = joystick:getID()

  -- remove the player connected to the joystick from the game
	table.remove(players, jid)
end

function love.gamepadpressed(joystick, button)
	local player = players[joystick:getID()]

	player.controller.down[button] = true
end

function love.gamepadreleased(joystick, button)
	local player = players[joystick:getID()]

	player.controller.down[button] = false
end

function love.draw()
	local screenWidth = love.graphics.getWidth( )
	local screenHeight = love.graphics.getHeight( )

	love.graphics.clear( 91/255, 151/255, 243/255, 1.0)

	-- if there are no players
	if #players == 0 then
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.printf(
			"TEMPLATE GAME", 
			0, screenHeight / 2.0, 
			screenWidth, "center")

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.printf(
			"connect controllers to start", 
			0, screenHeight / 2.0 + 60, 
			screenWidth, "center")
			
	end

	-- draw each player
	for jid, player in next, players do 
		local text1 = player.name
		local text2 = "position.x:"..player.position.x.." position.y:"..player.position.y

		love.graphics.setColor(player.color.r, player.color.g, player.color.b, 1)
		love.graphics.print(text1, 20, jid * 40 + 0)
		love.graphics.print(text2, 20, jid * 40 + 20)

	end
end

function love.update(dt)
  -- loop for every player connected.
	for jid, player in next, players do 

		if player.controller.joystick:isGamepadDown("dpleft") then
			player.position.x = player.position.x-1
		end

		if player.controller.joystick:isGamepadDown("dpright") then
			player.position.x = player.position.x+1
		end
	
		if player.controller.joystick:isGamepadDown("dpup") then
			player.position.y = player.position.y+1
		end

		if player.controller.joystick:isGamepadDown("dpdown") then
			player.position.y = player.position.y-1
		end

		-- if exit button combo is pressed. see controller.lua
		if player.controller:isExitDown() then
			love.event.quit()
		end
	end
end
