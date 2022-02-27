Player = Class{__includes = Object}

JUMP_SPEED = -15
PLAYER_SPEED = 500
FRICTION = 0.1
GRAVITY = 50
RANGE = 640 -- 4 units i think
INJURY = 2

function Player:init(def)
    Object.init(self, def.x, def.y, def.width, def.height)

    self.ogHeight = self.height
    self.ogWidth = self.width

    self.Interface = gInterface
    self.Interface:unfocus()

    self.health = 20

    self.dx = 0
    self.dy = 0

    self.perimeter = 3000
end

function Player:area() return self.width*self.height end
function Player:hover() return Object.hover(self) end
function Player:collides(thing) return Object.collides(self, thing) end

function Player:update(dt)
    self.damaged = false
    leftKey = love.keyboard.isDown('left') or love.keyboard.isDown('a') -- for both arrow and WASD keys
    rightKey = love.keyboard.isDown('right') or love.keyboard.isDown('d') or love.keyboard.isDown('s')
    self.dx = (
        (leftKey and -PLAYER_SPEED*dt or 0) +
        (rightKey and PLAYER_SPEED*dt or 0))

    -- gravity
        self.dy = self.dy + GRAVITY*dt

    local oldy = self.y

    self.x = self.x + self.dx
    self.y = self.y + self.dy

    -- flag for collision finding
    local collided = false

    -- check for side collisions
    self.height = self.height - 30
    self.width = self.ogWidth/2
    local collisionCount = {}
    for k, object in pairs(self.Interface.objects) do
        if object:collides(self) then
            collisionCount['left'] = true
            break
        end
    end
    for k, object in pairs(self.Interface.levelObjects) do
        if object:collides(self) then
            collisionCount['left'] = true
            break
        end
    end
    self.x = self.x + self.ogWidth/2
    for k, object in pairs(self.Interface.objects) do
        if object:collides(self) then
            collisionCount['right'] = true
            break
        end
    end
    for k, object in pairs(self.Interface.levelObjects) do
        if object:collides(self) then
            collisionCount['right'] = true
            break
        end
    end
    self.x = self.x - self.ogWidth/2

    -- only one collision
    if collisionCount['left'] and not collisionCount['right'] then
        for k, object in pairs(self.Interface.objects) do
            if object:collides(self) then
                self.x = self.x - self.dx
                self.health = self.health - INJURY*dt
                object.opacity = object.opacity - object.fade*dt
                self.damaged = true
                collided = true
                -- check for moving tile
                while object:collides(self) do
                    self.x = self.x + 1
                end
                break
            end
        end
        for k, object in pairs(self.Interface.levelObjects) do
            if object:collides(self) then
                self.x = self.x - self.dx
                collided = true
                -- check for moving tile
                while object:collides(self) do
                    self.x = self.x + 1
                end
                break
            end
        end
    end
    if collisionCount['right'] and not collisionCount['left'] then
        self.x = self.x + self.ogWidth/2
        for k, object in pairs(self.Interface.objects) do
            if object:collides(self) then
                self.x = self.x - self.dx
                self.health = self.health - INJURY*dt
                object.opacity = object.opacity - object.fade*dt
                self.damaged = true
                collided = true
                -- check for moving tile
                while object:collides(self) do
                    self.x = self.x - 1
                end
                break
            end
        end
        for k, object in pairs(self.Interface.levelObjects) do
            if object:collides(self) then
                self.x = self.x - self.dx
                collided = true
                -- check for moving tile
                -- check for moving tile
                while object:collides(self) do
                    self.x = self.x - 1
                end
                break
            end
        end
        self.x = self.x - self.ogWidth/2
    end
    self.height = self.height + 30
    self.width = self.ogWidth

    -- check for touching border and reduce health
    for k, object in pairs(self.Interface.border) do
        if object:collides(self) then
            self.x = self.x - self.dx
            self.health = -1
            break
        end
    end

    -- check for bottom collisions
    self.width = self.width - 10
    self.x = self.x + 5
    self.y = self.y + self.height/2
    self.height = self.height/2
    -- check for collision with ANY objects and undo movement if is colliding for Y
    for k, object in pairs(self.Interface.objects) do
        if object:collides(self) then
            self.y = self.y - self.dy
            collided = true
            self.health = self.health - INJURY*dt
            object.opacity = object.opacity - object.fade*dt
            self.damaged = true
            -- check for moving tile
            self.width = self.width - 20
            self.x = self.x - 10
            while object:collides(self) do
                self.y = self.y - 1
            end
            oldy = self.y - self.ogHeight/2
            self.width = self.width + 20
            self.x = self.x + 10
            break
        end
    end
    for k, object in pairs(self.Interface.levelObjects) do
        if object:collides(self) then
            self.y = self.y - self.dy
            collided = true
            -- check for moving tile
            self.width = self.width - 20
            self.x = self.x - 10
            while object:collides(self) do
                self.y = self.y - 1
            end
            oldy = self.y - self.ogHeight/2
            self.width = self.width + 20
            self.x = self.x + 10
            break
        end
    end
    self.y = self.y - self.ogHeight/2

    -- check for top collisions
    if not collided then
        for k, object in pairs(self.Interface.objects) do
            if object:collides(self) then
                self.y = self.y - self.dy + 1
                self.health = self.health - INJURY*dt
                object.opacity = object.opacity - object.fade*dt
                self.damaged = true
                break
            end
        end
        for k, object in pairs(self.Interface.levelObjects) do
            if object:collides(self) then
                self.y = self.y - self.dy + 1
                break
            end
        end
    end
    self.height = self.ogHeight
    self.width = self.width + 10
    self.x = self.x - 5

    -- control, don't want gravity acceleration past no return :)
    self.dy = self.y - oldy

    -- jump
    if collided and (love.keyboard.isDown('up') or love.keyboard.isDown('w') or love.keyboard.isDown('space')) then
        self.dy = JUMP_SPEED
        gSounds['jump']:play()
    end
end

function Player:render()
    if self.damaged then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(0, 0, 1, 1)
    end
    love.graphics.setLineWidth(10)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    if self.damaged then
        love.graphics.setColor(1, 0, 0, 0.2)
    else
        love.graphics.setColor(0, 0, 1, 0.2)
    end
    love.graphics.setLineWidth(10)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    -- shadow test
    love.graphics.setColor(0, 0, 0, 0.3*self.opacity)
    love.graphics.polygon('fill', {
        self.x, self.y+self.height, -- top left
        self.x+self.width, self.y+self.height, -- top right
        self.x+self.width-50/6, self.y+self.height+50, -- bottom right
        self.x+50/6, self.y+self.height+50, -- bottom left
    })
end
