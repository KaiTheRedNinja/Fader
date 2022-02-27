Object = Class{}

function Object:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.focused = false -- by default, it is not focused.
    self.highlighted = false -- by default, it is not highlighted.
    self.opacity = 1 -- this also functions as health
end
function Object:update(dt) end
function Object:render() end

function Object:collides(thing)
    return not (self.x > thing.x + thing.width or thing.x > self.x + self.width or
                self.y > thing.y + thing.height or thing.y > self.y + self.height)
end

function Object:hover()
    local aMouse = {
        x = gMouseX,
        y = gMouseY,
        width = 0,
        height = 0}
    return not (self.x > aMouse.x + aMouse.width or aMouse.x > self.x + self.width or
                self.y > aMouse.y + aMouse.height or aMouse.y > self.y + self.height)
end
