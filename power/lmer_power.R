
rm(list= ls())


# load/ install required packages:
packages= c("simr", "MASS", "readr") # list of used packages:

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

dat<- dat[which(dat$duration> 100 & dat$duration<5000),]
dat<- subset(dat, word>0)
dat<- subset(dat, !is.element(subject, c(20, 43, 56, 52, 62, 86)))


dat$log_duration<- log(dat$duration)

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


#write.csv(sim_data, "power/sim_data.csv")

## model with pilot data:
summary(LM1<- lmer(log_duration ~ sound+ (1|subject)+ (1|item), data = dat, REML = T))



########################################
data_loss<- 0.10 #simulate data loss by excluding x% of data points from simulation
ES_reduction<- 0.75 # simulate x% of observed effect size
NSim= 100 # number of simulations
nsub= 156  # number of subjects (multiple of 6)


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
model1 <- makeLmer(log_duration ~ sound + (sound|subject) + (1|item), fixef=b, VarCorr= RE, sigma=s, data=df)
summary(model1)

sim_data<- getData(model1)


# Power simulation curves:

# Instrumental vs SIlence
pc1<- powerCurve(model1, nsim=NSim, test = fixed(xname = 'sound.instr_vs_slc', method = "z"),
                 along = 'subject', breaks= seq(60, 180, 12))

plot(pc1, xlab= "Number of subjecs", power = 0.95)


## Lyrical vs. Instrumental
pc2<- powerCurve(model1, nsim=NSim, test = fixed(xname = 'sound.lyr_vs_instr', method = "z"), 
                 along = 'subject', breaks= seq(60, 180, 12))

plot(pc2, xlab= "Number of subjecs", power = 0.95)


#sim1 <- powerSim(model1, nsim=100, test = fixed(xname = 'sound.instr_vs_slc', method = "z"))
#sim1 <- powerSim(model1, nsim=100, test = fixed(xname = 'sound.lyr_vs_instr', method = "z"))

