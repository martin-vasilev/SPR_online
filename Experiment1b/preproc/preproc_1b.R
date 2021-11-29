
rm(list= ls())


get_num<- function(string){as.numeric(unlist(gsub("[^0-9]", "", unlist(string)), ""))}
source("https://raw.githubusercontent.com/martin-vasilev/R_scripts/master/LabJs_device.R")

library(readr)

files<- list.files("Experiment1b/data/raw") # get all available files in directory
files<-paste("Experiment1b/data/raw/", files, sep= '') # paste full root link

dat<- NULL

for(i in 1:length(files)){ # for each participant file..
  t<- suppressWarnings(suppressMessages(read.csv(files[i]))) # load it up
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
  
  trap$accuracy<- ifelse(trap$correct== "true", 1, 0)
  t$trap_accuracy<- sum(trap$accuracy)/4
  
  
  q1<- subset(t, sender== "Question 1")
  t$which_list= q1$list[1]
  
  string_file<-substr(x= files[i], start = 10, stop = 17) 
  
  t$Pool<- ifelse(string_file== "PROLIFIC", "Prolific", "University pool")
  
  t$filename<- files[i]
  
  dat<- plyr::rbind.fill(dat, t) # combine with available dataset
  
}


### DEMOGRAPHIC DATA:
d<- subset(dat, sender== "Demography form") # extract demographic data
honesty<- subset(dat, sender== "wore_headphones")
dem<- data.frame("subject" = d$subject, "gender"= d$gender, "age"= d$age, 
                 "education"= d$education,
                 "list"= d$which_list, 
                 "experiment_time"= d$exp_time,
                 "trap_accuracy"= d$trap_accuracy,
                 "honesty"= honesty$response,
                 "subject_pool"= d$Pool,
                 "filename"= d$filename) # only info we need


dem$list[which(dem$list=="FALSE")]= "F"

write.csv(dem, "Experiment1b/data/participant_data.csv", row.names = F) # save device info


### DEVICE DATA:
device<- LabJs_device(dat) # extract devide info from lab.js
write.csv(device, "Experiment1b/data/device_info.csv", row.names = F) # save device info


### QUESTION ACCURACY DATA:
dat$accuracy<- ifelse(dat$correct== "true", 1, 0) # convert accuracy to binomial data:

q<- subset(dat, is.element(sender, c("Question 1","Question 2"))) # extract just questions
q<- q[, c("subject","item", "Provo_ID", "list", "accuracy", "duration",   # save just columns we need
          "sound", "ended_on", "response", "correctResponse", "Pool")]
#q<- subset(q, item<20) # remove practice

q$item_quest<- rep(c(1,2), nrow(q)/2)

q$list[which(q$list=="FALSE")]= "F"

q<- subset(q, item<20) # remove practice

write.csv(q, "Experiment1b/data/question_accuracy.csv", row.names = F) # save accuracy data


### REACTION TIME DATA:
rt<- subset(dat, sender== "screen") # subset reaction time data
rt<- rt[, c("subject", "item", "Provo_ID", "list", "word", "word_ID",  # save just columns we need
            "ended_on", "duration", "sound", "Pool")]
rt<- subset(rt, item<20) # remove practice items


rt<- subset(rt, word>0) # remove RT on first word in the passage (pre-reg)

rt$list[which(rt$list=="FALSE")]= "F"

 
# remove trials with >5 word timeouts (pre-reg):

nsubs<- unique(rt$subject)

for(i in 1:length(nsubs)){
  
  t<- subset(rt, subject==nsubs[i]) 
  
  nitems<- unique(t$item)
  
  for (j in 1:length(nitems)){
    n<- subset(t, item== nitems[j])
    
    a<- length(which(n$ended_on== "timeout"))
  #  cat(a); cat("\n")
    if(a>5){
      cat(sprintf("Subject %g, item % g\n", n$subject[1], n$item[1]))
    }
    
  }
  
}

# remove identified trials:
rt<- rt[-which(rt$subject==82 & rt$item==10),]
q<- q[-which(q$subject== 82 & q$item==10),]

rt<- rt[-which(rt$subject==96 & rt$item==3),]
q<- q[-which(q$subject==96 & q$item==3),]
# 
# rt<- rt[-which(rt$subject==61 & rt$item==10),]
# q<- q[-which(q$subject==61 & q$item==10),]
# 
# rt<- rt[-which(rt$subject==130 & rt$item==12),]
# q<- q[-which(q$subject==130 & q$item==12),]
# 
# rt<- rt[-which(rt$subject==146 & rt$item==3),]
# q<- q[-which(q$subject==146 & q$item==3),]

rt<- rt[which(rt$duration>100 & rt$duration<5000), ] # remove RT outliers (pre-reg)


# check remaining percentage of observations per subject:

a<- NULL

nsubs<- unique(rt$subject)

for(i in 1:length(nsubs)){
  
  n<- subset(rt, subject== nsubs[i])

  remain<- round((nrow(n)/ (801-15))*100,1)
  a<- c(a, remain)
  
  cat(sprintf("Subject %g:  %g percent \n", nsubs[i], remain))
      
}

sort(a)

rt$log_duration<- log(rt$duration) # add log-transform

write.csv(rt, "Experiment1b/data/reaction_time.csv", row.names = F) # save accuracy data


### MUSIC RATING DATA:
ratings<- subset(dat, sender == "song_ratings")

ratings<- ratings[, c("subject", "which_list", "song_rating", "snippet_file", "familiarity",
                      "preference", "pleasantness", "offensiveness", 
                      "distraction", "artist_name", "song_name", "Pool")]

