# -*- coding: utf-8 -*-
"""
Created on Wed Jun 21 19:59:29 2017

@author: Martin Vasilev
"""

#----------
# General: 
#----------
expName= "RSVP speech"
Lab= True

#-----------#
#  Screen:   
#-----------#
if Lab:
	DISPSIZE= (1920, 1080)	
else:
	DISPSIZE= (1366, 768)

BGC= (1, 1, 1) # background colour
FGC= (0,0,0)
useFullscreen= True


#------------#
#  Stimuli:   
#------------#
InstrTextSize= 24
Font= "Courier New"
wpm= 200
#wpm= 1000 # testing
height= 32,
wrap_width= 3,
ntrials=28
fontCross= 14
wrapUpWait= 0.5 # pause at the end of each sentence

#------------#
#  Functions:   
#------------#

def get_keys(window, escape_key = 'escape', lastKeyOnly = True):
    """ Every time you check for keys, also check for the escape key 
    automatically and quit if it is pressed."""    
    currentKeys = event.getKeys()
    if escape_key in currentKeys:
        window.close()        
        #core.quit()
    else:         
        if lastKeyOnly and len(currentKeys) > 1:
            currentKeys = currentKeys[-1] #only return last key pressed
        return(currentKeys) 


def Question(win, question, options, log, globalClock, escape_key = 'escape', DISPSIZE= (1366, 768), multiple=False, timeout=60):
	from psychopy import visual, event, core, iohub
	import sys
	reload(sys)
	sys.setdefaultencoding('utf8')
    
	if multiple:
		allowedResp= ['1', '2', '3', '4']
		ansText= "Please press 1,2,3, or 4 to choose the correct answer"
	else:
		allowedResp= ['1', '2']
		ansText= "Please press 1 or 2 to choose the correct answer"

	
	label = visual.TextStim(win, text="Question:", height=InstrTextSize, alignHoriz='center', font= Font,
		         color= FGC, pos= [0, DISPSIZE[1]/2- 100], bold=True, units='pix')
	label.draw()
  
	item = visual.TextStim(win, text=question, height=InstrTextSize, alignHoriz='left', font= Font,
		         color= FGC, pos= [-(DISPSIZE[0]/2)+100, DISPSIZE[1]/2- 200], units='pix', bold=True, wrapWidth=DISPSIZE[0])
	item.draw()
	
     # draw options:
						
	for i in range(0, len(options)):
		choice = visual.TextStim(win, text=options[i], height=InstrTextSize, alignHoriz='left', font= Font,
		         color= FGC, pos= [-(DISPSIZE[0]/2)+100, DISPSIZE[1]/2- 300- i*50], units='pix',wrapWidth=DISPSIZE[0] )
		choice.draw()
	
	ansPrompt= visual.TextStim(win, text= ansText,
			height=InstrTextSize, alignHoriz='center', font= "Time New Roman", italic=True,
			color= FGC, pos= [0, -300], units='pix',wrapWidth=DISPSIZE[0])
	ansPrompt.draw()
	
	win.flip()	
	answered= False
	trialStart= globalClock.getTime()
	
	while not answered:
		trialTime= globalClock.getTime()- trialStart
		pressed = event.getKeys()
		if any(i in pressed for i in allowedResp):
			answered=True
		if escape_key in pressed:
			#core.wait(1)
			#newpress= event.getKeys()
			resplist = event.waitKeys(maxWait=float(5))
			if 'y' in resplist:
				answered= True
				log.close()
				print("Experiment aborted")
				win.close()
				core.quit()
		if trialTime>timeout:
			answered= True
			return('0')
			  
	win.clearBuffer()
	win.flip()
	return(pressed)
	#resplist = waitKeys(maxWait=float('inf'))
											
def genDesign(start):

	design= []	
	with open('Design/P'+ str(start) +'.txt') as f:
	   for l in f:
		design.append(l.strip().split("\t"))
	design= design[1:len(design)]
	return(design)
	
