game = Class{}

function game:opening()
    for i = 0, love.graphics.getWidth() / background1:getWidth() do
        for j = 0, love.graphics.getHeight() / background1:getHeight() do
            love.graphics.draw(background1, i * background1:getWidth(), j * background1:getHeight())
        end
    end
end

function game:player()
    -- so the player can flip
    scaleX = 0

    if player.direction == 'right' then
        scaleX = 1
    else 
        scaleX = -1
    end
end

function game:update(dt)
    for i,v in ipairs(zombie) do
        if v.x < player.x then
            v.x = v.x + (zombie.speed * 2.5 * dt)
            v.d = 1
        end
        if v.x > player.x then
            v.x = v.x - (zombie.speed * 2.5 * dt)
            v.d = -1
        end
    end
    for j,k in ipairs(zombie2) do
        if k.x2 < player.x then
            k.x2 = k.x2 + (zombie.speed * 2.5 * dt)
            k.d2 = 1
        end
        if k.x2 > player.x then
           k.x2 = k.x2 - (zombie.speed * 2.5 * dt)
           k.d2 = -1
        end
    end

    if love.keyboard.isDown('d') then
        player.x = math.min(1280, player.x + player.speed * dt)
        player.direction = 'right'
    elseif love.keyboard.isDown('a') then
        player.x = math.max(0, player.x - player.speed * dt)
        player.direction = 'left'
    end
    if love.keyboard.isDown('w') then
        if player.y_velocity == 0 then
            player.y_velocity = player.jump_height
        end
    end

    if player.y_velocity ~= 0 then
        player.y = player.y + player.y_velocity * dt
        player.y_velocity = player.y_velocity - player.gravity * dt
    end

    if player.y > player.ground then
        player.y_velocity = 0
        player.y = player.ground
    end

    if love.keyboard.isDown('d') and player.y == 545 then
        walkingsound:play()
        walkingsound:setVolume(0.45)
    elseif love.keyboard.isDown('a') and player.y == 545 then
        walkingsound:play()
        walkingsound:setVolume(0.45)
    end

    for i,v in ipairs(bullets) do
        v.x = v.x + v.dx * dt
        v.y = v.y + (v.dy * dt)
        if v.x == 40 then
            table.remove(bullets, 1)
        end
        if v.x == 1200 then
            table.remove(bullets, 1)
        end
    end
end
-- initializes the player info
function game:player_init()
    player.x = 650
    player.y = 545
    
    player.direction = 'right'
 
	player.speed = 300
 
	player.img = love.graphics.newImage('projectfiles/character_right2.png')
 
	player.ground = player.y
 
	player.y_velocity = 0
 
	player.jump_height = -250
    player.gravity = -750
    
    player.height = 91
    player.width = 112

    player.dmg = 5
    player.hp = 10

    player.dmgtimer = 0.5
    player.dmgspace = 0.5
    player.dmgtimer2 = 0.5
    player.dmgspace2 = 0.5

    cloudx = -1000
    cloudy = -130
    cloud2x = -1600
    cloud2y = -130
    cloudspeed = 30
end

function game:zombie_init()
    zombie.img = love.graphics.newImage('projectfiles/zombie.png')
    zombie2.img = love.graphics.newImage('projectfiles/zombie.png')

    zombie.x = 110
    zombie.y = 535

    zombie.speed = 60

    zombie.dmg = 2
    zombie.hp = 10
    zombie2.dmg = 2
    zombie2.hp = 10
  
    zombie.width = 62
    zombie.heigth = 62

    zombie.direction = 'right'
    zombie.timer = 1
    zombie2.timer = 0
    zombie2.timerspace = 2
    zombie.timerspace = 2
    if score > 30 then
        zombie.timerspace = 1.5
        zombie2.timerspace = 1.5
    end
    if score > 60 then
        zombie.timerspace = 1
        zombie2.timerspace = 1
    end
    if score > 100 then
        zombie.timerspace = 0.5
        zombie2.timerspace = 0.5
    end
end

function game:bullet_init()
    bullet.img = love.graphics.newImage('projectfiles/bullet.png')

    bullet.x = 635
    bullet.y = 555
    
    bullet.speed = 600

    bullet.width = 13
    bullet.height = 5
end
function game:spawnzombie(dt, x, y, d, hp)
    if alpha == 0 then
        zombie.timer = zombie.timer + dt
        if zombie.timer >= zombie.timerspace then
            table.insert(zombie, {x = love.math.random(0, 10), y = 535, d = 1, hp = 10})
            zombie.timer = 0
        end
    end
end
function game:spawnzombie2(dt, x2, y2, d2, hp2)
    if alpha == 0 then
        zombie2.timer = zombie2.timer + dt
        if zombie2.timer >= zombie2.timerspace then
            table.insert(zombie2, {x2 = love.math.random(1300, 1350), y2 = 535, d2 = -1, hp2 = 10})
            zombie2.timer = 0
        end
    end
end
