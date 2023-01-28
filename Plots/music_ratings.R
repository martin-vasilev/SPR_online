
rm(list = ls())

library(reshape)
library(ggplot2)

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

fun_mean <- function(x){
  return(data.frame(y=mean(x),label= paste("M= ", round(mean(x,na.rm=T),1), sep= '')))}


######## Experiment 1a:

ratings1 <- read.csv("Experiment1a/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs1<- melt(ratings1, id=c('subject', 'music', 'song_number', 'music_set'), 
                measure=c("familiarity", 'preference', 'pleasantness',
                          'offensiveness', 'distraction', 
                          'accuracy_artist', 'accuracy_song'), na.rm=TRUE)
mSongs1<- cast(DesSongs1, music+song_number+music_set ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))

df1<-  data.frame("Mean"= c(mSongs1$familiarity_M, mSongs1$preference_M, mSongs1$pleasantness_M, 
                           mSongs1$offensiveness_M, mSongs1$distraction_M),
                 "SD"= c(mSongs1$familiarity_SD, mSongs1$preference_SD, mSongs1$pleasantness_SD, 
                         mSongs1$offensiveness_SD, mSongs1$distraction_SD),
                 "Measure"= c(rep("Familiarity", 12), rep("Preference", 12),
                              rep("Pleasantness", 12), rep("Offensiveness", 12),
                              rep("Distraction",12)),
                 "Music"= rep(mSongs1$music, 5))#,
#"Music"= rep(c("Instrumental", "Lyrical"), 5*204))
df1$Experiment<- "Experiment 1a"



######## Experiment 1b:

ratings2 <- read.csv("Experiment1b/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs2<- melt(ratings2, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c("familiarity", 'preference', 'pleasantness',
                           'offensiveness', 'distraction', 
                           'accuracy_artist', 'accuracy_song'), na.rm=TRUE)
mSongs2<- cast(DesSongs2, music+song_number+music_set ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))

df2<-  data.frame("Mean"= c(mSongs2$familiarity_M, mSongs2$preference_M, mSongs2$pleasantness_M, 
                            mSongs2$offensiveness_M, mSongs2$distraction_M),
                  "SD"= c(mSongs2$familiarity_SD, mSongs2$preference_SD, mSongs2$pleasantness_SD, 
                          mSongs2$offensiveness_SD, mSongs2$distraction_SD),
                  "Measure"= c(rep("Familiarity", 12), rep("Preference", 12),
                               rep("Pleasantness", 12), rep("Offensiveness", 12),
                               rep("Distraction",12)),
                  "Music"= rep(mSongs2$music, 5))#,

df2$Experiment<- "Experiment 1b"





######## Experiment 2:

ratings3 <- read.csv("Experiment2/data/prep/ratings_manual_coding.csv", sep=",")

DesSongs3<- melt(ratings3, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c("familiarity", 'preference', 'pleasantness',
                           'offensiveness', 'distraction', 
                           'accuracy_artist', 'accuracy_song'), na.rm=TRUE)
mSongs3<- cast(DesSongs3, music+song_number+music_set ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))

df3<-  data.frame("Mean"= c(mSongs3$familiarity_M, mSongs3$preference_M, mSongs3$pleasantness_M, 
                            mSongs3$offensiveness_M, mSongs3$distraction_M),
                  "SD"= c(mSongs3$familiarity_SD, mSongs3$preference_SD, mSongs3$pleasantness_SD, 
                          mSongs3$offensiveness_SD, mSongs3$distraction_SD),
                  "Measure"= c(rep("Familiarity", 12), rep("Preference", 12),
                               rep("Pleasantness", 12), rep("Offensiveness", 12),
                               rep("Distraction",12)),
                  "Music"= rep(mSongs3$music, 5))#,

df3$Experiment<- "Experiment 2"




######## Experiment 3:

ratings4 <- read.csv("Experiment3/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs4<- melt(ratings4, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c("familiarity", 'preference', 'pleasantness',
                           'offensiveness', 'distraction', 
                           'accuracy_artist', 'accuracy_song'), na.rm=TRUE)
mSongs4<- cast(DesSongs4, music+song_number+music_set ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))

