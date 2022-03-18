
rm(list= ls())


# load/ install required packages:
packages= c("readxl", "stringi") # list of used packages:

for(i in 1:length(packages)){
  
  if(packages[i] %in% rownames(installed.packages())==FALSE){
    install.packages(packages[i], repos = "http://cran.us.r-project.org")
    library(packages[i], character.only=TRUE, quietly = TRUE)
  }else{
    library(packages[i], character.only=TRUE, quietly = TRUE)
  }
}


max_chars_line= 60
mask<- function(string){paste(rep('-', nchar(string)), collapse = '')}


# load items:
Text_stimuli <- read_excel("Experiment3/Text_stimuli_exp3.xlsx")
Text_stimuli<- Text_stimuli[1:22, ] # get rid of empty row at the end


for(i in 1:nrow(Text_stimuli)){

  txt<- Text_stimuli$Text[i]  # get item as text
  words= unlist(strsplit(txt, ' '))  # splice into a vector of words
  
  ## generate data frame we will use to upload to lab.js:
  t<- data.frame('item'= rep(Text_stimuli$ID[i], length(words)),
                 'Provo_ID'= rep(Text_stimuli$Provo_ID[i], length(words)),
                 'word'= 1:length(words), 'word_ID'= words)
  t$text<- NA
  
  for(j in 1:length(words)){ ## for each word in paragraph..
    new<- NULL
    
    for (k in 1:length(words)){ # create a mask for all words in paragraph
      new<- c(new, mask(words[k]))
      
    }
    
    new[j]<- words[j] # replace target with real word in the masked text
    
    new_m<- paste(new, collapse= ' ') # concatenate into a string
    
    new_m<- stri_wrap(new_m, width = max_chars_line) # parse string into lines
    new_m<- paste(new_m, collapse = '<br>') # add html line break symbol
    t$text[j]<- new_m
    
    # writeLines(new_m, paste('output/word', toString(i), '.txt', sep= ''), sep = ' ')
    
  } # end of j loop
  
  write.csv(t, paste('Experiment3/output/item', toString(Text_stimuli$ID[i]), '.csv', sep= ''), row.names=FALSE) # save design
  
  
}# end of i loop

