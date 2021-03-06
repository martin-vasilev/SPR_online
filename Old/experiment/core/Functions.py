# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 21:45:43 2020

@author: Martin
"""

###### Experiment Introduction
from __future__ import absolute_import, division

class Functions():

    def Headphones(self, win, const, Mouse, icon= 'img/headphones.png'):
        """
        Presents Introduction to the Experiment
        """
        from psychopy.visual import TextStim, ImageStim
        from psychopy.event import getKeys
    
        
        Instr = TextStim(win=win, ori=0, name='headphones',
    	                               text="It's time to put your headphones on!", font= "Consolas",
    	                               pos=[0, 0],
    	                               color=const.FGC, colorSpace=u'rgb',
    	                               antialias=True)
        
        HP_icon =  ImageStim(win, image= icon, pos= (0, 0.4))
        Instr.draw()
        HP_icon.draw()
        win.flip()
        
        allowedResp= ['space']
        Done= False
        
        while not Done:
            pressed= getKeys()
            if any(i in pressed for i in allowedResp):
                Done= True
                
                
                
                
                
                
                
    # ADAPTED FROM https://gitlab.pavlovia.org/Wake/screenscale/tree/master            
    def CreditCardCalibration(self, win):
        from psychopy import visual, core, event
        from psychopy.constants import (NOT_STARTED, STARTED,FINISHED)
        from psychopy.hardware import keyboard
        
        frameTolerance = 0.001  # how close to onset before 'same' frame
        
        # Start Code - component code to be run before the window creation
        
        # Initialize components for Routine "screen_scale"
        screen_scaleClock = core.Clock()
        oldt=0
        x_size=8.560
        y_size=5.398
        screen_height=0
        
        if win.units=='norm':
            x_scale=.05
            y_scale=.1
            dbase = .0001
            unittext=' norm units'
            vsize=2
        elif win.units=='pix':
            x_scale=60
            y_scale=40
            dbase = .1
            unittext=' pixels'
            vsize=win.size[1]
        else:
            x_scale=.05
            y_scale=.05
            dbase = .0001
            unittext=' height units'
            vsize=1
        text_top = visual.TextStim(win=win, name='text_top',
            text='Resize this image to match the size of a credit card\nUp arrow for taller\nDown arrow for shorter\nLeft arrow for narrower\nRight arrow for wider',
            font='Arial',
            units='norm', pos=(0, .7), height=0.1, wrapWidth=1.5, ori=0, 
            color='white', colorSpace='rgb', opacity=1, 
            languageStyle='LTR',
            depth=-2.0);
        text_bottom = visual.TextStim(win=win, name='text_bottom',
            text='Press the space bar when done',
            font='Arial',
            units='norm', pos=(0, -.6), height=0.1, wrapWidth=1.5, ori=0, 
            color='white', colorSpace='rgb', opacity=1, 
            languageStyle='LTR',
            depth=-3.0);
        ccimage = visual.ImageStim(
            win=win,
            name='ccimage', 
            image='img/bank-1300155_640.png', mask=None,
            ori=0, pos=(0, 0), size=(x_size*x_scale, y_size*y_scale),
            color=[1,1,1], colorSpace='rgb', opacity=1,
            flipHoriz=False, flipVert=False,
            texRes=128, interpolate=True, depth=-4.0)
        
        # Initialize components for Routine "rectangle"
        rectangleClock = core.Clock()
        text = visual.TextStim(win=win, name='text',
            text='This shape should be a 10 cm square.\n\nPress space to continue',
            font='Arial',
            units='norm', pos=(0, -.8), height=0.1, wrapWidth=1.5, ori=0, 
            color='white', colorSpace='rgb', opacity=1, 
            languageStyle='LTR',
            depth=0.0);
        polygon = visual.Rect(
            win=win, name='polygon',
            width=[1.0, 1.0][0], height=[1.0, 1.0][1],
            ori=0, pos=(0, 0),
            lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
            fillColor=[1,1,1], fillColorSpace='rgb',
            opacity=1, depth=-1.0, interpolate=True)
        key_resp = keyboard.Keyboard()
        
        # Create some handy timers
        routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 
        
        # ------Prepare to start Routine "screen_scale"-------
        continueRoutine = True
        # update component parameters for each repeat
        # keep track of which components have finished
        screen_scaleComponents = [text_top, text_bottom, ccimage]
        for thisComponent in screen_scaleComponents:
            thisComponent.tStart = None
            thisComponent.tStop = None
            thisComponent.tStartRefresh = None
            thisComponent.tStopRefresh = None
            if hasattr(thisComponent, 'status'):
                thisComponent.status = NOT_STARTED
        # reset timers
        t = 0
        _timeToFirstFrame = win.getFutureFlipTime(clock="now")
        screen_scaleClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
        frameN = -1
        
        # -------Run Routine "screen_scale"-------
        while continueRoutine:
            # get current time
            t = screen_scaleClock.getTime()
            tThisFlip = win.getFutureFlipTime(clock=screen_scaleClock)
            tThisFlipGlobal = win.getFutureFlipTime(clock=None)
            frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
            # update/draw components on each frame
            keys=event.getKeys()
            
            if len(keys):
                if t-oldt<.5:
                    dscale=5*dbase
                    oldt=t
                else:
                    dscale=dbase
                    oldt=t
                if 'space' in keys:
                    continueRoutine=False
                elif 'up' in keys:
                    y_scale=round((y_scale+dscale)*10000)/10000
                elif 'down' in keys:
                    y_scale=round((y_scale-dscale)*10000)/10000
                elif 'left' in keys:
                    x_scale=round((x_scale-dscale)*10000)/10000
                elif 'right' in keys:
                    x_scale=round((x_scale+dscale)*10000)/10000
                screen_height=round(vsize*10/y_scale)/10
                text_bottom.text='X Scale = '+str(x_scale)+unittext+' per cm, Y Scale = '+str(y_scale)+unittext+' per cm\nScreen height = '+str(screen_height)+' cm\n\nPress the space bar when done'
                ccimage.size=[x_size*x_scale, y_size*y_scale]
                
            
            # *text_top* updates
            if text_top.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                text_top.frameNStart = frameN  # exact frame index
                text_top.tStart = t  # local t and not account for scr refresh
                text_top.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(text_top, 'tStartRefresh')  # time at next scr refresh
                text_top.setAutoDraw(True)
            
            # *text_bottom* updates
            if text_bottom.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                text_bottom.frameNStart = frameN  # exact frame index
                text_bottom.tStart = t  # local t and not account for scr refresh
                text_bottom.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(text_bottom, 'tStartRefresh')  # time at next scr refresh
                text_bottom.setAutoDraw(True)
            
            # *ccimage* updates
            if ccimage.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                ccimage.frameNStart = frameN  # exact frame index
                ccimage.tStart = t  # local t and not account for scr refresh
                ccimage.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(ccimage, 'tStartRefresh')  # time at next scr refresh
                ccimage.setAutoDraw(True)
            
            
            # check if all components have finished
            if not continueRoutine:  # a component has requested a forced-end of Routine
                break
            continueRoutine = False  # will revert to True if at least one component still running
            for thisComponent in screen_scaleComponents:
                if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                    continueRoutine = True
                    break  # at least one component has not yet finished
            
            # refresh the screen
            if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
                win.flip()
        
        # -------Ending Routine "screen_scale"-------
        for thisComponent in screen_scaleComponents:
            if hasattr(thisComponent, "setAutoDraw"):
                thisComponent.setAutoDraw(False)

        # the Routine "screen_scale" was not non-slip safe, so reset the non-slip timer
        routineTimer.reset()
        
        # ------Prepare to start Routine "rectangle"-------
        continueRoutine = True
        # update component parameters for each repeat
        polygon.setSize((10*x_scale, 10*y_scale))
        key_resp.keys = []
        key_resp.rt = []
        _key_resp_allKeys = []
        # keep track of which components have finished
        rectangleComponents = [text, polygon, key_resp]
        for thisComponent in rectangleComponents:
            thisComponent.tStart = None
            thisComponent.tStop = None
            thisComponent.tStartRefresh = None
            thisComponent.tStopRefresh = None
            if hasattr(thisComponent, 'status'):
                thisComponent.status = NOT_STARTED
        # reset timers
        t = 0
        _timeToFirstFrame = win.getFutureFlipTime(clock="now")
        rectangleClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
        frameN = -1
        
        # -------Run Routine "rectangle"-------
        while continueRoutine:
            # get current time
            t = rectangleClock.getTime()
            tThisFlip = win.getFutureFlipTime(clock=rectangleClock)
            tThisFlipGlobal = win.getFutureFlipTime(clock=None)
            frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
            # update/draw components on each frame
            
            # *text* updates
            if text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                text.frameNStart = frameN  # exact frame index
                text.tStart = t  # local t and not account for scr refresh
                text.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(text, 'tStartRefresh')  # time at next scr refresh
                text.setAutoDraw(True)
            
            # *polygon* updates
            if polygon.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                polygon.frameNStart = frameN  # exact frame index
                polygon.tStart = t  # local t and not account for scr refresh
                polygon.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(polygon, 'tStartRefresh')  # time at next scr refresh
                polygon.setAutoDraw(True)
            
            # *key_resp* updates
            waitOnFlip = False
            if key_resp.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                key_resp.frameNStart = frameN  # exact frame index
                key_resp.tStart = t  # local t and not account for scr refresh
                key_resp.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(key_resp, 'tStartRefresh')  # time at next scr refresh
                key_resp.status = STARTED
                # keyboard checking is just starting
                waitOnFlip = True
                win.callOnFlip(key_resp.clock.reset)  # t=0 on next screen flip
                win.callOnFlip(key_resp.clearEvents, eventType='keyboard')  # clear events on next screen flip
            if key_resp.status == STARTED and not waitOnFlip:
                theseKeys = key_resp.getKeys(keyList=['space'], waitRelease=False)
                _key_resp_allKeys.extend(theseKeys)
                if len(_key_resp_allKeys):
                    key_resp.keys = _key_resp_allKeys[-1].name  # just the last key pressed
                    key_resp.rt = _key_resp_allKeys[-1].rt
                    # a response ends the routine
                    continueRoutine = False
            
            # check if all components have finished
            if not continueRoutine:  # a component has requested a forced-end of Routine
                break
            continueRoutine = False  # will revert to True if at least one component still running
            for thisComponent in rectangleComponents:
                if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                    continueRoutine = True
                    break  # at least one component has not yet finished
            
            # refresh the screen
            if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
                win.flip()
        
        # -------Ending Routine "rectangle"-------
        for thisComponent in rectangleComponents:
            if hasattr(thisComponent, "setAutoDraw"):
                thisComponent.setAutoDraw(False)
        # the Routine "rectangle" was not non-slip safe, so reset the non-slip timer
        routineTimer.reset()
        
        # Flip one final time so any remaining win.callOnFlip() 
        # and win.timeOnFlip() tasks get executed before quitting
        win.flip()
        