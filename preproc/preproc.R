
rm(list= ls())


get_num<- function(string){as.numeric(unlist(gsub("[^0-9]", "", unlist(string)), ""))}
source("https://raw.githubusercontent.com/martin-vasilev/R_scripts/master/LabJs_device.R")

library(readr)

files<- list.files("data/raw") # get all available files in directory
files<-paste("data/raw/", files, sep= '') # paste full root link

dat<- NULL

for(i in 1:length(files)){ # for each participant file..
  t<- suppressWarnings(suppressMessages(read_csv(files[i]))) # load it up
  t$subject<- i # assign subject number

  # get experiment duration:
  start<- substr(t$timestamp[1], 12, 19)
  end<-  substr(t$timestamp[nrow(t)], 12, 19)
  duration<- sprintf("%g", strptime(end, "%H:%M:%S")- strptime(start, "%H:%M:%S"))
  
  cat(sprintf("sub %g: %g columns\n", i, nrow(t))) # output rows for monitoring
  cat(sprintf("Experiment time: %s (min)\n\n", duration))
  t$exp_time<- as.numeric(duration)
  
  ## trap accuracy:
  trap<- subset(t, sender== "trap_trial")
  
  trap$accuracy<- ifelse(trap$correct==TRUE, 1, 0)
  t$trap_accuracy<- sum(trap$accuracy)/4
  t$which_list= t$list[which(!is.na(t$list))[1]]
  
  dat<- plyr::rbind.fill(dat, t) # combine with available dataset
  
}


### DEMOGRAPHIC DATA:
d<- subset(dat, sender== "Demography form") # extract demographic data
honesty<- subset(dat, sender== "wore_headphones")
dem<- data.frame("subject" = d$subject, "gender"= d$gender, "age"= d$age, 
                 "list"= d$which_list, 
                 "experiment_time"= d$exp_time,
                 "trap_accuracy"= d$trap_accuracy,
                 "honesty"= honesty$response) # only info we need
write.csv(dem, "data/demographic_data.csv", row.names = F) # save device info


### DEVICE DATA:
device<- LabJs_device(dat) # extract devide info from lab.js
write.csv(device, "data/device_info.csv", row.names = F) # save device info


### QUESTION ACCURACY DATA:
dat$accuracy<- ifelse(dat$correct==TRUE, 1, 0) # convert accuracy to binomial data:

q<- subset(dat, is.element(sender, c("Question 1","Question 2"))) # extract just questions
q<- q[, c("subject","item", "Provo_ID", "list", "accuracy", "duration",   # save just columns we need
          "sound", "ended_on", "response", "correctResponse")]
q<- subset(q, item<20) # remove practice

write.csv(q, "data/question_accuracy.csv", row.names = F) # save accuracy data


### REACTION TIME DATA:
rt<- subset(dat, sender== "screen") # subset reaction time data
rt<- rt[, c("subject", "item", "Provo_ID", "list", "word", "word_ID",  # save just columns we need
            "ended_on", "duration", "sound")]
rt<- subset(rt, item<20) # remove practice items

rt<- subset(rt, ended_on== "response")

write.csv(rt, "data/reaction_time.csv", row.names = F) # save accuracy data


### MUSIC RATING DATA:
ratings<- subset(dat, sender == "song_ratings")

ratings<- ratings[, c("subject", "song_rating", "snippet_file", "familiarity",
                      "preference", "pleasantness", "offensiveness", 
                      "distraction", "artist_name", "song_name" )]
write.csv(ratings, "data/music_ratings.csv", row.names = F) # save accuracy data


### TRIAL DURATIONS

trial_time<- subset(dat, is.element(sender, c(paste("Item ", 1:12, sep= ''))))

trial_time<- trial_time[, c("subject", "sender", "duration"),]


table(dem$list)
table(q$item, q$sound)
table(rt$item, rt$sound)

#rt<- rt[which(rt$duration>100 & rt$duration<5000), ]

aggregate(rt$duration, by= list(rt$sound),  FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                               sd = sd(x, na.rm=T) ))

sub<- aggregate(rt$duration, by= list(rt$sound, rt$subject),  FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                                     sd = sd(x, na.rm=T) ))

aggregate(q$accuracy, by= list(q$sound),  FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                             sd = sd(x, na.rm=T) ))
hist(rt$duration, breaks= 50)
