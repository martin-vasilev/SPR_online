# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 21:45:43 2020

@author: Martin
"""

###### Experiment Introduction

class Functions():

    def Headphones(self, win, const, icon= 'img/headphones.png'):
        """
        Presents Introduction to the Experiment
        """
        from psychopy.visual import TextStim, ImageStim
        
        
        
        Instr = TextStim(win=win, ori=0, name='headphones',
    	                               text="It's time to put your headphones!", font= "Consolas",
    	                               pos=[0, 0], height= const.Font_height,
    	                               color=const.FGC, colorSpace=u'rgb',
    	                               antialias=True)
        
        HP_icon =  ImageStim(win, image= icon, pos= (0, 0))
        Instr.draw()
        HP_icon.draw()
        win.flip()
