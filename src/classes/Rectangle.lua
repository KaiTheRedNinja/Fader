Rectangle = Class{__includes = Object}

function Rectangle:init(def)
    Object.init(self, def.x, def.y, def.width, def.height)

    self.Interface = gInterface
    self.Interface:unfocus()
    self.r = def.data.r or 0
    self.g = def.data.g or 0
    self.b = def.data.b or 0

    self.collidable = def.data.collidable
    if self.collidable == nil then self.collidable = true end
    self.fade = def.data.fade or 0.20
    self.shadow = def.data.shadow == nil and true or def.data.shadow
end

function Rectangle:perimeter() return math.floor(2*(math.abs(self.width)+math.abs(self.height))) end
function Rectangle:hover() return Object.hover(self) end
function Rectangle:collides(thing) return self.collidable and Object.collides(self, thing) end

function Rectangle:update(dt)
end

function Rectangle:render()
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
