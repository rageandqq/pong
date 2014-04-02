function love.load()
	love.graphics.setNewFont (18)
	love.graphics.setColor (18,87,48)
	love.graphics.setBackgroundColor (200,201,232)
	paddleWidth = 10
	paddleHeight = 45
	player1X = 0
	player1Y = 0
	player2X = love.window.getWidth()-paddleWidth
	player2Y = love.window.getHeight()-paddleHeight
	ballX = love.window.getWidth()/2
	ballY = love.window.getHeight()/2
end