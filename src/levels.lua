gLevelNum = 1
gAudioVol = true
gMusicVol = true

UNIT = VIRTUAL_HEIGHT/9 -- a unit is 1/9 of VIRTUAL_HEIGHT and 1/16 of VIRTUAL_WIDTH. You can use this to plan out your levels.
-- stuff does not HAVE to be on the grid, the grid is just there to help you. Usually 1 UNIT is 160 virtual pixels, by default 80 on your screen.

gLevels = {
    [1] = {
        data = {
            levelname = "Tutorial",
            perimeter = 3000
        },
        exit = {
            x = UNIT,
            y = VIRTUAL_HEIGHT - 165,
            width = 96,
            height = 160,
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"}
        },
        player = {
            x = UNIT,
            y = UNIT/2,
            width = 64,
            height = 128,
            data = {}
        },
        rectangles = {
            {
                x = 0,
                y = UNIT*3,
                width = UNIT*3,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*6,
                y = UNIT*3,
                width = UNIT*3,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*9,
                y = UNIT*7,
                width = UNIT*3,
                height = UNIT,
                data = {}
            }
        },
        textBoxes = {
            {
                x = UNIT*3,
                y = UNIT,
                width = UNIT*2,
                height = UNIT,
                data = {alwaysOn = true, contents = "1. Drag with your cursor to create boxes. ", collidable = false}
            },
            {
                x = UNIT*3.1,
                y = UNIT*3,
                width = UNIT*2.8,
                height = UNIT,
                data = {alwaysOn = true, contents = "2. Like over here. They have to cost at least 100 perimeter points to be valid!", collidable = false}
            },
            {
                x = UNIT*8,
                y = UNIT*0.8,
                width = UNIT*2,
                height = UNIT*1.2,
                data = {alwaysOn = true, contents = "3. The number in the highlight is how many perimeter points you will use.", collidable = false}
            },
            {
                x = UNIT*9.1,
                y = UNIT*5.1,
                width = UNIT*2.8,
                height = UNIT*1.2,
                data = {alwaysOn = true, contents = "4. When you run out, you can't place! Also, you can't build boxes that exceed a certain distance of the player.", collidable = false}
            },
            {
                x = UNIT*3,
                y = UNIT*6,
                width = UNIT*4,
                height = UNIT,
                data = {alwaysOn = true, contents = "5. Don't touch the walls or stay on the boxes for too long. They'll kill you! Also, boxes fade if you touch them.", collidable = false}
            },
            {
                x = UNIT*13.5,
                y = UNIT*7,
                width = UNIT*2,
                height = UNIT*1,
                data = {alwaysOn = true, contents = "This button below brings you to level selection", collidable = false}
            },
        },
        destructables = {},
        barriers = {},
        movables = {},
    },
    [2] = {
        data = {
            levelname = "Demolition and some climbing",
            perimeter = 2000
        },
        exit = {
            x = UNIT,
            y = VIRTUAL_HEIGHT - 165,
            width = 96,
            height = 160,
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"}
        },
        player = {
            x = UNIT,
            y = UNIT/2,
            width = 64,
            height = 128,
            data = {}
        },
        rectangles = {
            {
                x = 0,
                y = UNIT*2,
                width = UNIT*4,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*4,
                y = UNIT*2,
                width = UNIT,
                height = UNIT*4,
                data = {}
            },
            {
                x = UNIT*5,
                y = UNIT*5,
                width = UNIT*3,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*6,
                y = 0,
                width = UNIT,
                height = UNIT*4,
                data = {}
            },
            {
                x = UNIT*8,
                y = UNIT*2.5,
                width = UNIT,
                height = UNIT*3.5,
                data = {}
            },
            {
                x = UNIT*10,
                y = UNIT*2,
                width = UNIT*2,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*12,
                y = UNIT*4,
                width = UNIT*2,
                height = UNIT,
                data = {}
            }
        },
        textBoxes = {
            {
                x = UNIT*2,
                y = UNIT*0.5,
                width = UNIT*2,
                height = UNIT,
                data = {alwaysOn = true, contents = "1. Walk into these boxes for a while to destroy them.", collidable = false}
            },
            {
                x = UNIT*8,
                y = UNIT*0.5,
                width = UNIT*3.5,
                height = UNIT,
                data = {alwaysOn = true, contents = "2. You can climb up walls by jumping while pusing the wall. Don't hit the ceiling! You might die.", collidable = false}
            },
            {
                x = UNIT*12,
                y = UNIT*7,
                width = UNIT*2,
                height = UNIT,
                data = {alwaysOn = true, contents = "3. You can't make boxes that overlap with other things.", collidable = false}
            }
        },
        destructables = {
            {
                x = UNIT*5.2,
                y = UNIT*0.2,
                width = UNIT*0.6,
                height = UNIT*1.6,
                data = {r = 1, b = 1, fade = 1}
            },
            {
                x = UNIT*5.2,
                y = UNIT*6.2,
                width = UNIT*2.6,
                height = UNIT*2.6,
                data = {r = 1, b = 1, fade = 1}
            }
        },
        barriers = {},
        movables = {},
    },
    [3] = {
        data = {
            levelname = "Lazers and Quick Clicking",
            perimeter = 5000
        },
        exit = {
            x = UNIT,
            y = VIRTUAL_HEIGHT - 165,
            width = 96,
            height = 160,
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"}
        },
        player = {
            x = UNIT,
            y = UNIT/2,
            width = 64,
            height = 128,
            data = {}
        },
        rectangles = {
            {
                x = 0,
                y = UNIT*2,
                width = UNIT*2,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*13,
                y = UNIT*7,
                width = UNIT*2,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*3,
                y = UNIT*8,
                width = UNIT*10,
                height = UNIT,
                data = {}
            }
        },
        textBoxes = {
            {
                x = UNIT*5.5,
                y = UNIT,
                width = UNIT*2,
                height = UNIT,
                data = {alwaysOn = true, contents = "These red things are lazers. Like the walls, they can kill you.", collidable = false}
            }
        },
        destructables = {
            {
                x = UNIT*4.2,
                y = UNIT*0.2,
                width = UNIT*0.6,
                height = UNIT*3.2,
                data = {r = 1, b = 1, fade = 2}
            },
            {
                x = UNIT*8.2,
                y = UNIT*0.2,
                width = UNIT*0.6,
                height = UNIT*3.2,
                data = {r = 1, b = 1, fade = 2}
            },
            {
                x = UNIT*12.2,
                y = UNIT*0.2,
                width = UNIT*0.6,
                height = UNIT*3.2,
                data = {r = 1, b = 1, fade = 2}
            },
        },
        barriers = {
            {
                x = 0,
                y = UNIT*4,
                width = UNIT*14,
                height = UNIT,
                data = {r = 1}
            },
            {
                x = UNIT*4.2,
                y = UNIT*7.2,
                width = UNIT*0.6,
                height = UNIT*0.6,
                data = {r = 1}
            },
            {
                x = UNIT*7.2,
                y = UNIT*7.2,
                width = UNIT*0.6,
                height = UNIT*0.6,
                data = {r = 1}
            },
            {
                x = UNIT*10.2,
                y = UNIT*7.2,
                width = UNIT*0.6,
                height = UNIT*0.6,
                data = {r = 1}
            },
        },
        movables = {},
    },
    [4] = {
        data = {
            levelname = "I like to move it move it!",
            perimeter = 5000
        },
        exit = {
            x = UNIT,
            y = VIRTUAL_HEIGHT - 165,
            width = 96,
            height = 160,
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"}
        },
        player = {
            x = UNIT,
            y = UNIT/2,
            width = 64,
            height = 128,
            data = {}
        },
        rectangles = {
            {
                x = 0,
                y = UNIT*2,
                width = UNIT*2,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*6,
                y = UNIT*2,
                width = UNIT,
                height = UNIT,
                data = {}
            },
            {
                x = UNIT*11,
                y = UNIT*2,
                width = UNIT,
                height = UNIT,
                data = {}
            }
        },
        textBoxes = {
            {
                x = UNIT*3,
                y = UNIT,
                width = UNIT*2,
                height = UNIT,
                data = {alwaysOn = true, contents = "These platforms move! They can also push you. ", collidable = false}
            }
        },
        destructables = {
            {
                x = UNIT*4,
                y = UNIT*5,
                width = UNIT,
                height = UNIT*2,
                data = {r = 1, b = 1, fade = 0.5}
            },
        },
        barriers = {
            {
                x = UNIT*2,
                y = UNIT*3,
                width = UNIT*9,
                height = UNIT,
                data = {r = 1}
            },
            {
                x = UNIT*12,
                y = UNIT*3,
                width = UNIT,
                height = UNIT,
                data = {r = 1}
            },
            {
                x = UNIT*15,
                y = UNIT,
                width = UNIT,
                height = UNIT*7,
                data = {r = 1}
            },
            {
                x = UNIT*14,
                y = UNIT*6,
                width = UNIT,
                height = UNIT,
                data = {r = 1}
            },
        },
        movables = {
            {
                type = "normal",
                x = UNIT*2,
                y = UNIT*2,
                width = UNIT,
                height = UNIT,
                data = {x = UNIT*5, y = 0, oscil = 2}
            },
            {
                type = "normal",
                x = UNIT*7,
                y = 0,
                width = UNIT,
                height = UNIT,
                data = {x = UNIT*10, y = UNIT*1, oscil = 2}
            },
            {
                type = "normal",
                x = UNIT*12,
                y = UNIT*2,
                width = UNIT*3,
                height = UNIT,
                data = {y = UNIT*7, oscil = 2}
            },
            {
                type = "destructable",
                x = UNIT*10,
                y = UNIT*7,
                width = UNIT*2,
                height = UNIT,
                data = {r = 1, b = 1, x = UNIT*5, oscil = 3, fade = 0.2}
            },
        },
    },
    [5] = {
        data = {
            levelname = "You're Done!!!",
            perimeter = 10000000
        },
        exit = {
            x = UNIT*13,
            y = UNIT*7,
            width = 96,
            height = 160,
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"}
        },
        player = {
            x = UNIT,
            y = UNIT/2,
            width = 64,
            height = 128,
            data = {}
        },
        rectangles = {},
        textBoxes = {
            {
                x = 0,
                y = UNIT*8,
                width = VIRTUAL_WIDTH,
                height = UNIT,
                data = {contents = "You're done! Just mess around, or go to the exit to quit the game. There should be more levels here, but due to time there's only the tutorial and 2 levels :P"}
            }
        },
        destructables = {},
        barriers = {},
        movables = {},
    }
}

