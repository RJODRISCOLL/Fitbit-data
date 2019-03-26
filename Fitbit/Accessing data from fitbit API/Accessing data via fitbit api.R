# how to access fitbit API
#####    
#### you can set the callback url on the fitbit development site to: http://localhost:1410  
#####
##install the following packages 
install.packages("devtools")
library(devtools)
devtools::install_github("teramonagi/fitbitr") #fitbitr is not on CRAN 
library(fitbitr)


#you can access this information on your app site 
FITBIT_KEY<-" " ####enter your fitbit key here
FITBIT_SECRET<-" " ####enter your fitbit secret here 

#get the token from the fitbit r package 
#when you run this you will be taken to the fibit site to authorise 
#it will save your token in global environment 
token <- fitbitr::oauth_token() 

#### the example below is just for a single day 
#set a date you are interested in 
date <- "YYYY-MM-DD" #required format

#this will provide a daily summary to the console 
str(get_activity_summary(token, date))

#example of how to get steps and heart rate minute level 
stepsdata <- get_activity_intraday_time_series(token, "steps", date=date, detail_level="1min")
heartratedata <- get_heart_rate_intraday_time_series(token, date=date, detail_level="1min")


#Merge by time and tidy the data frame 
merged<-merge(stepsdata, heartratedata, by.x = "dataset_time", by.y = "time", all = T)
colnames(merged)[colnames(merged)=="dataset_value"] <- "Steps.min"
colnames(merged)[colnames(merged)=="value.y"] <- "HR.min"
cols<-c(1,2,4,7)
c<-merged[, cols]
View(c)