def taskFinished(win):
	from psychopy import visual, core, event
	text = visual.TextStim(win, text="Task finished:\n\n\nPlease get the experimenter", height=InstrTextSize+10, alignHoriz='center', font= Font,
		         color= "darkred", bold=True, units='pix')
#	win.setColor([244, 113, 66])
#	win.flip()
	text.draw()
	win.flip()
	resplist = event.waitKeys(maxWait=float(60*60))
	
def Instructions(win):
	from psychopy.visual import TextStim
	from psychopy.event import waitKeys
	
	FileID= open('instructions.txt', 'r')
	Instring= FileID.read()
	Instring= Instring + '\n\n\n\n\t\t\t\t\t\t\t\t\tPress any key to continue'

	instrText = TextStim(win, text=Instring, height=InstrTextSize, alignHoriz='center', font= Font,
		         color= FGC, wrapWidth=1300)
	instrText.draw() # draw tp screen
	win.flip() 
	resplist = waitKeys(maxWait=float('inf'))
	
	
	# 2nd instruction screen:
	FileID2= open('instructions2.txt', 'r')
	Instring2= FileID2.read()
	Instring2= Instring2 + '\n\n\n\n\t\t\t\t\t\t\tPress any key when you are ready to start'
	instrText2 = TextStim(win, text=Instring2, height=InstrTextSize, alignHoriz='center', font= Font,
		         color= FGC, wrapWidth=1300)
	instrText2.draw() # draw tp screen
	win.flip() 		
	resplist = waitKeys(maxWait=float('inf'))
	
	# clear screen after instructions:
	win.clearBuffer()
	win.flip()

def Practice(win, globalClock, log, isi= 1.0/(200/60)):
	from psychopy.visual import TextStim, BufferImageStim
	from psychopy.core import wait
	from psychopy.event import waitKeys
	
	# practice sentence 1:
	Prac= []
	Prac.append(['All', 'of', 'their', 'most', 'dedicated', 'friends', 'accompanied',
			 'them', 'to', 'their', 'first', 'concert.'])
	Prac.append(['The', 'count', 'had', 'earned', 'high', 'regard', 'commanding',
			 'the', "king's", 'armies.'])
				
	Q= []
	Q.append('Were they accompanied by their parents?')
	Q.append("Had the count earned the king's regard in war?")	
	
	for i in range(0,2):
		words= Prac[i]
		
		RSVPTextStim = TextStim(win=win, ori=0, name='RSVP Text',
		                               text="test", font=Font,
		                               pos=[0, 0], height= 24,
		                               color=FGC, colorSpace=u'rgb', opacity=0.0,
		                                antialias=True)
		word_buffer = list()																							
		for word in words:
			RSVPTextStim.setOpacity(1.0)
			RSVPTextStim.setText(word)
			word_buffer.append(BufferImageStim(win,stim=[RSVPTextStim], rect=(-1,1,1,-1)))
		
		
		# fix cross:
		fixCross = TextStim(win=win, ori=0, name='RSVP Text',
		                               text="+", font=Font,
		                               pos=[0, 0], height= 24,
		                               color=FGC, colorSpace=u'rgb',
		                                antialias=True)
		fixCross.draw()
		win.flip()
		wait(0.5)																															
		win.clearBuffer()
		win.flip()
																																		
		##### RSVP presentation:
		for buffered_word in word_buffer:
			buffered_word.draw()
			win.flip()
			wait(isi)
	
		# clear buffer:	
		win.clearBuffer()
		win.flip()
		
		# Question 1:
		ans= Question(win, Q[i], ["1)Yes", "2)No"], log, globalClock, multiple=False)
		
	Instring= "This was the end of the practice." + '\n\n\n\nPress any key to start the experiment'

	instrText = TextStim(win, text=Instring, height=InstrTextSize, alignHoriz='center', font= Font,
		         color= FGC, wrapWidth=1300)
	instrText.draw() # draw tp screen
	win.flip() 
	resplist = waitKeys(maxWait=float('inf'))
		