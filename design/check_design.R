
design <- read.csv("D:/R/SPR_online/design/design.csv", sep=";")

table(design$item, design$cond)

table(design$set, design$cond)


table(design$item, design$cond, design$set)
