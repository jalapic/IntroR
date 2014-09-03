
#### Getting Data into and out of R-studio ....  and some other basics  ####



# 1. Import Dataset tab - single file

#do this for the wheels.csv file

str(wheels)

wheels$day1

wheels$wheel

levels(wheels$wheel) #as wheel was coded as a number, it is not default a 'factor'
unique(wheels$wheel)  # [1] 8 4 1 2 5 6 9 7 3

levels(wheels$strain) #strain is already a factor
unique(wheels$strain)  # [1] "B6"       "F1-129B6" "F1-B6129" "S129"     "Swiss"  

wheels$wheel <- as.factor(wheels$wheel)
levels(wheels$wheel) #now ok    [1] "1" "2" "3" "4" "5" "6" "7" "8" "9"
unique(wheels$wheel)  # [1] 8 4 1 2 5 6 9 7 3



df <- wheels
str(df)

df1 = wheels    # I prefer to use   <-   
str(df1)






# 2. Run simple script in R file  - single csv file

#show how to use Files panel to manually set a new working directory

getwd() #tells you your default working directory

setwd("C:/Users/James Curley/Dropbox/Work/R/teachingR")  #put your desired folder address here

read.csv("ourdf.csv")

ourdf <- read.csv("ourdf.csv")  #works if your top row contains column/variable names
someothername <- read.csv("ourdf.csv")  

read.csv("ourdf.csv", header=TRUE)  #this is the default
read.csv("ourdf.csv", header=FALSE)  #doesn't work in this case

str(ourdf)
str(someothername)



read.csv("james1.csv") #whoops
read.csv("james1.csv", header=FALSE) #ok
james1<-read.csv("james1.csv", header=FALSE) #ok

str(james1)







###### Saving objects, Loading objects

setwd("C:/Users/James Curley/Dropbox/Work/R/teachingR")  #put your folder address here
setwd("C:/Users/curley/Dropbox/Work/R/teachingR")  #put your folder address here


<- #make some objects

Each object can be saved to the disk using the save() function. They can then be loaded into memory using load().

load("file.Rda")
...
# assume you want to save an object called 'df'
save(df, file = "file.Rda")





#### Data types of other formats  e.g. SPSS, Stata, JSON, SAS can be inputted - see:
#    http://en.wikibooks.org/wiki/R_Programming/Importing_and_exporting_data

# I would highly recommend though that you keep it simple by just using .csv files