df4<-  data.frame("Mean"= c(mSongs4$familiarity_M, mSongs4$preference_M, mSongs4$pleasantness_M, 
                            mSongs4$offensiveness_M, mSongs4$distraction_M),
                  "SD"= c(mSongs4$familiarity_SD, mSongs4$preference_SD, mSongs4$pleasantness_SD, 
                          mSongs4$offensiveness_SD, mSongs4$distraction_SD),
                  "Measure"= c(rep("Familiarity", 12), rep("Preference", 12),
                               rep("Pleasantness", 12), rep("Offensiveness", 12),
                               rep("Distraction",12)),
                  "Music"= rep(mSongs4$music, 5))#,

df4$Experiment<- "Experiment 3"


df<-rbind(df1, df2, df3, df4)
df$Measure<- as.factor(df$Measure)
df$Measure<- factor(df$Measure, levels= c("Offensiveness", "Distraction", "Preference", "Pleasantness", "Familiarity"))




a <- ggplot(df, aes(x = Mean, y= Measure, fill= Music, color= Music))+
  geom_boxplot(
    width = .25, 
    outlier.shape = NA, fill= NA, position = position_dodge(width = 0.8)
  ) +
  geom_point(aes(fill=Music),
             size = 1.3,
             alpha = .6,
             position =  position_jitterdodge(jitter.width = 0.1, dodge.width = 0.8)
  ) + 
  coord_cartesian(ylim = c(1.2, NA), clip = "off")+
  xlim(1,10)+
  scale_color_manual(values=pallete1[1:2])+
  scale_fill_manual(values=pallete1[1:2])+
  theme_classic(16) +ylab("Measure")+ xlab('Mean rating (1= very low; 10= very high)')+
  theme(legend.position = 'top')+
  stat_summary(fun = mean, geom="point",colour="black", size=2, position = position_dodge(0.8), show.legend = F) +
  stat_summary(fun.data = fun_mean, geom="text", vjust=-0.8, colour="black", position = position_dodge(0.8))+
  facet_wrap(~Experiment)

ggsave(plot = a, filename = "Plots/Ratings_M.pdf", height = 9, width = 9)


###############################################################################

e2= ratings3
e2$Experiment= "Experiment 2"
e3= ratings4
e3$Experiment= "Experiment 3"

dat= rbind(e2, e3)

DesFam<- melt(dat, id=c('subject', 'music', 'song_number', 'music_set', 'Experiment'), 
                 measure=c("familiarity"), na.rm=TRUE)
mFam<- cast(DesFam, subject+ Experiment ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))
s<- mFam[which(mFam$familiarity_M>= 6), ]
table(s$Experiment)



# load  data:
rt <- read_csv("Experiment2/data/reaction_time.csv")
rt$log_duration<- log(rt$duration)

rt<- subset(rt, !is.element(subject, c(46, 141, 185, 196)))

# set up contrast coding:
rt$sound<- as.factor(rt$sound)
rt$sound<- factor(rt$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(rt$sound)

## successive differences contrast:
library(MASS)
cmat<- contr.sdif(3)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr")

contrasts(rt$sound)<- cmat 
contrasts(rt$sound)


aggregate(rt$duration, by= list(rt$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                              sd = sd(x, na.rm=T) ))

library(lme4)
summary(LM1<- lmer(log_duration ~ sound+ (sound|subject)+ (1|item), data = rt, REML = T))




# load  data:
rt <- read_csv("Experiment3/data/reaction_time.csv")
rt$log_duration<- log(rt$duration)

rt<- subset(rt, !is.element(subject, c(20, 28, 92, 94, 133, 148, 171, 183, 193)))

# set up contrast coding:
rt$sound<- as.factor(rt$sound)
rt$sound<- factor(rt$sound, levels= c( "silence", "instrumental", "lyrical", 'speech'))
levels(rt$sound)


## successive differences contrast:
cmat<- contr.sdif(4)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr", "speech_vs_instr")

contrasts(rt$sound)<- cmat 
contrasts(rt$sound)


aggregate(rt$duration, by= list(rt$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                              sd = sd(x, na.rm=T) ))
summary(LM1<- lmer(log_duration ~ sound+ (1|subject)+ (1|item), data = rt, REML = T))

