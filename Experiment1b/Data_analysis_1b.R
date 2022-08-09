
rm(list= ls())

source('https://raw.githubusercontent.com/martin-vasilev/R_scripts/master/CohensD_raw.R')

# load/ install required packages:
packages= c("simr", "brms", "MASS", "readr", "reshape", "ggcorrplot", "ggplot2", "sjPlot", "readr") # list of used packages:

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

# accuracy by participant:
a= aggregate(q$accuracy, by= list(q$subject), FUN= function(x) c(mean = mean(x, na.rm= T),                                                               sd = sd(x, na.rm=T) ))
a= a$x

Desq<- melt(q, id=c('subject', 'sound'), 
            measure=c('accuracy'), na.rm=TRUE)
Qsub<- cast(Desq, subject ~ variable
            ,function(x) c(M=signif(mean(x),3)
                           , SD= sd(x) ))

Qsub<- Qsub[order(Qsub$accuracy_M),]

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


Desq<- melt(q, id=c('subject', 'sound'), 
                measure=c('accuracy'), na.rm=TRUE)
Qsub<- cast(Desq, subject ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))

Qsub<- Qsub[order(Qsub$accuracy_M),]

# accuracy by participant:
a= aggregate(q$accuracy, by= list(q$subject), FUN= function(x) c(mean = mean(x, na.rm= T),                                                               sd = sd(x, na.rm=T) ))
a= a$x


## Main model with RT data:
if(!file.exists("Experiment1b/models/LM1.Rda")){
  summary(LM1<- lmer(log_duration ~ sound+ (sound|subject)+ (1|item), data = rt, REML = T))
  
  save(LM1, file = 'Experiment1b/models/LM1.Rda')
  
}else{
   load('Experiment1b/models/LM1.Rda')
  summary(LM1)
}



P1= plot_model(model = LM1, type= "re", rm.terms = 'subject', transform = NULL)
P1= P1[[1]]

P1+theme_minimal(20)

ggsave(plot = P1, filename = "Experiment1b/plots/raneff_RT.pdf", height = 18, width = 12)



#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 5000#2500
Nchains<- 4 #10

job::job({
  BM1<- brm(formula = log_duration ~ sound + (sound|subject)+ (1|item), data = rt, 
            warmup = NwarmUp, iter = Niter, chains = Nchains,
            sample_prior = TRUE, cores = parallel::detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
            prior =  c(set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.instr_vs_slc'),
                       set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.lyr_vs_instr'),
                       set_prior('normal(0, 6)', class = 'Intercept')))
}) 


A= print(BM1, digits=5)
prior_summary(BM1)

save(BM1, file= "Experiment1b/models/BM1.Rda") 

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





### effect sizes:

# instrumental vs silence
CohensD_raw(data = subset(rt, sound!= "lyrical"), measure = 'duration', group_var = 'sound',
            baseline = 'silence', avg_var = 'subject')

# lyrical vs instrumental
CohensD_raw(data = subset(rt, sound!= "silence"), measure = 'duration', group_var = 'sound',
            baseline = 'instrumental', avg_var = 'subject')








## Main model with accuracy data:
if(!file.exists("Experiment1b/models/LM2.Rda")){
  summary(LM2<- glmer(accuracy ~ sound+ (sound|subject)+ (1|item), 
                      data = q, family = binomial))
  
  save(LM2, file = 'Experiment1b/models/LM2.Rda')
  
}else{
  load('Experiment1b/models/LM2.Rda')
  summary(LM2)
}




GM1<- brm(formula = accuracy ~ sound + (sound|subject)+ (1|item), data = q, family= bernoulli, warmup = NwarmUp,
          iter = Niter, chains = Nchains, sample_prior = TRUE, cores = parallel::detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
          prior =  c(set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.instr_vs_slc'),
                     set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.lyr_vs_instr'),
                     set_prior('normal(0, 2)', class = 'Intercept')))

A= print(GM1, digits=3)
save(GM1, file= "Experiment1b/models/GM1.Rda")

# sound effect 1:
BF2_sound1 = hypothesis(GM1, hypothesis = 'sound.instr_vs_slc = 0', seed= 1234)  # H0: No  slc vs instr difference
(BFQ1= 1/BF2_sound1$hypothesis$Evid.Ratio)

# sound effect 2:
BF2_sound2 = hypothesis(GM1, hypothesis = 'sound.lyr_vs_instr = 0', seed= 1234)  # H0: No  lyr vs instr difference
(BFQ2= 1/BF2_sound2$hypothesis$Evid.Ratio)





### effect sizes:

