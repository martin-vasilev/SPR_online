

rm(list= ls())

library(reshape)

ratings1 <- read.csv("Experiment1a/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs1<- melt(ratings1, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c('accuracy_artist', 'accuracy_song'), na.rm=TRUE)
DesSongs1$value<- DesSongs1$value*100 

mSongs1<- cast(DesSongs1, music ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))




ratings2 <- read.csv("Experiment1b/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs2<- melt(ratings2, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c('accuracy_artist', 'accuracy_song'), na.rm=TRUE)
DesSongs2$value<- DesSongs2$value*100 

mSongs2<- cast(DesSongs2, music ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))



ratings3 <- read.csv("Experiment2/data/prep/ratings_manual_coding.csv", sep=",")

DesSongs3<- melt(ratings3, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c('accuracy_artist', 'accuracy_song'), na.rm=TRUE)
DesSongs3$value<- DesSongs3$value*100 

mSongs3<- cast(DesSongs3, music ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))


ratings4 <- read.csv("Experiment3/data/prep/ratings_manual_coding.csv", sep=";")

DesSongs4<- melt(ratings4, id=c('subject', 'music', 'song_number', 'music_set'), 
                 measure=c('accuracy_artist', 'accuracy_song'), na.rm=TRUE)
DesSongs4$value<- DesSongs4$value*100 

mSongs4<- cast(DesSongs4, music ~ variable
               ,function(x) c(M=signif(mean(x),3)
                              , SD= sd(x) ))

