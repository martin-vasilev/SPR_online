# -*- coding: utf-8 -*-
"""
Created on Tue Sep 22 08:31:24 2020

@author: Martin
"""

from psychopy import event

pressed = event.getKeys()

Done= False

while not Done:
    if 'space' in pressed:
        Done= True
    