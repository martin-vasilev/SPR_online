
rm(list= ls())


# load/ install required packages:
packages= c("simr", "MASS", "readr", "reshape", "ggcorrplot", "ggplot2", "sjPlot", "brms", "parallel", "effects",
            "ggstatsplot") # list of used packages:

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
rt <- read_csv("Experiment1a/data/reaction_time.csv")
rt$log_duration<- log(rt$duration)

q <- read_csv("Experiment1a/data/question_accuracy.csv")


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


### Extra (pool type contrast):

rt$Pool<- as.factor(rt$Pool)
contrasts(rt$Pool)<- c(1, 0) # make uni pool the baseline
contrasts(rt$Pool)


q$Pool<- as.factor(q$Pool)
contrasts(q$Pool)<- c(1, 0) # make uni pool the baseline
contrasts(q$Pool)


aggregate(rt$duration, by= list(rt$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                                sd = sd(x, na.rm=T) ))


aggregate(q$accuracy, by= list(q$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                              sd = sd(x, na.rm=T) ))


## Main model with RT data:
if(!file.exists("Experiment1a/models/LM1.Rda")){
  summary(LM1<- lmer(log_duration ~ sound+ (sound|subject)+ (1|item), data = rt, REML = T))
  
  save(LM1, file = 'Experiment1a/models/LM1.Rda')
  
}else{
   load('Experiment1a/models/LM1.Rda')
  summary(LM1)
}


summary(LM1.2<- lmer(log_duration ~ sound*Pool+ (Pool|subject)+ (1|item), data = rt, REML = T))

plot(effect('Pool', LM1.2))
plot(effect('sound:Pool', LM1.2))

effect('sound:Pool', LM1.2)


#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 5000#2500
Nchains<- 4 #10

BM1<- brm(formula = log_duration ~ sound + (sound|subject)+ (1|item), data = rt, 
         warmup = NwarmUp, iter = Niter, chains = Nchains,
         sample_prior = TRUE, cores = detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
         prior =  c(set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.instr_vs_slc'),
                    set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.lyr_vs_instr'),
                    set_prior('normal(0, 6)', class = 'Intercept')))


A= print(BM1, digits=5)
prior_summary(BM1)

save(BM1, file= "Experiment1a/models/BM1.Rda")

## Bayes factors:

# Note: the Bayes Factor is BH_10, so values >1 indicate evidence for the alternative, and values <1 indicate 
# evidence in support of the null. Brms reports them the other way around, but I reverse them here because I 
# Think BF_10 reporting is somewhat more common

# sound effect 1:
BF_sound1 = hypothesis(BM1, hypothesis = 'sound.instr_vs_slc = 0', seed= 1234)  # H0: No  slc vs instr difference
(BF1= 1/BF_sound1$hypothesis$Evid.Ratio)

# sound effect 2:
BF_sound2 = hypothesis(BM1, hypothesis = 'sound.lyr_vs_instr = 0', seed= 1234)  # H0: No  lyr vs instr difference
(BF2= 1/BF_sound2$hypothesis$Evid.Ratio)









# RE1<- ranef(LM1)
# RE1<- RE1$subject
# RE1$subject<- 1:nrow(RE1)
# RE1$Pool<- ifelse(RE1$subject< 104, "University", "Prolific")

P1= plot_model(model = LM1, type= "re", rm.terms = 'subject', transform = NULL)
P1= P1[[1]]

P1+theme_minimal(20)

ggsave(plot = P1, filename = "plots/raneff_RT.pdf", height = 18, width = 12)



## Main model with accuracy data:
if(!file.exists("Experiment1a/models/LM2.Rda")){
  summary(LM2<- glmer(accuracy ~ sound+ (sound|subject)+ (1|item), data = q, family = binomial))
  
  save(LM2, file = 'Experiment1a/models/LM2.Rda')
  
}else{
  load('Experiment1a/models/LM2.Rda')
  summary(LM2)
}


GM1<- brm(formula = accuracy ~ sound + (sound|subject)+ (1|item), data = q, family= bernoulli, warmup = NwarmUp,
          iter = Niter, chains = Nchains, sample_prior = TRUE, cores = detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
          prior =  c(set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.instr_vs_slc'),
                     set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.lyr_vs_instr'),
                     set_prior('normal(0, 2)', class = 'Intercept')))

A= print(GM1, digits=3)
save(GM1, file= "Experiment1a/models/GM1.Rda")

# sound effect 1:
BF2_sound1 = hypothesis(GM1, hypothesis = 'sound.instr_vs_slc = 0', seed= 1234)  # H0: No  slc vs instr difference
(BFQ1= 1/BF2_sound1$hypothesis$Evid.Ratio)

