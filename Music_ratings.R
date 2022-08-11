
rm(list= ls())

# load data:

library(readr)
e1a <- read_delim("Experiment1a/data/prep/ratings_manual_coding.csv", 
                 delim = ";", escape_double = FALSE, trim_ws = TRUE)
e1a$...19<- NULL
e1a$...20<- NULL

e1b<- read_delim("Experiment1b/data/prep/ratings_manual_coding.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)


e2<- read_delim("Experiment2/data/prep/ratings_manual_coding.csv", 
                 delim = ",", escape_double = FALSE, trim_ws = TRUE)

e3<- read_delim("Experiment3/data/prep/ratings_manual_coding.csv", 
                delim = ";", escape_double = FALSE, trim_ws = TRUE)



# combine familiar music (1a & 1b):

# change subject ID numbers so that they are unique
e1b$subject<- e1b$subject +204 

familiar<- rbind(e1a, e1b)


# combine unfamiliar music (2 & 3):

# change subject ID numbers so that they are unique
e3$subject<- e3$subject +204 

unfamiliar<- rbind(e2, e3)


########################
# Statistical models:  #
########################


#----------------
# FAMILIAR SONGS
#----------------
library(lme4)
library(effects)

familiar$music<- as.factor(familiar$music)
contrasts(familiar$music) <- c(-0.5, 0.5)

# familiarity:
summary(M1<- lmer(familiarity ~ music +(1|subject) +(music|actual_song_name),
                  data= familiar, REML= T))
plot(effect('music', M1))


# preference:
summary(M2<- lmer(preference ~ music +(1|subject) +(music|actual_song_name),
                  data= familiar, REML= T))
plot(effect('music', M2))


# offensiveness:
summary(M3<- lmer(offensiveness ~ music +(1|subject) +(music|actual_song_name),
                  data= familiar, REML= T))
plot(effect('music', M3))


# distraction:
summary(M4<- lmer(distraction ~ music +(music|subject) +(music|actual_song_name),
                  data= familiar, REML= T))
plot(effect('music', M4))


### Song accuracy:
summary(M5<- glmer(accuracy_song ~ music +(music|subject) +(1|actual_song_name),
                  data= familiar, family= binomial))
plot(effect('music', M5))


### Artist accuracy:
summary(M6<- glmer(accuracy_artist ~ music +(music|subject) +(music|actual_song_name),
                   data= familiar, family= binomial))
plot(effect('music', M6))
