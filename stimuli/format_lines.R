
rm(list= ls())

library(readxl)
library(stringi)

Text_stimuli <- read_excel("stimuli/Text_stimuli.xlsx")


txt= Text_stimuli$Text[1]

words= unlist(strsplit(txt, ' '))


mask<- function(string){paste(rep('-', nchar(string)), collapse = '')}



for(i in 1:length(words)){
  new= NULL
  
  for (j in 1:length(words)){
    new<- c(new, mask(words[j]))
    
  }
  
  new[i]= words[i]
  
  new_m<- paste(new, collapse= ' ')
  
  new_m<- stri_wrap(new_m, width = 60)
  new_m<- paste(new_m, collapse = '<br>')
  
  
  writeLines(new_m, paste('output/word', toString(i), '.txt', sep= ''), sep = ' ')
  
}
