health = Class()

function health:draw()
    if player.hp == 10 then
        love.graphics.draw(playerhealth, 300, -510)
        love.graphics.draw(playerhealth, 265, -510)
        love.graphics.draw(playerhealth, 230, -510)
        love.graphics.draw(playerhealth, 195, -510)
        love.graphics.draw(playerhealth, 160, -510)
        love.graphics.draw(playerhealth, 125, -510)
        love.graphics.draw(playerhealth, 90, -510)
        love.graphics.draw(playerhealth, 55, -510)
        love.graphics.draw(playerhealth, 20, -510)
        love.graphics.draw(playerhealth, -15, -510)
    end
    if player.hp == 8 then
        love.graphics.draw(playerhealth, 230, -510)
        love.graphics.draw(playerhealth, 195, -510)
        love.graphics.draw(playerhealth, 160, -510)
        love.graphics.draw(playerhealth, 125, -510)
        love.graphics.draw(playerhealth, 90, -510)
        love.graphics.draw(playerhealth, 55, -510)
        love.graphics.draw(playerhealth, 20, -510)
        love.graphics.draw(playerhealth, -15, -510)
    end
    if player.hp == 6 then
        love.graphics.draw(playerhealth, 160, -510)
        love.graphics.draw(playerhealth, 125, -510)
        love.graphics.draw(playerhealth, 90, -510)
        love.graphics.draw(playerhealth, 55, -510)
        love.graphics.draw(playerhealth, 20, -510)
        love.graphics.draw(playerhealth, -15, -510)
    end
    if player.hp == 4 then
        love.graphics.draw(playerhealth, 90, -510)
        love.graphics.draw(playerhealth, 55, -510)
        love.graphics.draw(playerhealth, 20, -510)
        love.graphics.draw(playerhealth, -15, -510)
    end
    if player.hp == 2 then
        love.graphics.draw(playerhealth, 20, -510)
        love.graphics.draw(playerhealth, -15, -510)
    end
end 