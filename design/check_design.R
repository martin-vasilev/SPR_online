
design <- read.csv("D:/R/SPR_online/design/design.csv", sep=";")

table(design$Item, design$cond, design$set)

