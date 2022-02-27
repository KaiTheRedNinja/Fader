Movable = Class{__includes = Object}

function Movable:init(def)
    Object.init(self, def.x, def.y, def.width, def.height)

    self.Interface = gInterface
    self.Interface:unfocus()
    self.r = def.data.r or 0
    self.g = def.data.g or 0
    self.b = def.data.b or 0

    -- oscilations
    self.oscil = def.data.oscil

    self.ogX = self.x
    self.newX = def.data.x or self.ogX

    self.ogY = self.y
    self.newY = def.data.y or self.ogY

    self.ogWidth = self.width
    self.newWidth = def.data.width or ogX

    self.ogHeight = self.height
    self.newHeight = def.data.height or self.ogHeight

    self:oscil1()

    self.collidable = def.data.collidable
    if self.collidable == nil then self.collidable = true end
    self.fade = def.data.fade or 0.20
    self.shadow = def.data.shadow == nil and true or def.data.shadow
end

function Movable:perimeter() return math.floor(2*(math.abs(self.width)+math.abs(self.height))) end
function Movable:hover() return Object.hover(self) end
function Movable:collides(thing) return self.collidable and Object.collides(self, thing) end

function Movable:update(dt)
end

function Movable:oscil1()
    Timer.tween(self.oscil, {[self] = {
        x = self.newX,
        y = self.newY,
        width = self.newWidth,
        height = self.newHeight,
    }}):finish(function() self:oscil2() end)
end

function Movable:oscil2()
    Timer.tween(self.oscil, {[self] = {
        x = self.ogX,
        y = self.ogY,
        width = self.ogWidth,
        height = self.ogHeight,
    }}):finish(function() self:oscil1() end)
end

function Movable:render()
    love.graphics.setLineWidth(5)
    love.graphics.setColor(self.r, self.g, self.b, self.opacity*0.5)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

    -- shadow test
    if self.shadow then
        love.graphics.setColor(0, 0, 0, 0.3*self.opacity)
        love.graphics.polygon('fill', {
            self.x, self.y+self.height, -- top left
            self.x+self.width, self.y+self.height, -- top right
            self.x+self.width-100/6, self.y+self.height+100, -- bottom right
            self.x+100/6, self.y+self.height+100, -- bottom left
        })
    end
end
