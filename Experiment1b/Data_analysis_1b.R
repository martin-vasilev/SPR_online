
rm(list= ls())


# load/ install required packages:
packages= c("simr", "MASS", "readr", "reshape", "ggcorrplot", "ggplot2", "sjPlot") # list of used packages:

for(i in 1:length(packages)){
  
  if(packages[i] %in% rownames(installed.packages())==FALSE){
    install.packages(packages[i])
    library(packages[i], character.only=TRUE)
  }else{
    library(packages[i], character.only=TRUE)
  }
}

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

options(scipen = 999)


# load  data:
rt <- read_csv("Experiment1b/data/reaction_time.csv")
rt$log_duration<- log(rt$duration)

q <- read_csv("Experiment1b/data/question_accuracy.csv")


# set up contrast coding:
rt$sound<- as.factor(rt$sound)
rt$sound<- factor(rt$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(rt$sound)

q$sound<- as.factor(q$sound)
q$sound<- factor(q$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(q$sound)


## successive differences contrast:
cmat<- contr.sdif(3)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr")

contrasts(rt$sound)<- cmat 
contrasts(rt$sound)

contrasts(q$sound)<- cmat 
contrasts(q$sound)


aggregate(rt$duration, by= list(rt$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                                sd = sd(x, na.rm=T) ))


aggregate(q$accuracy, by= list(q$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                              sd = sd(x, na.rm=T) ))


## Main model with RT data:
if(!file.exists("Experiment1b/models/LM1.Rda")){
  summary(LM1<- lmer(log_duration ~ sound+ (sound|subject)+ (1|item), data = rt, REML = T))
  
  save(LM1, file = 'Experiment1b/models/LM1.Rda')
  
}else{
   load('Experiment1b/models/LM1.Rda')
  summary(LM1)
}


# RE1<- ranef(LM1)
# RE1<- RE1$subject
# RE1$subject<- 1:nrow(RE1)
# RE1$Pool<- ifelse(RE1$subject< 104, "University", "Prolific")

P1= plot_model(model = LM1, type= "re", rm.terms = 'subject', transform = NULL)
P1= P1[[1]]

P1+theme_minimal(20)

ggsave(plot = P1, filename = "Experiment1b/plots/raneff_RT.pdf", height = 18, width = 12)

## Main model with accuracy data:
if(!file.exists("Experiment1b/models/LM2.Rda")){
  summary(LM2<- glmer(accuracy ~ sound+ (sound|subject)+ (1|item), data = q, family = binomial))
  
  save(LM2, file = 'Experiment1b/models/LM2.Rda')
  
}else{
  load('Experiment1b/models/LM2.Rda')
  summary(LM2)
}




######## Music ratings:

ratings <- read.csv("Experiment1b//data/prep/ratings_manual_coding.csv", sep=";")

DesSongs<- melt(ratings, id=c('subject', 'music', 'song_number', 'music_set'), 
                measure=c("familiarity", 'preference', 'pleasantness',
                          'offensiveness', 'distraction', 
                          'accuracy_artist', 'accuracy_song'), na.rm=TRUE)
mSongs<- cast(DesSongs, music ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))


##### plot difference between lyrical and non-lyrical:

df<-  data.frame("Mean"= c(mSongs$familiarity_M, mSongs$preference_M, mSongs$pleasantness_M, 
                           mSongs$offensiveness_M, mSongs$distraction_M),
                 "SD"= c(mSongs$familiarity_SD, mSongs$preference_SD, mSongs$pleasantness_SD, 
                           mSongs$offensiveness_SD, mSongs$distraction_SD),
                 "Measure"= c("Familiarity", "Familiarity", "Preference", "Preference",
                              "Pleasantness", "Pleasantness", "Offensiveness",
                              "Offensiveness", "Distraction", "Distraction"),
                 "Music"= rep(c("Instrumental", "Lyrical"), 5))

df$SE<- df$SD/sqrt(204)

df$Measure<- as.factor(df$Measure)
df$Measure<- factor(df$Measure, levels= c("Familiarity", "Preference", "Pleasantness", "Distraction", "Offensiveness"))


# Default line plot
Plot<- ggplot(df, aes(x=Measure, y=Mean, ymin=Mean-SE, ymax=Mean+SE, group=Music, color=Music)) + 
  theme_minimal(20)+
  ylim(1, 10, )+
 # geom_line( size= 2)+
  geom_point(size=3)+
  geom_errorbar(width=.15, size= 1.5)+ ylab("Mean rating (1= very low; 10= very high)")

##### correlation plot


r_mat<- ratings[, c(8:12, 15, 18)]
colnames(r_mat)<- c("familiarity", "preference", "pleasantness", "offensiveness",
                    "distraction", "artist accuracy", "song accuracy" )

r_corr<- cor(r_mat, use = 'complete.obs', method = 'pearson')
p.mat <- cor_pmat(r_mat)


C1<- ggcorrplot(r_corr,  type = "lower",outline.color = 'white', sig.level = 0.05, digits = 2,
           show.diag = T, lab = T, lab_size = 8, p.mat = p.mat, tl.cex = 20, insig = 'pch', 
           pch = 4, pch.cex = 18, show.legend = T)
ggsave(plot = C1, filename = "plots/Corr_plot.pdf")




##################################################################################

DesRT<- melt(rt, id=c('subject', 'item', 'sound'), 
             measure=c("duration"), na.rm=TRUE)

mRT<- cast(DesRT, sound+subject ~ variable
           ,function(x) c(M=signif(mean(x),3)
                          , SD= sd(x) ))

levels(mRT$sound)<- c("silence",            "instrumental music", "lyrical music"  )

levels(mRT$sound)


fun_mean <- function(x){
  return(data.frame(y=mean(x),label= paste("M= ", round(mean(x,na.rm=T)), sep= '')))}

MPlot <-ggplot(mRT, aes(x = sound, y = duration_M, color= sound, fill= sound)) + 
  ggdist::stat_halfeye(
    adjust = .5, 
    width = .6, 
    .width = 0, 
    justification = -.3, 
    point_colour = NA) + 
  geom_boxplot(
    width = .25, 
    outlier.shape = NA, fill= NA
  ) +
  geom_point(
    size = 1.3,
    alpha = .3,
    position = position_jitter(
      seed = 1, width = .1
    )
  ) + 
  coord_cartesian(xlim = c(1.2, NA), clip = "off")+
  scale_color_manual(values=pallete1[1:3])+
  scale_fill_manual(values=pallete1[1:3])+
  theme_classic(20) +ylab("Reaction time (in ms)")+
  theme(legend.position = 'none')+
  stat_summary(fun = mean, geom="point",colour="black", size=3, ) +
  stat_summary(fun.data = fun_mean, geom="text", vjust=-0.7, colour="black")

MPlot


ggsave(plot = MPlot, filename = "Experiment1b/plots/RT_mean.pdf", height = 9, width = 9)






