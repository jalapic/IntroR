#### Navigating Our Way around datasets ####



# Firstly, things can get cluttered in our global environment and affect performance
# Let's get rid of some stuff

ls()  #should list objects in your global environment
list.files()  #lists files in your workspace (you can see these above with Rstudio)
rm(df)  #df should be removed
rm(mat) #mat should be removed


rm(list = ls(all = TRUE))  # or just all of it 




#### Let's start with dataframes ####

setwd("C:/Users/James Curley/Dropbox/Work/R/teachingR")  #put your folder address here
setwd("C:/Users/curley/Dropbox/Work/R/teachingR")  #put your folder address here
df<-read.csv("wheels.csv")

df
head(df)
tail(df)

str(df)

ncol(df)
nrow(df)

length(df) #for dataframes same as ncol - i.e. how much across

colnames(df)
# [1] "id"        "day1"      "day2"      "day3"      "day4" 
# [6] "dob"       "mother"    "sex"       "strain"    "wheel"     "startdate"

rownames(df) #not that relevant in this example as they don't have names just numbers 

dimnames(df) #both rows and cols together -  also useful for other objects too (talk about later)


#to look at data in individual columns/variables
df$id
df[,1]  #column/variable1

df$day4
df[,5]  #column/variable5


#to look at individual observations/rows
df[15,]  #row15
df[70,]  #row70



#to look at a specific row/col i.e. obs/variable (what you'd consider to be a cell in excel)
df[57,4]  #e.g. observation/row 57,  column 4 which is the day3 score



summary(df) #some summary stats

table(df$strain)
table(df$wheel)
table(df$wheel, df$strain)

View(df) #look at the data sheet



#### To change column names ####

names_x<-colnames(df)
names_x

colnames(df)<-c("idddddd", "dayyyy1", "dayyyy2", "dayyyy3", "dayyyy4", "dobbb", "mothhhher", "sexxx", "strainnn", "WHEEL", "START")
colnames(df)
head(df)

colnames(df)[2:5] <-c("day1", "day2", "day3", "day4")
colnames(df)
head(df)

colnames(df)<-names_x
head(df)



#### Converting variables to different formats within a dataframe ####

str(df)


### DATES...

#Dates can be very annoying but there are some simple solutions.... we will deal with how to manage dates later
?as.Date #this contains basic info on dates, also look up package (lubridate) - I will do a Date help file also

df$dob          #how our dates look 
df$startdate    #how our dates look

as.Date(df$dob, format="%d.%m.%y")       #telling it the format of the dates in the variable/column
as.Date(df$startdate, format="%d.%m.%y")

df$dob <- as.Date(df$dob, format="%d.%m.%y")
df$startdate <- as.Date(df$startdate, format="%d.%m.%y")

head(df)
str(df)


### TO FACTOR

df$wheel
as.factor(df$wheel) # $Levels: 1 2 3 4 5 6 7 8 9
df$wheel <- as.factor(df$wheel)
str(df)





#### Adding/Removing a column ####

#traditional
df$totalruns <- df$day1 + df$day2 + df$day3 + df$day4
head(df)

#dplyr way
library(dplyr)
df<-df %>% 
  mutate(total = day1+day2+day3+day4) 

head(df)


### Removing

df$totalruns <- NULL
head(df)


### Subsetting
colnames(df) #let's only keep id, day1,day2,day3,day4,strain,total

newdf<-df[c(1:5,9,12)]   #traditional way
head(newdf)



#dplyr way
  
  df %>%
  select (id, day1, day2, day3, day4, strain, total) %>%
  head (8)

# can also change order really easily in dplyr

  df %>%
  select (id, strain, day1,day2,day3,day4,total) %>%
  head (6)



### let's go back to df with all columns

head(df)


### Let's get the age of each individual at the start of the study

df$startdate - df$dob  #can just do this as dates are in same format - difference in days
df$age <- df$startdate - df$dob
head(df)

df %>% mutate(age1 = startdate-dob) #dplyr way

str(df) #notice that R has automatically used the 'difftime' function to put the data in days.

df$age2<-as.numeric(df$age)
head(df)

df$age<-NULL
colnames(df)
colnames(df)[13]<-"age"
head(df)


#you can wrap things in R - this would have been a very quick way to do the column 'age'...  

df$age <- as.numeric(df$startdate - df$dob)  #R works inside to out
head(df)





#### Adding a column of factors with levels ####

#Here we are going to classify the strain by the type of strain that it is
#S129 and B6 are inbred mice
#F1-129B6 and F1-B6129 are hybrid mice
#Swiss are outbred mice


# Using matching.

strain<-unique(df$strain)
strain 

group<-c("inbred", "inbred", "hybrid", "hybrid", "outbred") #manually entered

micetypes<-data.frame(strain,group)
micetypes

head(df) #just to remind us of our data

df$type <- micetypes$group[match(df$strain, micetypes$strain)]  #things that are being matched go inside the brackets
#they don't have to have the same col/variable name
#thing being used as the new info goes in front of the brackets

df



# using merging
randomnamedf <- df %>% select(id,strain,type) #creating a separate df with every id, strain and type
head(randomnamedf)  #sometimes you may have this information in a separate datafile and want to merge with your other df

df$type<-NULL #let's pretend we hadn't yet got this variable
head(df)


merge(df,randomnamedf) #variables don't need to be ordered in same way
merge(randomnamedf,df)


#don't have to have equal observations e.g. merging micetypes
head(df)
micetypes
merge(df,micetypes) #notice how the observations get ordered accordingly

df<-merge(df,micetypes) 
head(df)

# There are excellent ways of merging dataframes with dplyr - will go through later



##### Sorting and ordering a dataframe #####

head(df)

#traditional
df[order(df$age),]
df[order(-df$age),] #descending
df[order(df$wheel, -df$day1),]


#dplyr ways
df %>% arrange (desc(total))    
df %>% arrange (wheel,strain)



### A bit of plotting  
library(ggplot2)
ggplot(df, aes(strain, total))  + geom_point(size=5)    #this is incredibly basic - lots more things we can do