# instrumental vs silence
CohensD_raw(data = subset(q, sound!= "lyrical"), measure = 'accuracy', group_var = 'sound',
            baseline = 'silence', avg_var = 'subject')

# lyrical vs instrumental
CohensD_raw(data = subset(q, sound!= "silence"), measure = 'accuracy', group_var = 'sound',
            baseline = 'instrumental', avg_var = 'subject')




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
  theme_classic(24) +ylab("Reaction time (in ms)")+
  theme(legend.position = 'none')+
  stat_summary(fun = mean, geom="point",colour="black", size=3, ) +
  stat_summary(fun.data = fun_mean, geom="text", vjust=-0.7, size= 6, colour="black")

MPlot


ggsave(plot = MPlot, filename = "Experiment1b/plots/RT_mean.pdf", height = 9, width = 9)



##############
# compare to student sample of Experiment 1a:

e1b<- read_csv("Experiment1b/data/reaction_time.csv") # experiment 1b data, student sample
e1b$Experiment<- "Experiment 1b [students]"


e1a <- read_csv("Experiment1a/data/reaction_time.csv")
e1a<- subset(e1a, Pool== "University pool")
e1a$subject<- 1000+e1a$subject

e1a$Experiment<- "Experiment 1a [students]"

exp1<- rbind(e1a, e1b)

table(exp1$Experiment)


cmat<- contr.sdif(3)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr")

exp1$sound<- as.factor(exp1$sound)
levels(exp1$sound)
exp1$sound<- factor(exp1$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(exp1$sound)

contrasts(exp1$sound)<- cmat 
contrasts(exp1$sound)

exp1$Experiment<- as.factor(exp1$Experiment)
contrasts(exp1$Experiment)<- c(-1, 1)
contrasts(exp1$Experiment)


summary(LMPH<- lmer(log_duration ~ sound*Experiment+ (sound|subject)+ (1|item), data = exp1, REML = T))

library(effects)
effect('sound:Experiment', LMPH)

effect('Experiment', LMPH)

library(ggeffects)

mydf <- ggpredict(LMPH, terms = c("sound", "Experiment"))
mydf$sample<- mydf$group

ggplot(mydf, aes(x, predicted, group= group, colour= group, fill= group, ymax= conf.high, ymin= conf.low)) +
  geom_line(size= 1.2) +geom_point(size= 3) + theme_classic(22)+ geom_ribbon(alpha= 0.05, colour= NA)+
  scale_color_manual(values=pallete1[1:2])+
  scale_fill_manual(values=pallete1[1:2])+ xlab('Sound condition') + ylab('log(word RT): model prediction')





#########################
## Covariate analysis:  #
#########################

rm(rt)

# load  data:
rt <- read_csv("Experiment1b/data/reaction_time.csv")

rt$familiarity_c<- scale(rt$familiarity)
rt$preference_c<- scale(rt$preference)
rt$pleasantness_c<- scale(rt$pleasantness)
rt$offensiveness_c <- scale(rt$offensiveness) 
rt$distraction_c<- scale(rt$distraction)
rt$song_knowledge<- rt$accuracy_artist + rt$accuracy_song
rt$music_frequency_c<- scale(rt$music_frequency)


# remove silence condition (no ratings available there)
rt2<- subset(rt, sound!= "silence")
#rt2sound<- droplevels(rt2$sound)
rt2$sound<- as.factor(rt2$sound)
levels(rt2$sound)

# contrast coding
cmat2<- contr.sdif(2)
colnames(cmat2)<- c(".lyr_vs_instr")

contrasts(rt2$sound)<- cmat2 
contrasts(rt2$sound)


if(!file.exists("Experiment1b/models/CLM1.Rda")){

  # does not converge with a subject slope
  summary(CLM1<- lmer(log_duration ~ sound+ familiarity_c+preference_c+ song_knowledge+
                        music_frequency+offensiveness_c+distraction_c+
                        (1|subject)+ (sound|item), data = rt, REML = T))
  
  save(CLM1, file = 'Experiment1b/models/CLM1.Rda')
  
}else{
  load('Experiment1b/models/CLM1.Rda')
  summary(CLM1)
}

gg2<- plot_model(CLM1, show.values = TRUE, value.offset = .3, value.size = 6, transform = NULL, digits=3,
                 rm.terms = c("(Intercept)"), vline.color = pallete1[5])
gg2<- gg2 + scale_y_continuous(limits = c(-0.05, 0.2)) +theme_classic(22)+ ggtitle("Experiment 1b")+
  theme(plot.title = element_text(hjust = 0.5))

save(gg2, file = "Plots/covar_e1b.Rda")
