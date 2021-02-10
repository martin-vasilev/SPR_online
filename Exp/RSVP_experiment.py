# -*- coding: utf-8 -*-
"""
Created on Wed Jun 21 19:58:47 2017

@author: Martin Vasilev
"""

from constants import * # all experiment settings
from stimuli import *
from psychopy.visual import Window, TextStim, BufferImageStim
from psychopy import gui
from psychopy.core import wait, Clock
from psychopy.event import waitKeys, Mouse, getKeys
from psychopy.sound import Sound
from psychopy import core
import os

if not os.path.exists('Data'):
    os.makedirs('Data')

#--------------------
# Experiment set-up:
#--------------------

expSetup = {'Participant': '',
           'Condition (Randomize)': ''}
dlg = gui.DlgFromDict(dictionary=expSetup, title= 'Run experiment: '+ expName)
filename= 'Data/RSVP'+ expSetup['Participant']

# load design for this participant:
design = genDesign(int(expSetup['Condition (Randomize)']))

# open file for saving data:	
log = open(filename + '.txt', 'w')


# define a header
header = ['sub', 'item', 'cond', 'sound', 'block', \
         'trialtype', 'ans1', 'corr_ans1', 'acc1', 'ans2', 'corr_ans2', 'acc2',\
         'Q1time', 'Q2time']

# make all values in the header into strings
line = map(str, header)
# join all string values into one string, separated by tabs:
line = '\t'.join(line)
# add a newline ('\n') to the string
line += '\n'
log.write(line)

# open window:
win=  Window(size=DISPSIZE, units= 'pix', fullscr= useFullscreen, color= BGC)

myMouse = Mouse(win) # create a mouse object
myMouse.setVisible(0) # make the mouse invisible

globalClock= Clock()

# calculate inter stimulus interval (ISI) from words per minute
wps = wpm / 60.0 
isi = 1.0/wps 


#------------------
#  Instructions:
#------------------

Instructions(win)

Practice(win, globalClock, log)

#------------------
#     Trials:
#------------------

for i in range(0, ntrials):

	PrepText = TextStim(win=win, ori=0, name='RSVP Text',
	                               text="Press any key to start the next paragraph", font=Font,
	                               pos=[0, 0], height= 24,
	                               color=FGC, colorSpace=u'rgb',
	                                antialias=True, wrapWidth=DISPSIZE[0]) 

#	StartText = TextStim(win=win, ori=0, name='RSVP Text',
#	                               text="Press any key to start", font=Font,
#	                               pos=[0, -200], height= 24,
#	                               color=FGC, colorSpace=u'rgb',
#	                                antialias=True, wrapWidth=DISPSIZE[0]) 																																
	PrepText.draw()
	win.flip()																									
			
	print(design[i])
	item= int(design[i][0])
	cond= int(design[i][1])
	words= P[item-1]
	fullstops = [it for it in range(len(words)) if words[it].endswith('.')]
	#word_buffer = list()
	
	#RSVPTextStim = TextStim(win=win, ori=0, name='RSVP Text',
	#                               text="test", font=Font,
	#                               pos=[0, 0],
	#                               color=FGC, colorSpace=u'rgb', opacity=0.0,
	#                                antialias=True, height= 24, units= 'pix')    
	
	#for word in words:
	#	RSVPTextStim.setOpacity(1.0)
	#	RSVPTextStim.setText(word)
	#	word_buffer.append(BufferImageStim(win,stim=[RSVPTextStim], rect=(-1,1,1,-1)))
	
	# assign sound condition for trial:
	if (cond>1 and cond<5) or (cond>5):
		sound= Sound(design[i][3]+'.wav') 
		soundPlay= True
	else:
		soundPlay= False
	first= True # present sound simultaneously with first word
		
	# draw fixation cross:		
	fixCross = TextStim(win=win, ori=0, name='RSVP Text',
	                               text="+", font=Font,
	                               pos=[0, 0], height= 24,
	                               color=FGC, colorSpace=u'rgb',
	                                antialias=True)
	PrepText.draw()																																
#	StartText.draw()
	win.flip()
	resplist = waitKeys(maxWait=float(10*60))																																	
																																	
	win.clearBuffer()
	win.flip()
	wait(1)
																																	
	fixCross.draw()
	win.flip()
	wait(0.5)																															
	win.clearBuffer()
	win.flip()
	
	n=-1
	#for buffered_word in word_buffer:
	for j in range(0, len(words)):	
		n=n++1
		#buffered_word.draw()
		RSVPTextStim = TextStim(win=win, ori=0, name='RSVP Text',
	                               text=words[j], font=Font,
	                               pos=[0, 0],
	                              color=FGC, colorSpace=u'rgb', opacity=1,
	                               antialias=True, height= 24, units= 'pix')
		RSVPTextStim.draw()																														
		win.flip()
		if first and soundPlay:
			sound.play()
			first= False
		wait(isi)
		if n in fullstops:
			win.clearBuffer() # clear screen
			win.flip()
			wait(wrapUpWait) # wait at the end of sentence
	      
	if soundPlay:
		sound.stop()
		
	win.clearBuffer()
	win.flip()

	if cond<5:
		# Question 1:
		Q1start= globalClock.getTime()	
		ans1= Question(win, QE1[item-1], ['1) Yes', '2) No'], log, globalClock)
		Q1time= globalClock.getTime() - Q1start
		ans1= map(int, ans1)
		wait(1)
        
		# Question 2:
		Q2start= globalClock.getTime()	
		ans2= Question(win, QE2[item-1], ['1) Yes', '2) No'], log, globalClock)
		Q2time= globalClock.getTime() - Q2start
		ans2= map(int, ans2)		
	else:
		# Question 1:
		Q1start= globalClock.getTime()
		ans1= Question(win, QD1[item-1], QD1opts[item-1],log, globalClock, multiple=True)
		Q1time= globalClock.getTime() - Q1start
		ans1= map(int, ans1)
		wait(1)
		
		# Question 2:
		Q2start= globalClock.getTime()
		ans2= Question(win, QD2[item-1], QD2opts[item-1], log, globalClock, multiple=True)
		Q2time= globalClock.getTime() - Q2start
		ans2= map(int, ans2)
	
	# Save variables:
	if cond<5:
		block= "easy"
		corr_ans1= AQE1[item-1]
		corr_ans2= AQE2[item-1]
	else:
		block= "difficult"
		corr_ans1= AQD1[item-1]
		corr_ans2= AQD2[item-1]
	
	if ans1[0]==corr_ans1:
		acc1=1
	else:
		acc1=0
		
	if ans2[0]==corr_ans2:
		acc2=1
	else:
		acc2=0
	
	if item>24:
		trialType= "Prac"
	else:
		trialType= "Exp"
		
	line = [int(expSetup['Participant']), item, cond, design[i][2], block, \
         trialType, ans1[0], corr_ans1, acc1, ans2[0], corr_ans2, acc2,\
									Q1time, Q2time]
	# turn all values into a string
	line = map(str, line)
	# merge all individual values into a single string, separated by tabs
	line = '\t'.join(line)
	# add a newline ('\n') to the string
	line += '\n'
	# write the data string to the log file
	log.write(line)
			
log.close() # close data file

taskFinished(win) # displays message to paricipants to get experimenter
win.close()
core.quit() 	