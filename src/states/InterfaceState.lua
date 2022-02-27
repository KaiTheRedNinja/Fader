InterfaceState = Class{__includes = BaseState}

function InterfaceState:init()
    gInterface = self
    self.levelObjects = {} -- these are not breakable
    self.objects = {} -- these are breakable/placed by the player
    self.border = {} -- these are the borders

    self.highlight = TextBox({
        x = gMouseX,
        y = gMouseY,
        width = 0,
        height = 0,
        data = {InterfaceState = self, g = 1, alwaysOn = true}
    })
    self.menu = Rectangle({
        x = VIRTUAL_WIDTH-120,
        y = VIRTUAL_HEIGHT-120,
        width = 100,
        height = 100,
        data = {collidable = false}
    })

    self.levelname = ""

    self.leveldata = {}
end

function InterfaceState:loadLevel(levelnum)
    self.levelObjects = {}
    self.objects = {}
    self.border = {}

    -- rectangles all around the field
    table.insert(self.border, Rectangle({x = 0, y = 0, width = VIRTUAL_WIDTH, height = 5, data = {InterfaceState = self, r = 1, shadow=false}})) -- top
    table.insert(self.border, Rectangle({x = 0, y = 0, width = 5, height = VIRTUAL_HEIGHT, data = {InterfaceState = self, r = 1, shadow=false}})) -- left
    table.insert(self.border, Rectangle({x = 0, y = VIRTUAL_HEIGHT-5, width = VIRTUAL_WIDTH, height = 5, data = {InterfaceState = self, r = 1, shadow=false}})) -- bottom
    table.insert(self.border, Rectangle({x = VIRTUAL_WIDTH-5, y = 0, width = 5, height = VIRTUAL_HEIGHT, data = {InterfaceState = self, r = 1, shadow=false}})) -- right

    table.insert(self.levelObjects, Rectangle({x = 0, y = 0, width = VIRTUAL_WIDTH, height = 3, data = {InterfaceState = self, r = 1, shadow=false}})) -- top
    table.insert(self.levelObjects, Rectangle({x = 0, y = 0, width = 3, height = VIRTUAL_HEIGHT, data = {InterfaceState = self, r = 1, shadow=false}})) -- left
    table.insert(self.levelObjects, Rectangle({x = 0, y = VIRTUAL_HEIGHT-3, width = VIRTUAL_WIDTH, height = 3, data = {InterfaceState = self, r = 1, shadow=false}})) -- bottom
    table.insert(self.levelObjects, Rectangle({x = VIRTUAL_WIDTH-3, y = 0, width = 3, height = VIRTUAL_HEIGHT, data = {InterfaceState = self, r = 1, shadow=false}})) -- right

    -- load the player
    self.player = Player(gLevels[levelnum].player)

    -- load the player's perimeter points
    self.player.perimeter = gLevels[levelnum].data.perimeter
    self.levelname = gLevels[levelnum].data.levelname

    -- load exits
    self.the_exit = TextBox(gLevels[levelnum].exit)

    -- load rectangles
    for index = 1, #gLevels[levelnum].rectangles do
        table.insert(self.levelObjects, Rectangle(gLevels[levelnum].rectangles[index]))
    end

    -- load text boxes
    for index = 1, #gLevels[levelnum].textBoxes do
        table.insert(self.levelObjects, TextBox(gLevels[levelnum].textBoxes[index]))
    end

    -- load destructables
    for index = 1, #gLevels[levelnum].destructables do
        table.insert(self.objects, Rectangle(gLevels[levelnum].destructables[index]))
    end

    -- load barriers
    for index = 1, #gLevels[levelnum].barriers do
        table.insert(self.border, Rectangle(gLevels[levelnum].barriers[index]))
    end

    -- load movables
    for index = 1, #gLevels[levelnum].movables do
        local thisMovable = gLevels[levelnum].movables[index]
        if thisMovable.type == 'normal' then
            table.insert(self.levelObjects, Movable(thisMovable))
        end
        if thisMovable.type == 'barrier' then
            table.insert(self.border, Movable(thisMovable))
        end
        if thisMovable.type == 'destructable' then
            table.insert(self.objects, Movable(thisMovable))
        end
    end

    self.leveldata = gLevels[levelnum].data
end

function InterfaceState:enter()
    self:loadLevel(gLevelNum)
end

function InterfaceState:exit()
end

