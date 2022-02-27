NOTE: in this document, "box", "rectangle", "blocks" are used interchangably.

# HOW TO PLAY
You are the blue box. Control left/right using `left arrow` or `a`, `right arrow` or `d`. Jump using `up arrow`, `space`, or `w`.
Drag your mouse to make boxes. Your goal is to get to the exit.

Demo: 
https://www.youtube.com/watch?v=MNCBXuGp8xY
https://drive.google.com/file/d/1Bptjv2YTOtV6d50NIHZJ8ma1gs_wLJa6/view sharper video

# Game Components

## Drawn Boxes
These are the boxes that you draw. These are toxic to you, and damage you at a rate of 2 (out of 20) health per second when in contact.
When you are in contact, these boxes will start to "fade", eventually dissapearing.
When you draw a box, it costs you perimeter points. You cannot build if you have no more perimeter points, and faded boxes do not give you back perimeter points.
Each box must be a minimum of 100 to be placed.

## Destructables
Destructables are magenta blocks. They behave similarly to player-drawn boxes, in the sense that they fade on contact (the amount of time varies!) and damage you.
This "fading" system is meant to keep you on your toes, to encourage movement.

## Other components
Borders are red, and they include the walls, floor, and ceiling. These will kill you instantly.

You may occasionally see text boxes. These are usually tips to guide you. Most of the things in this Readme are also present in-game through these text boxes.

Movables are blocks that can move. They can be proper blocks, magenta destructables, or red killers.

## Other game-related information
If you've run out of points or are stuck somewhere, press R to kill yourself and restart. Or walk into the walls.
Press the button on the bottom-right to access the level selector and preferences. In the selector, yellow levels are levels that you have passed. The green level is the one you're currently on, white ones are future levels. Grey and unmarked "levels" are not levels, they're just there for aesthetic completeness. No levels are blocked off, for testing purposes.
In the menu, you can also mute sound effects and audio seperately.

# Setup

NOTE: I am a mac user, and nobody in my household has either Windows or Linux and I don't want to run a VM. These steps are as general as possible, but I cannot be certain that they work.

## Manual Method
### GETTING THE LOVE FILE
If there is a .love file in this repo, download that. It's usually bug-free.
If there is not, that means I forgot to make one. To create the .love file:
1. download all the code
2. cd to the the folder in terminal and run `zip -9 -r Archive.love .`. This should produce a .love executable file.

### OPENING THE LOVE FILE
1. Download the right copy of LOVE2D (there are both macOS and windows in the `Templates` folder in `!EXPORTS`). OR download LOVE2D for your system directly from the site: https://www.love2d.org
3. Double-click open the .love file from the previous section

It should run. 

### COMMON ERRORS:
- Something along the lines of "main.lua not found": the zip file was of the parent folder, not the contents. Go INTO the folder and make the zip.

## From the export
Go into the `!EXPORTS` folder and download the executable for your system (linux users, sorry. You're not supported yet)
Note: the win32 and win64 executables MAY NOT WORK. I just followed the instructions on the LOVE2D site, but can't test them. 
