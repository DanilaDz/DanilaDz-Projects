start = Class{}

-- this sets the background to an image and then writes text above it
function start:opening()
    for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end
end

function start:draw()
    love.graphics.setFont(bigfont)
    love.graphics.printf('The Brave and Lost', 0, VIRTUAL_HEIGHT / 2 - 80, 1300, 'center')
    love.graphics.setFont(smallfont)
    if math.floor(love.timer.getTime()) % 2 == 0 then
        love.graphics.printf('press space to play', 0, VIRTUAL_HEIGHT + 50, 1300, 'center')
    end
end
