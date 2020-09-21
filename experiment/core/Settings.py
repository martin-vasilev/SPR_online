# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 21:56:47 2020

@author: Martin
"""

class Settings():
   def __init__(self, expName= "SPR speech", DISPSIZE= (0, 0), BGC= (1, 1, 1),
                FGC= (0,0,0), Font= "Courier New", Font_height= 24, useFullscreen= True):
        """
        Input:
            expName= Experiment name
            DISPSIZE= Display size
            BGC= Background colour
            FGC= Foreground color
            InstrTextSize= 24
            Font_height= 
            useFullscreen= use full screen?
        """
        
        from psychopy import monitors
        Mon= monitors.getAllMonitors()
        
        
        self.DISPSIZE= win.monitor.getSizePix()
        
        self.expName= expName
        self.DISPSIZE= DISPSIZE
        self.BGC= BGC
        self.FGC= FGC
        self.Font= Font
        self.useFullscreen= useFullscreen
        self.Font_height= Font_height