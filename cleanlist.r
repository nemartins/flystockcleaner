#clean stock list
#libraries
#install rflybase
#library("devtools")
#devtools::install_github("ropensci/rflybase")

library(stringr)
library(dplyr)
library (rflybase)

###  test info
#data  <- read.csv("~/Documents/boulot_encours/Flystockcleaner/example_test/Bloomington Liste131122_NeuroWÜ_upload.csv")
#BDSC <- 'Bloomington.No.'
#fly_name <- 'Genotype' 
#BDSC <- 'None'
###########################################################

# start of code

#idea : if BDSC number -> get name
# if no bdsc number
conn <- rflybase::fb_connect()

data$BDSC <- NA
if ( ncol(data[BDSC == names(data)]) > 0){
  
  for (i in c(1:nrow(data))){
  #for (i in c(1:20)){  
    #i=3
    BDSCNUM= data[i,BDSC == names(data)]
    if (length(BDSCNUM) >0 ){ ## check the element is not Null, NA and other non-good elements will be dealt in the rflybase function
      ##change number to fbst name
      if (is.na (BDSCNUM)) next
      if (str_to_lower(str_sub(BDSCNUM, start = 1, end = 4)) != "fbst"){
        BDSCNUM=paste0("FBst", str_pad(BDSCNUM,7, pad="0"))
      }
      ## get name from flybase
      BDSCNA = rflybase::fb_get_stockname(conn,BDSCNUM)
      data$BDSC [i]= rflybase::fb_clean_stock_name(BDSCNA, output="text")
        
    }# end of if bdscnumber exist
    
    
    
    
  }#end loop
}# end of BDSC number change



