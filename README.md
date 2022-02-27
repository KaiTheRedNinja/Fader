NOTE: in this document, "box", "rectangle", "blocks" are used interchangably.

# HOW TO PLAY
You are the blue box. Control left/right using left/right arrows, jump using up arrow.
Drag your mouse to make boxes. Your goal is to get to the exit.

The thing is: the boxes you draw are toxic to you. They damage you at a rate of 2 (out of 20) health per second.
Anything red kill you instantly, including the walls, floor, and ceiling.

You may occasionally see text boxes. These are usually tips to guide you. Most of the things in this Readme are also present in-game through these text boxes.

When you draw a box, it costs you perimeter points. You cannot build if you have no more perimeter points. Each box must be a minimum of 100 to be placed.
Any box not red or black can be broken by simply coming into contact with it. It might be useful, clearing out a barrier, or harmful, by eventually breaking the platform you are standing on.
When boxes are destroyed, you do not get perimeter points back. This "fading" system is meant to keep you on your toes, to encourage movement.

Movables are blocks that can move. Note: You will fall through them if they're moving upwards.

If you've run out of points or are stuck somewhere, press R to kill yourself and restart. Or walk into the walls.

# Setup

NOTE: I am a mac user, and nobody in my household has either Windows or Linux and I don't want to run a VM. These steps are as general as possible, but I cannot be certain that they work.

## GETTING THE LOVE FILE
If there is a .love file in this repo, download that. It's usually bug-free.
If there is not, that means I forgot to make one. To create the .love file:
1. download all the code
2. cd to the the folder in terminal and run `zip -9 -r Archive.love .`. This should produce a .love executable file.

## OPENING THE LOVE FILE
1. Download LOVE2D for your system from https://www.love2d.org
2. Double-click open the .love file from the previous section
It should work.

## COMMON ERRORS:
- Something along the lines of "main.lua not found": the zip file was of the parent folder, not the contents. Go INTO the folder and make the zip.
