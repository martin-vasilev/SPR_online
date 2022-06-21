
rm(list= ls())


get_num<- function(string){as.numeric(unlist(gsub("[^0-9]", "", unlist(string)), ""))}
source("https://raw.githubusercontent.com/martin-vasilev/R_scripts/master/LabJs_device.R")

get_time<- function(string){
  time_string<- unlist(strptime(string, format = "%Y-%m-%dT%H:%M:%S"))
  h<- as.numeric(time_string[3])
  m<- as.numeric(time_string[2])
  s<- as.numeric(time_string[1])
  
  time<- h*60*60 + m*60 + s 
  
  return(time)
}


library(readr)

files<- list.files("Experiment1b/data/raw") # get all available files in directory
files<-paste("Experiment1b/data/raw/", files, sep= '') # paste full root link

dat<- NULL

block<- NULL

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
  
  #string_file<-substr(x= files[i], start = 23, stop = 30) 
  
  t$Pool<-  "University pool"
  
  t$filename<- files[i]
  
  
  t$new_time<- NA
  
  for(j in 1:nrow(t)){
    t$new_time[j]<- get_time(t$timestamp[j])
  }
  
  
  
  dat<- plyr::rbind.fill(dat, t) # combine with available dataset
  
  
  
  #### Figure out block times for subject:
  h<- subset(t, sender== "Standby") # standby screen is when music starts playing
  start<- h$time_show
  
  be<-  t[which(t$sender== "Trap_instruction")[2:4]-1, ]
  
  block_time<- be$time_end - start
  #block_string<- substr(be$sender, 10, nchar(be$sender))
  
  t_b<- data.frame("subject"= rep(i, length(block_time)), 
                   "block_number"= 1:length(block_time),
                   "sound"= NA,
                   "list"= h$which_list,
                   "block_time"= block_time)
  t_b$block_time_s<- t_b$block_time/1000
  t_b$block_time_m<- t_b$block_time_s/60
  
  t_b$block_start<- h$new_time
  
  if(t$which_list[1]== "A" | t$which_list[1]== "D"){
    t_b$sound<- c("Silence", "Lyrical", "Instrumental")
  }
  
  if(t$which_list[1]== "B" | t$which_list[1]== "E"){
    t_b$sound<- c("Lyrical", "Instrumental", "Silence")
  }
  
  if(t$which_list[1]== "C" | t$which_list[1]== "FALSE"){
    t_b$sound<- c("Instrumental", "Silence", "Lyrical")
  }
  
  block<- rbind(block, t_b)
  
}


### BLOCK INFORMATION:
block$list[which(block$list=="FALSE")]= "F"

write.csv(block, "Experiment1b/data/block_info.csv", row.names = F) # save block info data




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




### QUESTION ACCURACY DATA:
dat$accuracy<- ifelse(dat$correct== "true", 1, 0) # convert accuracy to binomial data:

q<- subset(dat, is.element(sender, c("Question 1","Question 2"))) # extract just questions
q<- q[, c("subject","item", "Provo_ID", "list", "accuracy", "duration",   # save just columns we need
          "sound", "ended_on", "response", "correctResponse", "Pool")]

q$item_quest<- rep(c(1,2), nrow(q)/2)

q$list[which(q$list=="FALSE")]= "F"

q<- subset(q, item<20) # remove practice
a= aggregate(q$accuracy, by= list(q$subject), FUN= function(x) c(mean = mean(x, na.rm= T),                                                               sd = sd(x, na.rm=T) ))
a$x


### REACTION TIME DATA:
rt<- subset(dat, sender== "screen") # subset reaction time data
rt<- rt[, c("subject", "item", "Provo_ID", "list", "word", "word_ID",  # save just columns we need
            "ended_on", "duration", "sound", "Pool", "new_time")]
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

nstart<- nrow(rt)

# remove identified trials:
rt<- rt[-which(rt$subject==117 & rt$item==10),]
q<- q[-which(q$subject==117 & q$item==10),]

ntrials<- nrow(rt)

cat(sprintf("Trial data loss %g percent", ((nstart- ntrials)/nstart)*100))


rt<- rt[which(rt$duration>100 & rt$duration<5000), ] # remove RT outliers (pre-reg)

noutliers<- nrow(rt)

