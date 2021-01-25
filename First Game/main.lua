-- The Brave and Lost by Danila Dziarkach


-- requires everything needed
Class = require 'class'
push = require 'push'
require 'start'
require 'game'
Anima = require 'Anima'
require 'pause'
require 'health'

opening = love.audio.newSource('projectfiles/Dark-theme.mp3', 'static')
typingSound=love.audio.newSource('projectfiles/Hit_Hurt6.wav', 'static')
jumpsound = love.audio.newSource('projectfiles/Jump45.wav', 'static')
walkingsound = love.audio.newSource('projectfiles/sfx_step_grass_l.flac', 'static')
shootsound = love.audio.newSource('projectfiles/shot.wav', 'static')
zombiehitsound = love.audio.newSource('projectfiles/Laser_Shoot22.wav', 'static')
gameoversound = love.audio.newSource('projectfiles/gameover.wav', 'static')

gamestate = 'open'
player = {}
zombie = {}
zombie2 = {}
bullet = {}
playerhp = {}
score = 0
playover = true

--sets the size of game
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

background = love.graphics.newImage("projectfiles/itisthis.png")
background1 = love.graphics.newImage("projectfiles/gameback.jpg")
pausebackground = love.graphics.newImage('projectfiles/pause.png')
gameoverimg = love.graphics.newImage('projectfiles/pause - Copy.png')
playerhealth = love.graphics.newImage('projectfiles/health.png')
cloud = love.graphics.newImage('projectfiles/gamecloud.png')
cloud2 = love.graphics.newImage('projectfiles/gamecloud.png')
love.graphics.setDefaultFilter('nearest', 'nearest')

-- takes in things I press
function love.keypressed(key)
    if gamestate == 'open' then
        if key == 'space' then
            gamestate = 'game'
        end
        if key == 'escape' then
            love.event.quit()
        end
    end
    if gamestate == 'pause' then
        if key == 'p' then
            gamestate = 'game'
        elseif key == 'escape' then
            love.event.quit()
        elseif key == 'm' then
            love.event.quit("restart")
        end
    end
    if gamestate == 'game' then
        if key == 'escape' then
            gamestate = 'pause'
        end
    end
    if gamestate == 'gameover' then
        if key == 'm' then
            love.event.quit("restart")
        end
        if key == 'escape' then
            love.event.quit()
        end
    end
end

function love.load()
    alpha = 255
    alphab = 255

    bullets = {}
    
    smallfont = love.graphics.newFont('projectfiles/font.ttf', 40)
    smallfont2 = love.graphics.newFont('projectfiles/font.ttf', 30)
    bigfont = love.graphics.newFont('projectfiles/font.ttf', 80)
    vsmallfont = love.graphics.newFont('projectfiles/font.ttf', 20)
    gameoverfont = love.graphics.newFont('projectfiles/04B_30__.TTF', 90)
    keybindsfont = love.graphics.newFont('projectfiles/baby blocks.ttf', 40)
    
    -- anima is for the text to type when you press space
    typingTextAnim=Anima:init()
        

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false
    })

    love.window.setTitle('The Brave and Lost')

    typingTextAnim:newTypingAnimation('Objective: Survive',5,playTypingSound)
    -- the player x, y and other info
    game:player_init()
    -- the zombie x, y and other info
    game:zombie_init()

    game:bullet_init()

    love.keypressed()
end

function love.update(dt)
    startX = 600
    startY = 558
    -- again for the typing
    typingTextAnim:update(dt)
    if gamestate == 'game' then
        -- all the movement functions 
        game:update(dt)
        bullet_collides()
        game:spawnzombie(dt)
        game:spawnzombie2(dt)
        zombie_collides(dt)
        cloudx = cloudx + cloudspeed * 2.5 * dt
        cloud2x = cloud2x + cloudspeed * 2.5 * dt
        alpha = alpha - (dt * (255 / 5))
        if alpha < 0 then alpha = 0 end
    end
end

