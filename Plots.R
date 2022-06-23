
rm(list = ls())


########################
# MUSIC FREQUENCY PLOT #
########################

library(readr)
library(ggplot2)

###########
# Exp. 1a #
###########

music_1a <- read_csv("Experiment1a/data/music_preferences.csv")

for(i in 4:(length(music_1a)-1)){
  
  music_1a[, i]<- ifelse(music_1a[, i]==TRUE, 1, 0) 
  
}

music2_1a<- music_1a[, 4:24]

freq_1a<-NA

for(i in 1: length(music2_1a)){
  freq_1a[i]<- sum(music2_1a[,i])
  
}

mp_1a<- data.frame("genre"= colnames(music2_1a), frequency= freq_1a)


###########
# Exp. 1b #
###########

music_1b <- read_csv("Experiment1b/data/music_preferences.csv")

for(i in 4:(length(music_1b)-1)){
  
  music_1b[, i]<- ifelse(music_1b[, i]==TRUE, 1, 0) 
  
}

music2_1b<- music_1b[, 4:24]

freq_1b<-NA

for(i in 1: length(music2_1b)){
  freq_1b[i]<- sum(music2_1b[,i])
  
}

mp_1b<- data.frame("genre"= colnames(music2_1b), frequency= freq_1b)



###########
# Exp. 2  #
###########

music_2 <- read_csv("Experiment2/data/music_preferences.csv")

for(i in 4:(length(music_2)-1)){
  
  music_2[, i]<- ifelse(music_2[, i]==TRUE, 1, 0) 
  
}

music2_2<- music_2[, 4:24]

freq_2<-NA

for(i in 1: length(music2_2)){
  freq_2[i]<- sum(music2_2[,i])
  
}

mp_2<- data.frame("genre"= colnames(music2_2), frequency= freq_2)


###########
# Exp. 3  #
###########

music_3 <- read_csv("Experiment3/data/music_preferences.csv")

for(i in 4:(length(music_3)-1)){
  
  music_3[, i]<- ifelse(music_3[, i]==TRUE, 1, 0) 
  
}

music2_3<- music_3[, 4:24]

freq_3<-NA

for(i in 1: length(music2_3)){
  freq_3[i]<- sum(music2_3[,i])
  
}

mp_3<- data.frame("genre"= colnames(music2_3), frequency= freq_3)


### merge datasets:
mp_1a$Experiment<- "1a"
mp_1b$Experiment<- "1b"
mp_2$Experiment<- "2"
mp_3$Experiment<- "3"

mp<- rbind(mp_1a, mp_1b, mp_2, mp_3)


# fix some labels:
mp$genre[which(mp$genre== "Hip.Hop")]<- "Hip Hop" 
mp$genre[which(mp$genre== "Musical.Film")]<- "Musical/ Film" 
mp$genre[which(mp$genre== "New.age")]<- "New age" 
mp$genre[which(mp$genre== "R.B")]<- "R&B" 


mp$frequency[which(mp$Experiment!= "3")]<- (mp$frequency[which(mp$Experiment!= "3")]/204)*100
mp$frequency[which(mp$Experiment== "3")]<- (mp$frequency[which(mp$Experiment== "3")]/208)*100
#mp$frequency<- (mp$frequency/204)*100

# mp$genre = with(mp, reorder(genre, frequency))
# 
# z= ggplot(mp, aes(frequency, genre, label = paste(round(frequency, 1), ' %', sep=''))) +
#   geom_segment(aes(x = 0, y = genre, xend = frequency, yend = genre), color = "orange") +
#   geom_point(size=2, color= 'orange') +
#   geom_text(nudge_x = 8)+
#   xlim(0, 100)+
#   xlab('Participants who usually listen to music genre (%)')+
#   theme_light() + facet_wrap(. ~ Experiment, scales = "free_y") 

#ggsave(filename = 'Plots/music_preferences.pdf', plot = z)



library(tidytext)

z= mp %>%
  group_by(Experiment) %>%
  ungroup %>%
  mutate(Experiment = as.factor(Experiment),
         genre = reorder_within(genre, frequency, Experiment)) %>%
  
  ggplot(aes(frequency, genre, label = paste(round(frequency, 1), ' %', sep=''))) +
  geom_segment(aes(x = 0, y = genre, xend = frequency, yend = genre), color = "orange") +
  geom_point(size=2, color= 'orange') +
  geom_text(nudge_x = 13)+
  scale_x_continuous(expand = c(0,0)) +
  xlab('Participants who usually listen to music genre (%)')+
  theme_light(14)+
  facet_wrap(~Experiment, scales = "free_y") +
  xlim(0, 100)
  #scale_x_reordered()
  
ggsave(filename = 'Plots/music_preferences.pdf', plot = z, width = 10, height = 8)

