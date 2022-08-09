rm(list = ls())

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

library(ggplot2)

library(ggpubr)


load('Plots/covar_e1.Rda')
load('Plots/covar_e1b.Rda')
load('Plots/covar_e2.Rda')
load('Plots/covar_e3.Rda')

figure1 <- ggarrange(gg1, gg2, gg3, gg4, ncol = 2, nrow = 2)

ggsave(filename = 'Plots/covar_plot.pdf', plot = figure1, width = 14, height = 16)