ratings$which_list[which(ratings$which_list=="FALSE")]= "F"

### prep data:
ratings$music_set<- substr(x = ratings$snippet_file, start = 8, stop = 8)
ratings$music<- ifelse(substr(x = ratings$snippet_file, start = 11, stop = 17)== "lyrical",
                       "lyrical", "instrumental")

ratings$song_number<- substr(x = ratings$snippet_file, start = 9, stop = 9)
ratings$list<- ratings$which_list
ratings$which_list<- NULL


### Code actual song names:

ratings$actual_artist<- NA
ratings$actual_song_name<- NA

for(i in 1:nrow(ratings)){

  #############
  
  if(ratings$music[i]== "lyrical" & ratings$song_number[i]== "1" & ratings$music_set[i]== "A"){
    ratings$actual_artist[i]<- "Eminem"
    ratings$actual_song_name[i]<- "The way I am"
  }
  
  if(ratings$music[i]== "lyrical" & ratings$song_number[i]== "2" & ratings$music_set[i]== "A"){
    ratings$actual_artist[i]<- "Post Malone"
    ratings$actual_song_name[i]<- "WoW"
  }
  
  if(ratings$music[i]== "lyrical" & ratings$song_number[i]== "3" & ratings$music_set[i]== "A"){
    ratings$actual_artist[i]<- "Nicki Minaj (feat. Rihanna)"
    ratings$actual_song_name[i]<- "Fly"
  }
  
  if(ratings$music[i]== "instrumental" & ratings$song_number[i]== "1" & ratings$music_set[i]== "A"){
    ratings$actual_artist[i]<- "Eminem"
    ratings$actual_song_name[i]<- "The way I am"
  }
  
  if(ratings$music[i]== "instrumental" & ratings$song_number[i]== "2" & ratings$music_set[i]== "A"){
    ratings$actual_artist[i]<- "Post Malone"
    ratings$actual_song_name[i]<- "WoW"
  }
  
  if(ratings$music[i]== "instrumental" & ratings$song_number[i]== "3" & ratings$music_set[i]== "A"){
    ratings$actual_artist[i]<- "Nicki Minaj (feat. Rihanna)"
    ratings$actual_song_name[i]<- "Fly"
  }
  
  
  
  #############
  
  if(ratings$music[i]== "lyrical" & ratings$song_number[i]== "1" & ratings$music_set[i]== "B"){
    ratings$actual_artist[i]<- "Jessie J (feat. B.o.B)"
    ratings$actual_song_name[i]<- "Price tag"
  }
  
  if(ratings$music[i]== "lyrical" & ratings$song_number[i]== "2" & ratings$music_set[i]== "B"){
    ratings$actual_artist[i]<- "Iggy Azalea (ft. Charli XCX)"
    ratings$actual_song_name[i]<- "Fancy"
  }
  
  if(ratings$music[i]== "lyrical" & ratings$song_number[i]== "3" & ratings$music_set[i]== "B"){
    ratings$actual_artist[i]<- "Outkast"
    ratings$actual_song_name[i]<- "Ms. Jackson"
  }
  
  
  if(ratings$music[i]== "instrumental" & ratings$song_number[i]== "1" & ratings$music_set[i]== "B"){
    ratings$actual_artist[i]<- "Jessie J (feat. B.o.B)"
    ratings$actual_song_name[i]<- "Price tag"
  }
  
  if(ratings$music[i]== "instrumental" & ratings$song_number[i]== "2" & ratings$music_set[i]== "B"){
    ratings$actual_artist[i]<- "Iggy Azalea (ft. Charli XCX)"
    ratings$actual_song_name[i]<- "Fancy"
  }
  
  if(ratings$music[i]== "instrumental" & ratings$song_number[i]== "3" & ratings$music_set[i]== "B"){
    ratings$actual_artist[i]<- "Outkast"
    ratings$actual_song_name[i]<- "Ms. Jackson"
  }
    
}

colnames(ratings)

r<- ratings[, c("subject", "list", "music", "song_number", "music_set", "snippet_file",  "Pool",
                "familiarity", "preference", "pleasantness", "offensiveness", 
                "distraction", "actual_artist", "actual_song_name",
                "artist_name", "song_name" )]


write.csv(r, "Experiment1b/data/prep/music_ratings_raw.csv", row.names = F) # save accuracy data


ratings <- read.csv("Experiment1b/data/prep/ratings_manual_coding.csv", sep=";")





### Music preferences:

genres<- subset(dat, sender== "Music styles")
genres<- genres[, c("subject", "Blues",  "Classical", "Country", "Dance", "Electronic", 
                    "Folk", "Gospel", "Hip.Hop", "Jazz", "Latin",
                    "Musical.Film", "New.age", "Pop", "R.B",
                    "Rap", "Reggae", "Religious", "Rock",  "Soul",
                    "Swing", "Traditional", "Pool")] # subset colums we need


freq<- subset(dat, sender== "Music_frequency")
freq<- freq[, c("subject", "music_frequency")]

preference <- merge(freq, genres) # merge two dataframes
write.csv(preference, "Experiment1b/data/music_preferences.csv") # save data

### TRIAL DURATIONS

trial_time<- subset(dat, is.element(sender, c(paste("Item ", 1:12, sep= ''))))

trial_time<- trial_time[, c("subject", "sender", "duration", "Pool"),]


table(dem$list)
table(q$item, q$sound)
table(rt$item, rt$sound)




# hist(ratings$familiarity, breaks= 10)
# hist(ratings$preference, breaks= 10)
#dem<- subset(dem, honesty==1 & trap_accuracy==1)
table(dem$list)

