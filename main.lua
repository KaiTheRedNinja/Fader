love.graphics.setDefaultFilter('nearest', 'nearest')
require 'src/Dependencies'

VOLUME = 2

function love.load()
    love.graphics.setFont(gFonts['medium'])
    love.window.setTitle('Fading')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['interface'] = function() return InterfaceState() end,
        ['gameover'] = function() return GameOverState() end,
        ['levelselect'] = function() return LevelState() end
    }

    -- set music to loop and start
    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    -- level must be defined after statemachine
    require 'src/levels'

    gStateMachine:change('interface')

    for k, sound in pairs(gSounds) do
        sound:setVolume(VOLUME)
    end

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysDown = {}
    love.mouse.keysReleased = {}

    wheel = {}

    gTimeElapsed = 0
end

function love.resize(w, h)
    push:resize(w, h)
end

-- all of these until love.update are for managing keys and mouse/scroll events.
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true

    love.mouse.keysDown[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true

    love.mouse.keysDown[key] = false
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end

function love.mouse.wasDown(key)
    return love.mouse.keysDown[key]
end

function love.wheelmoved(x, y)
    wheel.x = x
    wheel.y = y
end

function love.update(dt)
    gMouseX, gMouseY = push:toGame(love.mouse.getPosition())

    Timer.update(dt)
    gTimeElapsed = gTimeElapsed+dt

    if (love.keyboard.isDown('escape') and
        (love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift'))) then
        love.event.quit()
    end

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
    wheel = {}
end

function love.draw()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:start()
    gStateMachine:render()
    push:finish()
end