# sound effect 2:
BF2_sound2 = hypothesis(GM1, hypothesis = 'sound.lyr_vs_instr = 0', seed= 1234)  # H0: No  lyr vs instr difference
(BFQ2= 1/BF2_sound2$hypothesis$Evid.Ratio)


######## Music ratings:

ratings <- read.csv("D:/R/SPR_online/Experiment1a/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs<- melt(ratings, id=c('subject', 'music', 'song_number', 'music_set'), 
                measure=c("familiarity", 'preference', 'pleasantness',
                          'offensiveness', 'distraction', 
                          'accuracy_artist', 'accuracy_song'), na.rm=TRUE)
mSongs<- cast(DesSongs, music+song_number+music_set ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))


##### plot difference between lyrical and non-lyrical:

df<-  data.frame("Mean"= c(mSongs$familiarity_M, mSongs$preference_M, mSongs$pleasantness_M, 
                           mSongs$offensiveness_M, mSongs$distraction_M),
                 "SD"= c(mSongs$familiarity_SD, mSongs$preference_SD, mSongs$pleasantness_SD, 
                           mSongs$offensiveness_SD, mSongs$distraction_SD),
                 "Measure"= c(rep("Familiarity", 12), rep("Preference", 12),
                              rep("Pleasantness", 12), rep("Offensiveness", 12),
                              rep("Distraction",12)),
                 "Music"= rep(mSongs$music, 5))#,
                 #"Music"= rep(c("Instrumental", "Lyrical"), 5*204))

df$SE<- df$SD/sqrt(204)

df$Measure<- as.factor(df$Measure)
df$Measure<- factor(df$Measure, levels= c("Familiarity", "Preference", "Pleasantness", "Distraction", "Offensiveness"))


# # Default line plot
# Plot<- ggplot(df, aes(x=Measure, y=Mean, ymin=Mean-SE, ymax=Mean+SE, group=Music, color=Music)) + 
#   theme_minimal(20)+
#   ylim(1, 10)+
#  # geom_line( size= 2)+
#   geom_point(size=3)+
#   geom_errorbar(width=.15, size= 1.5)+ ylab("Mean rating (1= very low; 10= very high)")


  
a <- ggplot(df, aes(x = Measure, y= Mean, fill= Music, color= Music))+
  geom_boxplot(
    width = .25, 
    outlier.shape = NA, fill= NA, position = position_dodge(width = 0.7)
  ) +
  geom_point(aes(fill=Music),
    size = 1.3,
    alpha = .6,
    position =  position_jitterdodge(jitter.width = 0.1, dodge.width = 0.7)
  ) + 
  coord_cartesian(xlim = c(1.2, NA), clip = "off")+
  scale_color_manual(values=pallete1[1:2])+
  scale_fill_manual(values=pallete1[1:2])+
  theme_classic(20) +ylab("Mean rating (1= very low; 10= very high)")+
  theme(legend.position = 'top')+
  stat_summary(fun = mean, geom="point",colour="black", size=3, position = position_dodge(0.7), show.legend = F) +
  stat_summary(fun.data = fun_mean, geom="text", vjust=-0.7, colour="black", position = position_dodge(0.7))

ggsave(plot = a, filename = "Experiment1a/plots/Ratings_M.pdf", height = 7, width = 10)




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


set.seed(123)

C2= ggcorrmat(data = r_mat, colors = c("#4D4D4D", "white", "#B2182B"), title= "Song Ratings (Experiment 1a)", conf.level = 0.95,
          ggplot.component = list(ggplot2::theme(plot.title = element_text(hjust = 0.5, size= 18))))
ggsave(plot = C2, filename = "Experiment1a/plots/Corr_plot2.pdf")




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


ggsave(plot = MPlot, filename = "Experiment1a/plots/RT_mean.pdf", height = 9, width = 9)


##################################################################################

DesQ<- melt(q, id=c('subject', 'item', 'sound'), 
            measure=c("accuracy"), na.rm=TRUE)

mQ<- cast(DesQ, sound+subject ~ variable
          ,function(x) c(M=signif(mean(x),3)
                         , SD= sd(x) ))

levels(mQ$sound)<- c("silence",            "instrumental music", "lyrical music"  )

levels(mQ$sound)


fun_mean <- function(x){
  return(data.frame(y=mean(x),label= paste("M= ", round(mean(x,na.rm=T), 2), sep= '')))}

MPlot2 <-ggplot(mQ, aes(x = sound, y = accuracy_M, color= sound, fill= sound)) + 
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
  stat_summary(fun = mean, geom="point",colour="black", size=3 ) +
  stat_summary(fun.data = fun_mean, geom="text", vjust=-0.7, colour="black")

MPlot2


ggsave(plot = MPlot2, filename = "Experiment1a/plots/Acc_mean.pdf", height = 9, width = 9)
