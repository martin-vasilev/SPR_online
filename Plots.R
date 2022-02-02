
rm(list = ls())


########################
# MUSIC FREQUENCY PLOT #
########################

library(readr)
library(ggplot2)

music <- read_csv("Experiment1a/data/music_preferences.csv")

for(i in 4:(length(music)-1)){
  
  music[, i]<- ifelse(music[, i]==TRUE, 1, 0) 
  
}

music2<- music[, 4:24]

freq<-NA

for(i in 1: length(music2)){
  freq[i]<- sum(music2[,i])
  
}

mp<- data.frame("genre"= colnames(music2), frequency= freq)


# fix some labels:
mp$genre[which(mp$genre== "Hip.Hop")]<- "Hip Hop" 
mp$genre[which(mp$genre== "Musical.Film")]<- "Musical/ Film" 
mp$genre[which(mp$genre== "New.age")]<- "New age" 
mp$genre[which(mp$genre== "R.B")]<- "R&B" 


mp$frequency<- (mp$frequency/204)*100






z= ggplot(mp, aes(frequency, genre, label = paste(round(frequency, 1), ' %', sep=''))) +
  geom_segment(aes(x = 0, y = genre, xend = frequency, yend = genre), color = "orange") +
  geom_point(size=2, color= 'orange') +
  geom_text(nudge_x = 8)+
  xlim(0, 100)+
  xlab('Participants who usually listen to music genre (%)')+
  theme_light()

ggsave(filename = 'Plots/music_preferences.pdf', plot = z)
