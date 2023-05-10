
rm(list= ls())

library(readr)

# Experiment 1a

rt <- read_csv("Experiment1a/data/reaction_time.csv")

nsub<- unique(rt$subject)
df<- NULL

for(i in 1:length(nsub)){
  n<- subset(rt, subject== nsub[i])
  nitems<- unique(n$item)
  
  for(j in 1:length(nitems)){
    m<- subset(n, item== nitems[j])
    
    time<- sum(m$duration) # in ms
    time<- time/1000 # in s
    time<- time/60 # in min
    
    nwords<- nrow(m) # number of words
    
    wpm<- nwords/time # words per minute
    
    t<- data.frame("subject"= m$subject[1], "item" = m$item[1],
                   "sound"= m$sound[1], "reading_time_minutes"= time,
                   "number_of_words"= nwords,
                   "wpm"= wpm, "Experiment"= "Experiment 1a")
    df<- rbind(df, t)
    
  }
  
}


# Experiment 1b

rt <- read_csv("Experiment1b/data/reaction_time.csv")

nsub<- unique(rt$subject)

for(i in 1:length(nsub)){
  n<- subset(rt, subject== nsub[i])
  nitems<- unique(n$item)
  
  for(j in 1:length(nitems)){
    m<- subset(n, item== nitems[j])
    
    time<- sum(m$duration) # in ms
    time<- time/1000 # in s
    time<- time/60 # in min
    
    nwords<- nrow(m) # number of words
    
    wpm<- nwords/time # words per minute
    
    t<- data.frame("subject"= m$subject[1], "item" = m$item[1],
                   "sound"= m$sound[1], "reading_time_minutes"= time,
                   "number_of_words"= nwords,
                   "wpm"= wpm, "Experiment"= "Experiment 1b")
    df<- rbind(df, t)
    
  }
  
}


# Experiment 2

rt <- read_csv("Experiment2/data/reaction_time.csv")

nsub<- unique(rt$subject)

for(i in 1:length(nsub)){
  n<- subset(rt, subject== nsub[i])
  nitems<- unique(n$item)
  
  for(j in 1:length(nitems)){
    m<- subset(n, item== nitems[j])
    
    time<- sum(m$duration) # in ms
    time<- time/1000 # in s
    time<- time/60 # in min
    
    nwords<- nrow(m) # number of words
    
    wpm<- nwords/time # words per minute
    
    t<- data.frame("subject"= m$subject[1], "item" = m$item[1],
                   "sound"= m$sound[1], "reading_time_minutes"= time,
                   "number_of_words"= nwords,
                   "wpm"= wpm, "Experiment"= "Experiment 2")
    df<- rbind(df, t)
    
  }
  
}


# Experiment 3

rt <- read_csv("Experiment3/data/reaction_time.csv")

nsub<- unique(rt$subject)

for(i in 1:length(nsub)){
  n<- subset(rt, subject== nsub[i])
  nitems<- unique(n$item)
  
  for(j in 1:length(nitems)){
    m<- subset(n, item== nitems[j])
    
    time<- sum(m$duration) # in ms
    time<- time/1000 # in s
    time<- time/60 # in min
    
    nwords<- nrow(m) # number of words
    
    wpm<- nwords/time # words per minute
    
    t<- data.frame("subject"= m$subject[1], "item" = m$item[1],
                   "sound"= m$sound[1], "reading_time_minutes"= time,
                   "number_of_words"= nwords,
                   "wpm"= wpm, "Experiment"= "Experiment 3")
    df<- rbind(df, t)
    
  }
  
}

write.csv(df, file= "reading_rate_data.csv")


a= aggregate(df$wpm, by= list(df$sound, df$Experiment), FUN= function(x) c(mean = mean(x, na.rm= T),   
                            sd = sd(x, na.rm=T) ))

