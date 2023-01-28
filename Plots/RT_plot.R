
rm(list = ls())

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

library(reshape)
library(ggplot2)
library(readr)

# Experiment 1a:
rt_e1 <- read_csv("Experiment1a/data/reaction_time.csv")

DesRT_e1<- melt(rt_e1, id=c('subject', 'item', 'sound'), 
             measure=c("duration"), na.rm=TRUE)

mRT_e1<- cast(DesRT_e1, sound+subject ~ variable
           ,function(x) c(M=signif(mean(x),3)
                          , SD= sd(x) ))
mRT_e1$Experiment<- "Experiment 1a"


# Experiment 1b:
rt_e2 <- read_csv("Experiment1b/data/reaction_time.csv")

DesRT_e2<- melt(rt_e2, id=c('subject', 'item', 'sound'), 
                measure=c("duration"), na.rm=TRUE)

mRT_e2<- cast(DesRT_e2, sound+subject ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))
mRT_e2$Experiment<- "Experiment 1b"



# Experiment 2:
rt_e3 <- read_csv("Experiment2/data/reaction_time.csv")

DesRT_e3<- melt(rt_e3, id=c('subject', 'item', 'sound'), 
                measure=c("duration"), na.rm=TRUE)

mRT_e3<- cast(DesRT_e3, sound+subject ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))
mRT_e3$Experiment<- "Experiment 2"


# Experiment 3:
rt_e4 <- read_csv("Experiment3/data/reaction_time.csv")

DesRT_e4<- melt(rt_e4, id=c('subject', 'item', 'sound'), 
                measure=c("duration"), na.rm=TRUE)

mRT_e4<- cast(DesRT_e4, sound+subject ~ variable
              ,function(x) c(M=signif(mean(x),3)
                             , SD= sd(x) ))
mRT_e4$Experiment<- "Experiment 3"

mRT<- rbind(mRT_e1, mRT_e2, mRT_e3, mRT_e4)

mRT$sound<- as.factor(mRT$sound)
mRT$sound<- factor(mRT$sound, levels = c("silence", "instrumental", "lyrical", "speech"))
#levels(mRT$sound)<- c("silence","instrumental music", "lyrical music"  )

levels(mRT$sound)


fun_mean <- function(x){
  return(data.frame(y=mean(x),label= paste("M= ", round(mean(x,na.rm=T)), sep= '')))}

MPlot <-ggplot(mRT, aes(x = sound, y = duration_M, color= sound, fill= sound)) + 
  ggdist::stat_halfeye(
    adjust = .7, 
    width = .6, 
    .width = 0, 
    justification = -.3, 
    point_colour = NA) + 
  geom_boxplot(
    width = .25, 
    outlier.shape = NA, fill= NA
  ) +
  geom_point(
    size = 1.,
    alpha = .3,
    position = position_jitter(
      seed = 1, width = .13
    )
  ) + 
  coord_cartesian(xlim = c(1.2, NA), clip = "off")+
  scale_color_manual(values=pallete1)+
  scale_fill_manual(values=pallete1)+
  theme_classic(20) +ylab("Mean reaction time per word (in ms)")+
  theme(legend.position = 'none')+
  stat_summary(fun = mean, geom="point",colour="black", size=2) +
  stat_summary(fun.data = fun_mean, geom="text",fontface = "bold" , vjust=-0.7, colour="black", size= 5.5)+
  facet_wrap(~Experiment)

MPlot


ggsave(plot = MPlot, filename = "Plots/RT_mean.pdf", height = 11, width = 11)



