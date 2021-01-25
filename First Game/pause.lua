pause = Class{}

function pause:draw()
    love.graphics.draw(pausebackground)
    love.graphics.rectangle('line', 470, 390, 130, 55)
    love.graphics.setFont(smallfont)
    love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT / 2 - 80, 1300, 'center')
    love.graphics.setFont(keybindsfont)
    love.graphics.printf('P', 0, 190, 1050, 'center')
    love.graphics.setFont(smallfont2)
    love.graphics.printf('to continue', 0, 200, 1300, 'center')
    love.graphics.printf('escape to exit game', 0, 400, 1300, 'center')
    love.graphics.setFont(keybindsfont)
    love.graphics.printf('M', 0, 290, 1050, 'center')
    love.graphics.setFont(smallfont2)
    love.graphics.printf('for main menu', 0, 300, 1350, 'center')
end