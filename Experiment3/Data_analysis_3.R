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
rt <- read_csv("Experiment3/data/reaction_time.csv")
rt$log_duration<- log(rt$duration)

q <- read_csv("Experiment3/data/question_accuracy.csv")


# set up contrast coding:
rt$sound<- as.factor(rt$sound)
rt$sound<- factor(rt$sound, levels= c( "silence", "instrumental", "lyrical", 'speech'))
levels(rt$sound)

q$sound<- as.factor(q$sound)
q$sound<- factor(q$sound, levels= c( "silence", "instrumental", "lyrical", 'speech'))
levels(q$sound)


## successive differences contrast:
cmat<- contr.sdif(4)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr", "speech_vs_instr")

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


## Main model with RT data:
if(!file.exists("Experiment3/models/LM1.Rda")){
  summary(LM1<- lmer(log_duration ~ sound+ (1|subject)+ (1|item), data = rt, REML = T))
  
  save(LM1, file = 'Experiment3/models/LM1.Rda')
  
}else{
  load('Experiment3/models/LM1.Rda')
  summary(LM1)
}


library(emmeans)

EM<- emmeans(LM1, pairwise ~ sound)


library(effects)
plot(effect('sound', LM1))
effect('sound', LM1)



#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 5000#2500
Nchains<- 4 #10


job::job({
  
  BM1<- brm(formula = log_duration ~ sound + (1|subject)+ (1|item), data = rt, 
            warmup = NwarmUp, iter = Niter, chains = Nchains,
            sample_prior = TRUE, cores = detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
            prior =  c(set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.instr_vs_slc'),
                       set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.lyr_vs_instr'),
                       set_prior('normal(0, 0.75)', class = 'b', coef= 'soundspeech_vs_instr'),
                       set_prior('normal(0, 6)', class = 'Intercept')))
}) 


A= print(BM1, digits=5)
prior_summary(BM1)

save(BM1, file= "Experiment3/models/BM1.Rda")

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

# sound effect 3:
BF_sound3 = hypothesis(BM1, hypothesis = 'soundspeech_vs_instr = 0', seed= 1234)  # H0: No  lyr vs instr difference
(BF3= 1/BF_sound3$hypothesis$Evid.Ratio)





## Main model with accuracy data:
if(!file.exists("Experiment3/models/LM2.Rda")){
  summary(LM2<- glmer(accuracy ~ sound+ (1|subject)+ (1|item), data = q, family = binomial))
  
  save(LM2, file = 'Experiment3/models/LM2.Rda')
  
}else{
  load('Experiment3/models/LM2.Rda')
  summary(LM2)
}


#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 5000#2500
Nchains<- 4 #10

job::job({
  
  GM1<- brm(formula = accuracy ~ sound + (sound|subject)+ (1|item), data = q, family= bernoulli, warmup = NwarmUp,
            iter = Niter, chains = Nchains, sample_prior = TRUE, cores = detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
            prior =  c(set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.instr_vs_slc'),
                       set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.lyr_vs_instr'),
                       set_prior('normal(0, 0.75)', class = 'b', coef= 'soundspeech_vs_instr'),
                       set_prior('normal(0, 2)', class = 'Intercept')))
}) 


A= print(GM1, digits=3)
save(GM1, file= "Experiment3/models/GM1.Rda")

# sound effect 1:
BF2_sound1 = hypothesis(GM1, hypothesis = 'sound.instr_vs_slc = 0', seed= 1234)  # H0: No  slc vs instr difference
(BFQ1= 1/BF2_sound1$hypothesis$Evid.Ratio)

# sound effect 2:
BF2_sound2 = hypothesis(GM1, hypothesis = 'sound.lyr_vs_instr = 0', seed= 1234)  # H0: No  lyr vs instr difference
(BFQ2= 1/BF2_sound2$hypothesis$Evid.Ratio)

# sound effect 3:
BF2_sound3 = hypothesis(GM1, hypothesis = 'soundspeech_vs_instr = 0', seed= 1234)  # H0: No  speech vs lyr difference
(BFQ3= 1/BF2_sound3$hypothesis$Evid.Ratio)



##################################################################################

DesRT<- melt(rt, id=c('subject', 'item', 'sound'), 
             measure=c("duration"), na.rm=TRUE)

mRT<- cast(DesRT, sound+subject ~ variable
           ,function(x) c(M=signif(mean(x),3)
                          , SD= sd(x) ))

levels(mRT$sound)<- c("silence",            "instrumental music", "lyrical music", "speech"  )

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
  scale_color_manual(values=pallete1[1:4])+
  scale_fill_manual(values=pallete1[1:4])+
  theme_classic(24) +ylab("Reaction time (in ms)")+
  theme(legend.position = 'none')+
  stat_summary(fun = mean, geom="point",colour="black", size=3, ) +
  stat_summary(fun.data = fun_mean, geom="text", vjust=-0.7, size= 6, colour="black")

MPlot


ggsave(plot = MPlot, filename = "Experiment3/plots/RT_mean.pdf", height = 9, width = 9)



