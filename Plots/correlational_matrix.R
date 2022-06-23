
rm(list = ls())

# colorblind palletes: # https://venngage.com/blog/color-blind-friendly-palette/
pallete1= c("#CA3542", "#27647B", "#849FA0", "#AECBC9", "#57575F") # "Classic & trustworthy"

library(reshape)
library(ggplot2)
library(ggcorrplot)
library(ggpubr)


# Experiment 1a:

ratings <- read.csv("Experiment1a/data/prep/ratings_manual_coding.csv", sep=";")

r_mat<- ratings[, c(8:12, 15, 18)]
colnames(r_mat)<- c("familiarity", "preference", "pleasantness", "offensiveness",
                    "distraction", "artist accuracy", "song accuracy" )

r_corr<- cor(r_mat, use = 'complete.obs', method = 'pearson')
p.mat <- cor_pmat(r_mat)


set.seed(123)

C1= ggcorrmat(data = r_mat, colors = c("#4D4D4D", "white", "#B2182B"),
              title= "Experiment 1a", conf.level = 0.95,
              ggplot.component = list(ggplot2::theme(plot.title = element_text(hjust = 0.5,
                                                                               size= 14))), 
              matrix.type = 'upper')



# Experiment 1b:

ratings <- read.csv("Experiment1b/data/prep/ratings_manual_coding.csv", sep=";")

r_mat<- ratings[, c(8:12, 15, 18)]
colnames(r_mat)<- c("familiarity", "preference", "pleasantness", "offensiveness",
                    "distraction", "artist accuracy", "song accuracy" )

r_corr<- cor(r_mat, use = 'complete.obs', method = 'pearson')
p.mat <- cor_pmat(r_mat)


set.seed(123)

C2= ggcorrmat(data = r_mat, colors = c("#4D4D4D", "white", "#B2182B"),
              title= "Experiment 1b", conf.level = 0.95,
              ggplot.component = list(ggplot2::theme(plot.title = element_text(hjust = 0.5,
                                                                               size= 14))), 
              matrix.type = 'upper')


# Experiment 2:

ratings <- read.csv("Experiment2/data/prep/ratings_manual_coding.csv", sep=",")

r_mat<- ratings[, c(8:12, 15, 18)]
colnames(r_mat)<- c("familiarity", "preference", "pleasantness", "offensiveness",
                    "distraction", "artist accuracy", "song accuracy" )

r_corr<- cor(r_mat, use = 'complete.obs', method = 'pearson')
p.mat <- cor_pmat(r_mat)


set.seed(123)

C3= ggcorrmat(data = r_mat, colors = c("#4D4D4D", "white", "#B2182B"),
              title= "Experiment 2", conf.level = 0.95,
              ggplot.component = list(ggplot2::theme(plot.title = element_text(hjust = 0.5,
                                                                               size= 14))), 
              matrix.type = 'upper')



# Experiment 3:

ratings <- read.csv("Experiment3/data/prep/ratings_manual_coding.csv", sep=";")

r_mat<- ratings[, c(8:12, 15, 18)]
colnames(r_mat)<- c("familiarity", "preference", "pleasantness", "offensiveness",
                    "distraction", "artist accuracy", "song accuracy" )

r_corr<- cor(r_mat, use = 'complete.obs', method = 'pearson')
p.mat <- cor_pmat(r_mat)


set.seed(123)

C4= ggcorrmat(data = r_mat, colors = c("#4D4D4D", "white", "#B2182B"),
              title= "Experiment 3", conf.level = 0.95,
              ggplot.component = list(ggplot2::theme(plot.title = element_text(hjust = 0.5,
                                                                               size= 14))), 
              matrix.type = 'upper')


figure1 <- ggarrange(C1, C2, C3, C4, ncol = 2, nrow = 2)

ggsave(filename = 'Plots/Corr_plot.pdf', plot = figure1, width = 11.5, height = 11.5)


