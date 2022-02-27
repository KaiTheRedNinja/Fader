GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:enter()
end

function GameOverState:exit()
end

function GameOverState:update(dt)
    -- print(#love.keyboard.keysPressed)
    if (love.keyboard.wasPressed("space") or
        love.keyboard.wasPressed("return") or
        love.keyboard.wasPressed("enter") or
        love.mouse.wasPressed(1)
    ) then
        gStateMachine:change('interface')
    end
end

function GameOverState:render()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setFont(gFonts['giant'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("GAME OVER!!!", 10, 400, VIRTUAL_WIDTH-20, "center")
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Press space/enter/return or click to restart", 10, 600, VIRTUAL_WIDTH-20, "center")
end
