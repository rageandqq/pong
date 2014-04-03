--[[
game states: pregame, game
]]

function love.load()
	radius =10
	moveX = 5
	moveY = 5
	love.graphics.setNewFont (18)
	love.graphics.setColor (255,255,255)
	love.graphics.setBackgroundColor (45,18,224)
	paddleWidth = 20
	paddleHeight = 100
	player1X = 0
	player1Y = 0
	player2X = love.window.getWidth()-paddleWidth
	player2Y = love.window.getHeight()-paddleHeight-1
	ballX = love.window.getWidth()/2
	ballY = love.window.getHeight()/2
	z = math.random (1,2)
	ballXDir = (z==1) or false
	z = math.random (1,2)
	ballyDir = (z==1) or false
	playerSpeed = 10
	game_state = "pregame"
	timer = 0
	countdown = 3
	blip = love.audio.newSource("beep.wav", "static")
end

function love.draw()
	love.graphics.setNewFont (18)
	love.graphics.rectangle ("fill", player1X, player1Y, paddleWidth, paddleHeight)
	love.graphics.print ("player 1", player1X + paddleWidth, player1Y + paddleHeight/2)
	love.graphics.rectangle ("fill", player2X, player2Y, paddleWidth, paddleHeight)
	love.graphics.print ("player 2", player2X - 80, player2Y + paddleHeight/2)
	if game_state == "game" then
		love.graphics.circle ("fill", ballX, ballY, radius, 150)
	end
	love.graphics.setNewFont (28)
	if countdown > 0 then
		love.graphics.print (countdown, love.window.getWidth()/2, 20)
	end
end

function love.keypressed(k)
	if k == 'escape' then
		love.event.quit()
	end
	if k == 'w' and player1Y -1 >= 0 then
		player1Y = player1Y - 1
	end
end

function love.update (dt)
	--timer
	timer = timer + dt
	if countdown > 0 then
		if countdown - (3-math.floor(timer)) >= 1 then
			blip:play()
		end
		countdown = 3 - math.floor (timer)
	end
	--pregame timer
	if game_state == "pregame" and timer >= 3 then
		timer = 0
		game_state = "game"
		blip:play()
	end

	if game_state == "game" then
		--player 1 movement
		if love.keyboard.isDown("w") then
			if (player1Y - 10 >= 0) then
				player1Y = player1Y - playerSpeed
			else
				player1Y = 0
			end
		elseif love.keyboard.isDown ("s") then
			if player1Y +10 < love.window.getHeight()-paddleHeight then
				player1Y = player1Y + playerSpeed
			else
				player1Y = love.window.getHeight()-paddleHeight-1
			end
		end

		--player 2 movement
		if love.keyboard.isDown("up") then
			if (player2Y - 10 >= 0) then
				player2Y = player2Y - playerSpeed
			else
				player2Y = 0
			end
		elseif love.keyboard.isDown ("down") then
			if player2Y +10 < love.window.getHeight()-paddleHeight then
				player2Y = player2Y + playerSpeed
			else
				player2Y = love.window.getHeight()-paddleHeight-1
			end
		end
		
		--ball movement
		--move ball in direction required
		-- true = increase, false = decrease
		if ballXDir then
			ballX = ballX + moveX	
		else
			ballX = ballX - moveX
		end

		if ballYDir then
			ballY = ballY + moveY
		else
			ballY = ballY - moveY
		end
		--change direction if required
		if (ballXDir and ballX >= love.window.getWidth()-radius) or (not ballXDir and ballX <= radius) then
			ballXDir = not ballXDir
		end
		if (ballYDir and ballY >= love.window.getHeight()-radius) or (not ballYDir and ballY <= radius) then
			ballYDir = not ballYDir
end
	end
end
