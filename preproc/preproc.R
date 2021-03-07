
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
  
  dat<- plyr::rbind.fill(dat, t) # combine with available dataset
  cat(sprintf("sub %g: %g columns\n", i, nrow(t))) # output rows for monitoring
  
}


### DEMOGRAPHIC DATA:
d<- subset(dat, sender== "Demography form") # extract demographic data
dem<- data.frame("subject" = d$subject, "gender"= d$gender, "age"= d$age) # only info we need
write.csv(dem, "data/demographic_data.csv", row.names = F) # save device info


### DEVICE DATA:
device<- LabJs_device(dat) # extract devide info from lab.js
write.csv(device, "data/device_info.csv", row.names = F) # save device info


### QUESTION ACCURACY DATA:
dat$accuracy<- ifelse(dat$correct==TRUE, 1, 0) # convert accuracy to binomial data:

q<- subset(dat, is.element(sender, c("Question 1","Question 2"))) # extract just questions
q<- q[, c("subject","item", "Provo_ID", "accuracy", "duration",   # save just columns we need
          "ended_on", "response", "correctResponse")]
write.csv(q, "data/question_accuracy.csv", row.names = F) # save accuracy data


### REACTION TIME DATA:
rt<- subset(dat, sender== "screen") # subset reaction time data
rt<- rt[, c("subject", "item", "Provo_ID", "word", "word_ID",  # save just columns we need
            "ended_on", "duration" )]
rt<- subset(rt, item<20) # remove practice items
write.csv(rt, "data/reaction_time.csv", row.names = F) # save accuracy data


### MUSIC RATING DATA:
rating1<- subset(dat, is.element(sender, c("Likert 1","Likert 2", "Likert 3",
                                           "Likert 4", "Likert 5", "Likert 6")))
rating1$song_number<- get_num(rating1$sender)
rating1<- rating1[, c("subject", "song_number", "familiarity", "preference", 
                      "pleasantness", "offensiveness", "distraction" )]

rating2<- subset(dat, is.element(sender, c("Names 1","Names 2", "Names 3",
                                           "Names 4", "Names 5", "Names 6")))
rating2<- rating2[, c("subject", "artist_name", "song_name")]

rating<- merge(rating1, rating2) # merge different forms
write.csv(rating, "data/music_ratings.csv", row.names = F) # save accuracy data


aggregate(rt$duration, by= list(rt$item), FUN= mean, na.rm=T)



