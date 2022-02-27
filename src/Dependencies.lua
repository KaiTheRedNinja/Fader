-- constants
-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push. It's a 9:16 ratio.
VIRTUAL_WIDTH = 1280*2
VIRTUAL_HEIGHT = 720*2 -- 9/16 of VIRTUAL_WIDTH

--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- util
require 'src/StateMachine'

-- states
require 'src/states/BaseState'
require 'src/states/InterfaceState'
require 'src/states/GameOverState'
require 'src/states/LevelState'

-- classes
require 'src/classes/Object'
require 'src/classes/TextBox'
require 'src/classes/Rectangle'
require 'src/classes/Player'
require 'src/classes/Movable'

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3', 'static'), -- CREDITS TO CS50, LECTURE-3 MATCH 3 MUSIC #1
    ['fade'] = love.audio.newSource('sounds/fade.wav', 'static'),
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['menu'] = love.audio.newSource('sounds/menu.wav', 'static'),
    ['place-error'] = love.audio.newSource('sounds/place-error.wav', 'static'),
    ['place-success'] = love.audio.newSource('sounds/place-success.wav', 'static'),
    ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
    -- DEATH SOUND TBD
}

love.graphics.setDefaultFilter('nearest', 'nearest')

gTextures = {}

gFrames = {}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 64),
    ['giant'] = love.graphics.newFont('fonts/font.ttf', 128),
}