__FORMAT__ = {
    ["commented"] = { -- level number as integer
        data = {
            levelname = "Level name",
            perimeter = 0 -- some integer amout of perimeter points
        },
        exit = {
            x = 0,                      -- the x position of the exit gate
            y = VIRTUAL_HEIGHT - 0,     -- the y position of the exit gate
            width = 96,                 -- the width of the exit gate
            height = 160,               -- the height of the exit gate
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"} -- don't change these
        },
        player = {
            x = 50,         -- the starting x position of the player
            y = 10,         -- the starting y position of the player
            width = 64,     -- the width of the player
            height = 128,   -- the height of the player
            data = {}       -- leave this blank.
        },
        rectangles = { -- this is a list of rectangles. There's only 1 example here.
            {
                x = 0,                              -- the x position of a rectangle
                y = VIRTUAL_HEIGHT/3-32,            -- the y position of a rectangle
                width = VIRTUAL_WIDTH/2+32*2,       -- the width of a rectangle
                height = VIRTUAL_HEIGHT/3+32*2,     -- the height of the rectangle
                data = {}                           -- advanced section, see the Rectangle class file for details.
            }
        },
        textBoxes = {},     -- table similar to rectangles, but with text boxes. Functionally the same.
        destructables = {}, -- table similar to rectangles, but you (the player) can break these.
        barriers = {},      -- table similar to rectangles, but these will instantly kill the player.
        movables = {        -- table filled with movables. Similar to rectangle, but in data specify where to oscil between.
            {
                type = "normal", -- can be destructable, breakable, barrier.
                x = 0, -- these are same as rectangle
                y = 0,
                width = UNIT,
                height = UNIT,
                data = {x = UNIT*2, y = UNIT*6, width = UNIT*4, oscil = 3} -- x, y, width, height are the things to oscil between. Oscil is the time per loop.
            },
        },
    },
    ["clean"] = {
        data = {
            levelname = "Level name",
            perimeter = 0
        },
        exit = {
            x = 0,
            y = VIRTUAL_HEIGHT - 0,
            width = 96,
            height = 160,
            data = {g = 0.5, b = 0.5, alwaysOn = true, contents = "EXIT"}
        },
        player = {
            x = 50,
            y = 10,
            width = 64,
            height = 128,
            data = {}
        },
        rectangles = {
            {
                x = 0,
                y = VIRTUAL_HEIGHT/3-32,
                width = VIRTUAL_WIDTH/2+32*2,
                height = VIRTUAL_HEIGHT/3+32*2,
                data = {}
            }
        },
        textBoxes = {},
        destructables = {},
        barriers = {},
        movables = {
            {
                type = "normal",
                x = 0,
                y = 0,
                width = UNIT*2,
                height = UNIT,
                data = {x = UNIT*2, y = UNIT*6, width = UNIT*4, oscil = 3}
            },
        },
    }
}
