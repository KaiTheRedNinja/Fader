LevelState = Class{__includes = BaseState}

function LevelState:init()
end

function LevelState:enter()
end

function LevelState:exit()
end

function LevelState:update(dt)
    -- check if any level pressed
    for i = 0, 3 do
        for j = 0, 2 do
            -- check for clicks
            local thisBox = {
                x = VIRTUAL_WIDTH/2-320+i*160+30,
                y = 520+j*160+30,
                width = 100,
                height = 100
            }

            if not (thisBox.x > gMouseX or gMouseX > thisBox.x + thisBox.width or
                    thisBox.y > gMouseY or gMouseY > thisBox.y + thisBox.height
            ) and love.mouse.wasPressed(1) then
                thisLevel = j*4+i+1
                -- check if its an actual level
                if (thisLevel <= #gLevels) then
                    -- switch to that level
                    gSounds['place-success']:play()
                    gLevelNum = thisLevel
                    gStateMachine:change('interface')
                else
                    -- error
                    gSounds['place-error']:play()
                end
            end
        end
    end

    -- preferences
    local j = 4
    local purposes = {'cancel', 'music', 'audio', 'quit'}
    for i = 0, 3 do
        -- check for clicks
        local thisBox = {
            x = VIRTUAL_WIDTH/2-320+i*160+30,
            y = 520+j*160+30,
            width = 100,
            height = 100
        }

        if not (thisBox.x > gMouseX or gMouseX > thisBox.x + thisBox.width or
                thisBox.y > gMouseY or gMouseY > thisBox.y + thisBox.height
        ) and love.mouse.wasPressed(1) then
            -- check purpose
            if purposes[i+1] == 'cancel' then
                gStateMachine:change('interface')
            elseif purposes[i+1] == 'music' then
                if not gMusicVol then
                    gSounds['music']:setVolume(VOLUME)
                    gMusicVol = true
                else
                    gSounds['music']:setVolume(0)
                    gMusicVol = false
                end
            elseif purposes[i+1] == 'audio' then
                if gAudioVol then
                    for k, sound in pairs(gSounds) do
                        sound:setVolume(0)
                    end
                    if gMusicVol then
                        gSounds['music']:setVolume(VOLUME)
                    end
                    gAudioVol = false
                else
                    for k, sound in pairs(gSounds) do
                        sound:setVolume(VOLUME)
                    end
                    if not gMusicVol then
                        gSounds['music']:setVolume(0)
                    end
                    gAudioVol = true
                end
            elseif purposes[i+1] == 'quit' then
                love.event.quit()
            end
        end
    end
end

function LevelState:render()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setFont(gFonts['giant'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("select a level", 10, 10, VIRTUAL_WIDTH-20, "center")
    love.graphics.setFont(gFonts['large'])

    -- draw background
    love.graphics.setColor(0, 0, 0, 1*0.5)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-320, 520, 640, 480)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', VIRTUAL_WIDTH/2-320, 520, 640, 480)

    -- draw levels
    for i = 0, 3 do
        for j = 0, 2 do
            local thisLevel = j*4+i+1
            if thisLevel == gLevelNum then love.graphics.setColor(0, 1, 0, 0.5)
            elseif thisLevel < gLevelNum then love.graphics.setColor(1, 1, 0, 0.5)
            elseif thisLevel <= #gLevels then love.graphics.setColor(1, 1, 1, 0.5)
            else love.graphics.setColor(0, 0, 0, 0.5) end
            love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
            if thisLevel == gLevelNum then love.graphics.setColor(0, 1, 0, 0.5)
            elseif thisLevel < gLevelNum then love.graphics.setColor(1, 1, 0, 1)
            elseif thisLevel <= #gLevels then love.graphics.setColor(1, 1, 1, 1)
            else love.graphics.setColor(0, 0, 0, 1) end
            love.graphics.rectangle('line', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
            if thisLevel <= #gLevels then
                love.graphics.setColor(0, 0, 0, 1)
                love.graphics.printf(thisLevel, VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+40, 100, 'center')
            end
        end
    end

    local j = 4
    for i = 0, 3 do
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.rectangle('line', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
        love.graphics.setFont(gFonts['medium'])
        if i == 0 then
            love.graphics.printf("esc", VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+60, 100, 'center')
        elseif i == 1 then
            if gMusicVol then
                love.graphics.setColor(0, 1, 0, 0.5)
                love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
            end
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.printf("music", VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+60, 100, 'center')
        elseif i == 2 then
            if gAudioVol then
                love.graphics.setColor(0, 1, 0, 0.5)
                love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
            end
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.printf("audio", VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+60, 100, 'center')
        elseif i == 3 then
            love.graphics.setColor(1, 0, 0, 0.5)
            love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+30, 100, 100)
            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.printf("quit", VIRTUAL_WIDTH/2-320+i*160+30, 520+j*160+60, 100, 'center')
        end
    end
end
