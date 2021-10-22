
rm(list= ls())

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

# load/ install required packages:
packages= c("reshape", "brms", "grid", "emmeans", "parallel", "boot", "simr", "dplyr", "MASS", "readr", 
            "boot") # list of used packages:

for(i in 1:length(packages)){
  
  if(packages[i] %in% rownames(installed.packages())==FALSE){
    install.packages(packages[i])
    library(packages[i], character.only=TRUE)
  }else{
    library(packages[i], character.only=TRUE)
  }
}


options(scipen = 999)


# load pilot data:
dat <- read_csv("data/Pilot/reaction_time.csv")

q <- read_csv("data/Pilot/question_accuracy.csv")
#dat <- read_csv("power/sim_data.csv")


dat$log_duration<- log(dat$duration)

# set up contrast coding:
dat$sound<- as.factor(dat$sound)
dat$sound<- factor(dat$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(dat$sound)

q$sound<- as.factor(q$sound)
q$sound<- factor(q$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(q$sound)



## successive differences contrast:
cmat<- contr.sdif(3)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr")

contrasts(dat$sound)<- cmat 
contrasts(dat$sound)


contrasts(q$sound)<- cmat 
contrasts(q$sound)


aggregate(dat$duration, by= list(dat$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                                sd = sd(x, na.rm=T) ))

#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 1500#2500
Nchains<- 10 #10


#  priors:
log(450) # intercept ~ 6

log(470)- log(450) # ~ 0.05
(log(470)- log(450))*2 # 2x SD , ~ .10



dat$subject<- as.factor(dat$subject)
dat$item<- as.factor(dat$item)


summary(LM1<- lmer(log(duration) ~ sound+ (1|subject)+ (1|item), data = dat, REML = T))


BM<- brm(formula = log(duration) ~ sound + (sound|subject)+ (sound|item), data = dat, warmup = NwarmUp, iter = Niter, chains = Nchains,
         sample_prior = TRUE, cores = detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
         prior =  c(set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.instr_vs_slc'),
                    set_prior('normal(0, 0.05)', class = 'b', coef= 'sound.lyr_vs_instr'),
                    set_prior('normal(0, 6)', class = 'Intercept')))

A= print(BM, digits=5)
prior_summary(BM)

save(BM, file= "power/BM.Rda")

## Bayes factors:

# Note: the Bayes Factor is BH_10, so values >1 indicate evidence for the alternative, and values <1 indicate 
# evidence in support of the null. Brms reports them the other way around, but I reverse them here because I 
# Think BF_10 reporting is somewhat more common

# sound effect 1:
BF_sound1 = hypothesis(BM, hypothesis = 'sound.instr_vs_slc = 0', seed= 1234)  # H0: No  slc vs instr difference
(BF1= 1/BF_sound1$hypothesis$Evid.Ratio)

# sound effect 2:
BF_sound2 = hypothesis(BM, hypothesis = 'sound.lyr_vs_instr = 0', seed= 1234)  # H0: No  lyr vs instr difference
(BF2= 1/BF_sound2$hypothesis$Evid.Ratio)



############ Accuracy:

q %>% group_by(sound) %>% 
  summarise(M= mean(accuracy), SD= sd(accuracy)) 

summary(LM2<- glmer(accuracy ~ sound+ (1|subject)+ (1|item), data = q, family = binomial))
#https://www.polyu.edu.hk/cbs/sjpolit/logisticregression.html
inverselogit <- function(x){ exp(x) / (1+exp(x) ) }

inverselogit(fixef(LM2)["(Intercept)"])
mean(q$accuracy)

logit(0.87) # intercept, round up to 2
logit(0.87) - logit(0.77) # rounded up to 0.75


GM1<- brm(formula = accuracy ~ sound + (sound|subject)+ (1|item), data = q, family= bernoulli, warmup = NwarmUp,
          iter = Niter, chains = Nchains, sample_prior = TRUE, cores = detectCores(), seed= 1234, control = list(adapt_delta = 0.9),
          prior =  c(set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.instr_vs_slc'),
                     set_prior('normal(0, 0.75)', class = 'b', coef= 'sound.lyr_vs_instr'),
                     set_prior('normal(0, 2)', class = 'Intercept')))

A= print(GM1, digits=3)


