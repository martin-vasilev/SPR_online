
src <- "Experiment1a/data/Prolific/"
target<- "Experiment1a/data/anon"


files<- list.files(src) # get all available files in directory
files<-paste(src,  files, sep= '') # paste full root link


for(i in 1:length(files)){
  t<- read.csv(files[i])
  t<- t[-1,]
  write.csv(t, paste(target, "/", substr(files[i], 28, nchar(files[i])), sep= ''))
  
}