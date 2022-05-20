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


summary(LM1<- lmer(log_duration ~ sound+ (1|subject)+ (1|item), data = rt, REML = T))

library(emmeans)

EM<- emmeans(LM1, pairwise ~ sound)


library(effects)
plot(effect('sound', LM1))
effect('sound', LM1)
