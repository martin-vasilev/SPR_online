
rm(list= ls())

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

# load/ install required packages:
packages= c("reshape", "brms", "grid", "emmeans", "parallel", "boot", "simr", "dplyr", "MASS", "readr") # list of used packages:

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
dat <- read_csv("data/reaction_time.csv")


# set up contrast coding:
dat$sound<- as.factor(dat$sound)
dat$sound<- factor(dat$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(dat$sound)

## successive differences contrast:
cmat<- contr.sdif(3)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr")

contrasts(dat$sound)<- cmat 
contrasts(dat$sound)

aggregate(dat$duration, by= list(dat$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                                sd = sd(x, na.rm=T) ))

#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 5000#2500
Nchains<- 4 #10


### Simulation settings:
nSub= 24

#  priors:
log(700) # intercept

log(730)- log(700) # ~ 0.05
(log(730)- log(700))*2 # 2x SD , ~ .10


summary(LM1<- lmer(log(duration) ~ sound+ (1|subject)+ (1|item), data = dat, REML = T))

































#p_curve <- powerCurve(LM1, test=fcompare(y~sound), along="subject", sim = 5, breaks= c(5, 10, 15))


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


t<- data.frame("N"= nSub, "Run"= i, "BF1"= 1/BF_sound$hypothesis$Evid.Ratio, 
               "BF2"= 1/BF_task$hypothesis$Evid.Ratio, "BF3"= 1/BF_int$hypothesis$Evid.Ratio,
               "b1"= A$fixed[2,1], "b2"= A$fixed[3,1], "b3"= A$fixed[4,1],
               "L1"= A$fixed[2,3], "U1"= A$fixed[2,4],
               "L2"= A$fixed[3,3], "U2"= A$fixed[3,4],
               "L3"= A$fixed[4,3], "U3"= A$fixed[4,4],
               min_Rhat= min(rhat(BM)), max_Rhat= max(rhat(BM)))
