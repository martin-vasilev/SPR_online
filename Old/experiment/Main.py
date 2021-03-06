# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 21:23:22 2020

@author: Martin
"""

from core.Settings import Settings
from core.Functions import Functions


from psychopy.visual import Window, TextStim, BufferImageStim
from psychopy import gui
from psychopy.core import wait, Clock
from psychopy.event import waitKeys, Mouse, getKeys
#from psychopy.sound import Sound
from psychopy import core
import os

if not os.path.exists('Data'):
    os.makedirs('Data')
    

const= Settings()
fun= Functions()

# OPEN WINDOW:
win=  Window(size= const.DISPSIZE, units= 'norm', fullscr= False , color= const.BGC)


myMouse = Mouse(win) # create a mouse object
myMouse.setVisible(0) # make the mouse invisible

globalClock= Clock()






#fun.CreditCardCalibration(win)

#wait(2)
fun.Headphones(win, const, myMouse)
#wait(2)

win.close()
core.quit() 	            
