

library(readr)
device <- read_csv("Experiment1a/data/device_info.csv")


library(ggplot2)
library(scales)

df<- as.data.frame(table(device$browser)) 

bp<- ggplot(df, aes(x="", y= Freq, fill=Var1))+
  geom_bar(width = 1, stat = "identity")
bp

pie <- bp + coord_polar("y", start=0)
pie

pie + scale_fill_brewer("Blues") + theme_blank()+
  theme(axis.text.x=element_blank())+
  geom_text(aes(y = value/3 + c(0, cumsum(value)[-length(value)]), 
                label = percent(value/100)), size=5)
