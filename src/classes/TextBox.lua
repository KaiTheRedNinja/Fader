TextBox = Class{__includes = Object}

function TextBox:init(def)
    Object.init(self, def.x, def.y, def.width, def.height)

    self.Interface = gInterface
    self.Interface:unfocus()
    self.focused = true
    self.highlighted = true

    self.padding = 16

    self.contents = def.data.contents or ""
    self.alwaysSelected = def.data.alwaysOn or false

    self.r = def.data.r or 0
    self.g = def.data.g or 0
    self.b = def.data.b or 0

    self.collidable = def.data.collidable
    if self.collidable == nil then self.collidable = true end

    self.align = def.data.alignment or "center"
end

function TextBox:perimeter() return 2*(math.abs(self.width)+math.abs(self.height)) end
function TextBox:hover() return Object.hover(self) end
function TextBox:collides(thing) return self.collidable and Object.collides(self, thing) end

function TextBox:update(dt)
    if not self.alwaysSelected then
        -- check for mouse collision/press
        if self:hover() then
            self.highlighted = true
            if love.mouse.wasPressed(1) then
                self.focused = not self.focused
                if self.focused then
                    self.Interface:unfocus()
                    self.focused = true
                end
            end
        else
            self.highlighted = false
        end
    end
end

function TextBox:render()
    newBox = self.Interface:makeProper(self)

    if self.alwaysSelected then
        love.graphics.setColor(self.r, self.g, self.b, 0.5)
        love.graphics.setLineWidth(7)
        love.graphics.rectangle('line', newBox.x, newBox.y, newBox.width, newBox.height)
    else
        if self.focused then
            love.graphics.setColor(self.r, self.g, self.b, 1)
            love.graphics.setLineWidth(5)
            love.graphics.rectangle('line', newBox.x, newBox.y, newBox.width, newBox.height)
        end if self.highlighted then
            love.graphics.setColor(0.5, 0.5, 0.5, 0.5)
            love.graphics.setLineWidth(7)
            love.graphics.rectangle('line', newBox.x, newBox.y, newBox.width, newBox.height)
        end
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(self.contents, newBox.x+self.padding, newBox.y+self.padding, newBox.width-self.padding*2, self.align)
end