cat(sprintf("Outlier data loss %g percent", ((nstart- noutliers)/nstart)*100))

cat(sprintf(" %g percent data left", ((nrow(rt)/nstart)*100))) 

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



################################################
##      Add music ratings to data frames       #
################################################


# We want to use the ratings only fot the songs that were actually heard!
# Therefore, we need to find the max song that was played in each block...

block$max_song<- NA
block$first_start<-NA
block$second_start<-NA
block$third_start<-NA

library(readxl)
song_stamps <- read_excel("Experiment1a/preproc/song_stamps.xlsx")


for(i in 1:nrow(block)){
  
  if(block$sound[i]== "Silence"){ # skip silent blocks
    next
  }else{
    
    which_row<- which(song_stamps$Music== block$sound[i] & song_stamps$List== block$list[i])
    
    
    if(block$block_time_s[i]<= song_stamps$first[which_row]){
      
      block$max_song[i]<- 1
      block$first_start[i]<- song_stamps$first[which_row]
    }else{
      
      if(block$block_time_s[i]<= song_stamps$second[which_row]){
        
        block$max_song[i]<- 2
        block$first_start[i]<- song_stamps$first[which_row]
        block$second_start[i]<- song_stamps$second[which_row]
        
      }else{
        block$max_song[i]<- 3
        block$first_start[i]<- song_stamps$first[which_row]
        block$second_start[i]<- song_stamps$second[which_row]
        block$third_start[i]<- song_stamps$third[which_row]
      }
      
    }
    
    
  }
  
  
  
  
}



#######
## add block start to rt data frame:

rt$block_start<- NA
rt$first<- NA
rt$second<-NA
rt$third<-NA
block$sound<- tolower(block$sound)

for(i in 1:nrow(rt)){
  
  a<- which(block$subject== rt$subject[i] & block$sound== rt$sound[i])  
  rt$block_start[i]<- block$block_start[a]
  rt$first[i]<- block$first_start[a]
  rt$second[i]<- block$second_start[a]
  rt$third[i]<- block$third_start[a]
}


#table(rt$block_start)

rt$t_since_block<- rt$new_time- (rt$block_start-7)


## load song ratings by subject:

music_preferences <- read_csv("Experiment1b/data/music_preferences.csv")
ratings <- read.csv("Experiment1b/data/prep/ratings_manual_coding.csv", sep=";")


# create empty columns:
rt$familiarity <- NA
rt$preference <- NA
rt$pleasantness <- NA
rt$offensiveness <- NA
rt$distraction <- NA
rt$accuracy_artist<- NA
rt$accuracy_song<- NA
rt$music_frequency<- NA


for(i in 1:nrow(rt)){
  
  if(rt$sound[i]== "silence"){
    rt$music_frequency[i]<- music_preferences$music_frequency[which(music_preferences$subject== rt$subject[i])]
    next
  }else{
    # music conditions which have ratings..
    
    which_song<- NA
    
    if(rt$t_since_block[i]<= rt$first[i]){
      which_song<- 1
    }else{
      
      if(rt$t_since_block[i]<= rt$second[i]){
        which_song<- 2
      }else{
        
        if(rt$t_since_block[i]<= rt$third[i]){
          which_song<- 2
        }
        
      }
      
      
    }
    
    s<- subset(ratings, subject== rt$subject[i] & music== rt$sound[i] & song_number== which_song)
    
    
    rt$familiarity[i] <- s$familiarity
    rt$preference[i] <- s$preference
    rt$pleasantness[i] <- s$pleasantness
    rt$offensiveness[i] <- s$offensiveness
    rt$distraction[i] <- s$distraction
    rt$accuracy_artist[i] <- s$accuracy_artist
    rt$accuracy_song[i] <- s$accuracy_song
    
    rt$music_frequency[i]<- music_preferences$music_frequency[which(music_preferences$subject== rt$subject[i])]
    
  }
  
  
  
}

rt$new_time<- NULL
rt$block_start<- NULL
#rt$t_since_block<- NULL
rt$first<- NULL
rt$second<- NULL
rt$third<- NULL


#### save RT & accuracy data:
write.csv(rt, "Experiment1b/data/reaction_time.csv", row.names = F) # save accuracy data
write.csv(q, "Experiment1b/data/question_accuracy.csv", row.names = F) # save accuracy data


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