function love.draw()
    -- starts playing music and imports the class 'start'
    if gamestate == 'open' then
        start:opening()
        start:draw()
        opening:play()
        opening:setLooping(true)
    end
    if gamestate == 'game' then
        opening:stop()
        game:opening()
        love.graphics.setFont(vsmallfont)
        love.graphics.print('Score: ' .. tostring(score), 40, 50)
        love.graphics.setFont(smallfont)
        game:player()
        love.graphics.draw(player.img, player.x, player.y, 0, scaleX, 1, player.width / 2, player.height / 2)
        health:draw()
        for i,v in ipairs(zombie) do
            love.graphics.draw(zombie.img, v.x, v.y, 0, v.d, 1) 
        end
        for j,k in ipairs(zombie2) do
            love.graphics.draw(zombie2.img, k.x2, k.y2, 0, k.d2, 1)
        end
        love.graphics.draw(cloud, cloudx, cloudy)
        love.graphics.draw(cloud2, cloud2x, cloud2y - 35)
        if cloudx > 400 then
            cloudx = -1050
        end
        if cloud2x > 400 then
            cloud2x = -1050
        end
        love.graphics.setColor(0, 255, 0, 255)
        for i,v in ipairs(bullets) do
            love.graphics.draw(bullet.img, v.x, v.y)
        end
        mousex = love.mouse.getX()
        if mousex < player.x and love.mouse.isDown(1) then
            player.direction = 'left'
            signal = 'left'
        end
        if mousex > player.x and love.mouse.isDown(1)then
            player.direction = 'right'
            signal = 'right'
        end
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setColor(255, 255, 255, alpha)
        typingTextAnim:animationStart()
        typingTextAnim:draw(360,280)
        displayFPS()
    end
    if gamestate == 'pause' then
        typingSound:stop()
        pause:draw()
    end
    if gamestate == 'gameover' then
        if playover == true then
            gameoversound:play()
            playover = false
        end
        love.graphics.draw(gameoverimg)
        love.graphics.setFont(gameoverfont)
        love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 10, 1300, 'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf('escape to exit game', 0, VIRTUAL_HEIGHT / 2 + 350, 1300, 'center')
        love.graphics.rectangle('line', 422, 455, 162, 75)
        love.graphics.setFont(keybindsfont)
        love.graphics.printf('M', 0, VIRTUAL_HEIGHT / 2 + 250, 950, 'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf('for main menu', 0, VIRTUAL_HEIGHT / 2 + 250, 1350, 'center')
        love.graphics.printf('Score: ' .. tostring(score), 0, VIRTUAL_HEIGHT / 2 + 150, 1300, 'center')
    end
end
-- makes a sound when a character is typing
function playTypingSound(char)
	if char~=' ' then typingSound:play() end
end

function displayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(vsmallfont)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 40, 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(smallfont)
end

function love.mousepressed(x, y, button)
    if gamestate == 'game' then
        if button == 1 then
            shootsound:play()
            if signal == 'left' then
                startX = player.x - 55
                startY = player.y + 13
            end
            if signal == 'right' then
                startX = player.x + 59
                startY = player.y + 13
            end

            local mouseX = x
            local mouseY = y
    
            local angle = math.atan2((mouseY - startY), (mouseX - startX))
    
            local bulletDx = bullet.speed * math.cos(angle)
            local bulletDy = bullet.speed * math.sin(angle)
    
            table.insert(bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy})
        end
    end
end

function bullet_collides()
    for i,v in ipairs(zombie) do
        for ia,va in ipairs(bullets) do
            if v.d == 1 and va.x < v.x + 5 and va.y > v.y + 2 and va.y < 597 then
                v.hp = v.hp - 5
                table.remove(bullets, ia)
            elseif v.d == -1 and va.x > v.x - 5 and va.y > v.y + 2 and va.y < 597 then
                v.hp = v.hp - 5
                table.remove(bullets, ia)
            end
            if v.hp == 0 then
                table.remove(zombie, 1)
                score = score + 1
            end
        end
    end
    for j,k in ipairs(zombie2) do
        for ja,ka in ipairs(bullets) do
            if k.d2 == 1 and ka.x < k.x2 + 5 and ka.y > k.y2 + 2 and ka.y < 597 then
                k.hp2 = k.hp2 - 5
                table.remove(bullets, 1)
            elseif k.d2 == -1 and ka.x > k.x2 - 5 and ka.y > k.y2 + 2 and ka.y < 597 then
                k.hp2 = k.hp2 - 5
                table.remove(bullets, 1)
            end
            if k.hp2 == 0 then
                table.remove(zombie2, 1)
                score = score + 1
            end
        end
    end
end

function zombie_collides(dt)
    for i,v in ipairs(zombie) do
        if v.x < player.x + 1 and v.x > player.x - 2 then
            player.dmgtimer = player.dmgtimer + dt
            if player.dmgtimer >= player.dmgspace then
                player.hp = player.hp - 2
                player.dmgtimer = 0
            end
        end
    end
    if player.hp == 0 then
        gamestate = 'gameover'
    end
    for j,k in ipairs(zombie2) do
        if k.x2 < player.x + 1 and k.x2 > player.x - 2 then
            player.dmgtimer2 = player.dmgtimer2 + dt
            if player.dmgtimer2 >= player.dmgspace2 then
                player.hp = player.hp - 2
                player.dmgtimer2 = 0
            end
        end
    end
end
