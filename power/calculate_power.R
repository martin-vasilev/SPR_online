
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

dat$log_duration<- log(dat$duration)

# set up contrast coding:
dat$sound<- as.factor(dat$sound)
dat$sound<- factor(dat$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(dat$sound)

# dat1<- subset(dat, sound== "lyrical" | sound== "instrumental")
# dat1$sound<- droplevels(dat1$sound)
# levels(dat1$sound)
# 
# dat2<- subset(dat, sound== "silence" | sound== "instrumental")
# dat2$sound<- droplevels(dat2$sound)
# levels(dat2$sound)
# 
# contrasts(dat1$sound)
# contrasts(dat2$sound)
# 
# 
# summary(LM.h1<- lmer(log_duration ~ sound+ (1|subject)+ (1|item), data = dat2))
# summary(LM.h2<- lmer(log_duration ~ sound+ (1|subject)+ (1|item), data = dat1, REML = T))
# 
# 
# # reduce expected effect to 75% of observed:
# fixef(LM.h1)['soundinstrumental']<- fixef(LM.h1)['soundinstrumental']*0.75
# 
# p_curve1 <- powerCurve(LM.h1, along="subject", sim = 5, breaks= c(5, 10, 15))



## successive differences contrast:
cmat<- contr.sdif(3)
colnames(cmat)<- c(".instr_vs_slc", ".lyr_vs_instr")

contrasts(dat$sound)<- cmat 
contrasts(dat$sound)

aggregate(dat$duration, by= list(dat$sound), FUN= function(x) c(mean = mean(x, na.rm= T), 
                                                                sd = sd(x, na.rm=T) ))

#### Bayesian model parameters:
NwarmUp<- 500#500
Niter<- 1500#2500
Nchains<- 10 #10


### Simulation settings:
nSub= 24

#  priors:
log(700) # intercept

log(730)- log(700) # ~ 0.05
(log(730)- log(700))*2 # 2x SD , ~ .10




summary(LM1<- lmer(log(duration) ~ sound+ (1|subject)+ (1|item), data = dat, REML = T))



########################################
data_loss<- 0.10 #simulate data loss by excluding x% of data points from simulation
ES_reduction<- 0.75 # simulate x% of observed effect size
NSim= 10 # number of simulations
nsub= 102  # number of subjects (multiple of 6)


# parameters:
b <- coef(summary(LM1))[,1] # fixed intercept and slopes
b[2:3]<- b[2:3]*ES_reduction # reduce expected effect size to 75% of observed one

RE <- VarCorr(LM1) # random effects
s <- 0.181844 # residual sd


# create fake dataset (placeholder):
df= extend(LM1, along ="subject", n = nsub) # extend current to n subjects
df= getData(df) # get dataset from model

# simulate data loss:
df= df[-sample(nrow(df), round(data_loss*nrow(df))), ]

# set up contrast coding:
df$sound<- as.factor(df$sound)
df$sound<- factor(df$sound, levels= c( "silence", "instrumental", "lyrical"))
levels(df$sound)
contrasts(df$sound)<- cmat 
contrasts(df$sound)


# make fake data:
model1 <- makeLmer(log_duration ~ sound + (1|subject) + (1|item), fixef=b, VarCorr= RE, sigma=s, data=df)
summary(model1)

pc1<- powerCurve(model1, nsim=NSim, test = fixed(xname = 'sound.instr_vs_slc', method = "z"), 
                 along = 'subject', breaks= seq(6, 102, 6))

plot(pc1, xlab= "Number of subjecs", power = 0.95)


pc2<- powerCurve(model1, nsim=NSim, test = fixed(xname = 'sound.lyr_vs_instr', method = "z"), 
                 along = 'subject', breaks= seq(6, 102, 6))

plot(pc2, xlab= "Number of subjecs", power = 0.95)


#sim1 <- powerSim(model1, nsim=100, test = fixed(xname = 'sound.instr_vs_slc', method = "z"))
#sim1 <- powerSim(model1, nsim=100, test = fixed(xname = 'sound.lyr_vs_instr', method = "z"))




















#p_curve <- powerCurve(LM1, test=fcompare(y~sound), along="subject", sim = 5, breaks= c(5, 10, 15))


BM<- brm(formula = log(duration) ~ sound + (1|subject)+ (1|item), data = dat, warmup = NwarmUp, iter = Niter, chains = Nchains,
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


# t<- data.frame("N"= nSub, "Run"= i, "BF1"= 1/BF_sound$hypothesis$Evid.Ratio, 
#                "BF2"= 1/BF_task$hypothesis$Evid.Ratio, "BF3"= 1/BF_int$hypothesis$Evid.Ratio,
#                "b1"= A$fixed[2,1], "b2"= A$fixed[3,1], "b3"= A$fixed[4,1],
#                "L1"= A$fixed[2,3], "U1"= A$fixed[2,4],
#                "L2"= A$fixed[3,3], "U2"= A$fixed[3,4],
#                "L3"= A$fixed[4,3], "U3"= A$fixed[4,4],
#                min_Rhat= min(rhat(BM)), max_Rhat= max(rhat(BM)))
