function love.load()
    love.window.setMode(800, 600)
    love.graphics.setBackgroundColor(0,0,0)
    font = love.graphics.newFont("ZeFRAVE.ttf", 32)

    w_width, w_height = love.graphics.getWidth(), love.graphics.getHeight()
    
    w_p1, h_p1 = 20, 80
    x_p1, y_p1 = 0, (w_height/2)-(h_p1/2)
    
    w_p2, h_p2 = 20, 80
    x_p2, y_p2 = w_width - w_p2, (w_height/2)-(h_p2/2)
    
    w_ball, h_ball = 20, 20
    x_speed, y_speed = 250, 250
    x_ball, y_ball = (w_width/2)-20, (w_height/2)-20

    score_p1, score_p2 = 0, 0

    math.randomseed(os.time())
    start_side = math.random(0, 1)
end

function collision_player1()
    if (y_ball >= y_p1 and y_ball <= y_p1 + h_p1) and (x_ball < x_p1 + w_p1) then
        coef1 = y_ball/(y_p1 + h_p1)
        
        if y_ball > ((y_p1 + h_p1)/2) - 20 and y_ball < ((y_p1 + h_p1)/2) + 20  then
            y_speed = -(y_speed) * coef1
        elseif y_ball < ((y_p1 + h_p1)) - 20 and y_ball > (y_p1) + 20 then
            y_speed = -(y_speed) / coef1
        end
        
        x_speed = -(x_speed)
    end
end

function collision_player2()
    if (y_ball >= y_p2 and y_ball <= y_p2 + h_p2) and (x_ball > x_p2 - w_p2) then
        coef2 = y_ball/(y_p2 + h_p2)

        if y_ball > ((y_p2 + h_p2)/2) - 20 and y_ball < ((y_p2 + h_p2)/2) + 20  then
            y_speed = -(y_speed) * coef2
        elseif y_ball < ((y_p2 + h_p2)) - 20 and y_ball > (y_p2) + 20 then
            y_speed = -(y_speed) / coef2
        end

        x_speed = -(x_speed)
    end
end

function reset()
    x_p1, y_p1 = 0, (w_height/2)-(h_p1/2)

    x_p2, y_p2 = w_width - w_p2, (w_height/2)-(h_p2/2)
    
    x_ball, y_ball = (w_width/2)-20, (w_height/2)-20

    x_speed, y_speed = 250, 250
end

function ball_physics(dt, start_side)

    --definindo o movimento inicial da bola
    if start_side == 0 then
        x_ball = x_ball + x_speed * dt
        y_ball = y_ball + y_speed * dt
    else
        x_ball = x_ball - x_speed * dt
        y_ball = y_ball - y_speed * dt
    end

    --verificando colisao com as paredes
    if y_ball > w_height - h_ball or y_ball < 0 then
        y_speed = -(y_speed)
    end

    --contando pontos
    if x_ball <= 0 then
        score_p2 = score_p2 + 1
        start_side = 1
        reset()
    elseif x_ball >= w_width then
        score_p1 = score_p1 + 1
        start_side = 0
        reset()
    end
    
    collision_player1()
    collision_player2()
end

function love.update(dt)
    if love.keyboard.isDown("down") and y_p1 < w_height - h_p1 then
        y_p1 = y_p1 + 500 * dt
    elseif love.keyboard.isDown("up") and y_p1 > 0 then
        y_p1 = y_p1 - 500 * dt
    end

    if love.keyboard.isDown("s") and y_p2 < w_height - h_p2 then
        y_p2 = y_p2 + 500 * dt
    elseif love.keyboard.isDown("w") and y_p2 > 0 then
        y_p2 = y_p2 - 500 * dt
    end

    ball_physics(dt, start_side)
end

function love.draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(score_p1 .."  ".. score_p2, font, w_width/2, 10)
    love.graphics.rectangle("fill", x_p1, y_p1, w_p1, h_p1)
    love.graphics.rectangle("fill", x_p2, y_p2, w_p2, h_p2)
    love.graphics.rectangle("fill", x_ball, y_ball, w_ball, h_ball)

end