function InterfaceState:update(dt)
    self:clean()

    self.player:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end
    for k, object in pairs(self.levelObjects) do
        object:update(dt)
    end
    for k, object in pairs(self.border) do
        object:update(dt)
    end

    -- draw rectangles
    if love.mouse.wasPressed(1) then
        -- start the rectangle
        self.highlight.x = math.ceil(gMouseX)
        self.highlight.y = math.ceil(gMouseY)
    end

    -- extend rectangle according to current mouse position
    if love.mouse.wasDown(1) then
        if not (gMouseX < 0 or gMouseY < 0) then
            self.highlight.width = math.floor(gMouseX - self.highlight.x)
            self.highlight.height = math.floor(gMouseY - self.highlight.y)
        else
            self.highlight.width = 0
            self.highlight.height = 0
        end

        if self.player.perimeter - self.highlight:perimeter() < 0 or not self:highlightCheck() then
            self.highlight.g = 0
            self.highlight.r = 1
        else
            self.highlight.g = 1
            self.highlight.r = 0
        end

        local number = self.highlight:perimeter()
        local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
        -- reverse the int-string and append a comma to all blocks of 3 digits
        int = int:reverse():gsub("(%d%d%d)", "%1,")
        -- reverse the int-string back remove an optional comma and put the
        -- optional minus and fractional part back
        self.highlight.contents = tostring(minus .. int:reverse():gsub("^,", "") .. fraction)
    end

    -- place rectangle if released and enough perimeter left
    if love.mouse.wasReleased(1) then
        local fixedHighlight = self:makeProper(self.highlight)
        if self.player.perimeter - 2*(fixedHighlight.width+fixedHighlight.height) >= 0 and self:highlightCheck() then
            table.insert(self.objects, Rectangle({
                x = fixedHighlight.x,
                y = fixedHighlight.y,
                width = fixedHighlight.width,
                height = fixedHighlight.height,
                data = {InterfaceState = self, g = 0.5}
            }))
            self.player.perimeter = self.player.perimeter - self.highlight:perimeter()
            gSounds['place-success']:play()
        else
            gSounds['place-error']:play()
        end
    end

    -- check for death
    if self.player.health <= 0 or love.keyboard.wasPressed("r") then
        gStateMachine:change('gameover')
        -- SOUND IN HERE
    end

    -- check for victory
    if (self.the_exit:collides(self.player)) then
        gSounds['victory']:play()
        gLevelNum = gLevelNum + 1
        if gLevelNum > #gLevels then
            print("exceeded number of levels")
            love.event.quit()
        else
            self:loadLevel(gLevelNum)
        end
    end

    -- check for menu click
    if self.menu:hover() and love.mouse.wasPressed(1) then
        gStateMachine:change('levelselect')
        gSounds['menu']:play()
    end
end

function InterfaceState:render()
    -- background
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, object in pairs(self.levelObjects) do
        object:render()
    end

    if love.mouse.wasDown(1) then
        self.highlight:render()
    end

    self.the_exit:render()

    -- draw health, level and perimeter
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Health: " .. tostring(math.ceil(self.player.health)), 10, 10, VIRTUAL_WIDTH-20, "left")
    love.graphics.rectangle('fill', 20, 100, 200, 50)
    if self.player.damaged then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.rectangle('fill', 30, 110, 180*self.player.health/20, 30)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Level " .. tostring(gLevelNum) .. ": " .. self.levelname, 10, 10, VIRTUAL_WIDTH-20, "center")

    local i, j, minus, int, fraction = tostring(self.player.perimeter):find('([-]?)(%d+)([.]?%d*)')
    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    love.graphics.printf("Perimeter Points: " .. tostring(minus .. int:reverse():gsub("^,", "") .. fraction), 10, 10, VIRTUAL_WIDTH-20, "right")
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-220, 100, 200, 50)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-210, 110, 180*self.player.perimeter/self.leveldata.perimeter, 30)
    love.graphics.setColor(0, 0, 0, 1)

    -- render menu button
    love.graphics.rectangle('fill', self.menu.x, self.menu.y, self.menu.width, self.menu.height)
    love.graphics.setColor(0.8, 0.8, 0.8, 1)
    love.graphics.rectangle('fill', self.menu.x+10, self.menu.y+10, 80, 80)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', self.menu.x+20, self.menu.y+20, 12, 60)
    love.graphics.rectangle('fill', self.menu.x+20+24, self.menu.y+20, 12, 60)
    love.graphics.rectangle('fill', self.menu.x+20+48, self.menu.y+20, 12, 60)

    for k, object in pairs(self.border) do
        object:render()
    end

    self.player:render()
end

-- helper functions
function InterfaceState:unfocus()
    for k, object in pairs(self.objects) do
        object.focused = false
    end
end

function InterfaceState:clean()
    for i = #self.objects, 1, -1 do
        if self.objects[i].opacity <= 0 then
            gSounds['fade']:play()
            table.remove(self.objects, i)
        end
    end
    for i = #self.levelObjects, 1, -1 do
        if self.levelObjects[i].opacity <= 0 then
            gSounds['fade']:play()
            table.remove(self.objects, i)
        end
    end
end

function InterfaceState:highlightCheck()
    local fixedHighlight = self:makeProper(self.highlight)
    if self.highlight:perimeter() < 100 then
        return false
    end

    for k, object in pairs(self.objects) do
        if object:collides(fixedHighlight) then
            return false
        end
    end
    for k, object in pairs(self.levelObjects) do
        if object:collides(fixedHighlight) then
            return false
        end
    end
    for k, object in pairs(self.border) do
        if object:collides(fixedHighlight) then
            return false
        end
    end
    if self.player:collides(fixedHighlight) then return false end

    -- see if the highlight is within RANGE of player
    local rangeBox = {
        x = self.player.x - RANGE,
        y = self.player.y - RANGE,
        width = self.player.width + 2*RANGE,
        height = self.player.height + 2*RANGE
    }

    if not (fixedHighlight.x > rangeBox.x and rangeBox.x + rangeBox.width > fixedHighlight.x + fixedHighlight.width and
            fixedHighlight.y > rangeBox.y and rangeBox.y + rangeBox.height > fixedHighlight.y + fixedHighlight.height
    ) then
        return false
    end

    love.graphics.rectangle('fill', rangeBox.x, rangeBox.y, rangeBox.width, rangeBox.height)

    return true
end

function InterfaceState:makeProper(thing)
    local ogX = thing.x
    local ogY = thing.y
    local ogWidth = thing.width
    local ogHeight = thing.height

    -- check if ogWidth is negative, if so switch.
    if ogWidth < 0 then
        ogX = ogX + ogWidth
        ogWidth = -ogWidth
    end
    -- same with height
    if ogHeight < 0 then
        ogY = ogY + ogHeight
        ogHeight = -ogHeight
    end
    -- return as a dict
    return {x = ogX, y = ogY, width = ogWidth, height = ogHeight}
end
