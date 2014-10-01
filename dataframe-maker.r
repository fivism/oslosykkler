## We're taking a directory of scraped JSON snapshots and turning it into one giant dataframe
## Michael Sept 14, 2014

## Libraries needed
library(rjson)

## Set up blank dataframe with firstcol = time
## And emptylocks/bikesready columns for each 111 stations

bikeframe = data.frame(time=as.Date(character()),c()
                          stringsAsFactors=FALSE) 


## Create list of files (?)
givenpath = 'week36/composite/'
minute_index = list.files(givenpath)

## Read out oldest file and establish columns according to this one. 
## For our purposes, beginning of index is already the oldest 
## Loop and step through each
for (i in 1:length(minute_index)) {   ## Row-level build out
  jsonfile <- minute_index[i]
  jsondata <- fromJSON(file=paste(givenpath, jsonreadout, sep=""), method='C')

  ## sample rbind line
  ## existingDF = rbind(existingDF,newrow)
  
  
  for (j in 1:length(jdoc)) {   ## Column-level build out
    
    }
}
jsonreadout <- minute_index[1]  
jdoc <- fromJSON(file=c(givenpath,jsonreadout), method='C')


    ## Add each timefile to dataframe

