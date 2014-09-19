#### Getting Summary Statistics ####


rm(list = ls(all = TRUE))  # clean global environment

setwd("C:/Users/James Curley/Dropbox/Work/R/teachingR/IntroR")  #put your folder address here
setwd("C:/Users/curley/Dropbox/Work/R/teachingR/IntroR")  #put your folder address here

df<-read.csv("wheels1.csv")

df<-wheels1

head(df)





####  using base functions ####


summary(df)


df$age
temp<-df$age  #just putting the 'age' variable into a vector called temp

mean(df$age)
mean(temp)

sd(df$age)
sd(temp)

var(df$age)
var(temp)

length(df$age)  #could use nrow(df$age) but makes more sense to use length
length(temp)


#Standard error doesn't exist in base package of R
# need to write our own function

sem <- function(x) sqrt(var(x, na.rm=T)/length(x))

sem1<-function(x){
  sqrt(var(x, na.rm=T)/length(x))
}

sem(df$age)
sem(temp)

sem1(df$age)
sem1(temp)


min(df$total)
min(df$total, na.rm=T)

max(df$total, na.rm=T)

range(df$total, na.rm=T)

IQR (df$total, na.rm=T)

median (df$total, na.rm=T)

mad(df$total, na.rm=T) #the median absolute deviation.

quantile(df$total, c(0.25, 0.5, 0.75), type = 9, na.rm=T)   #look up help function for types


library(psych)   ### using pscyh package
describe(df)     # gives way more detail than summary() from base package

colnames(df)
describe(df[c(3:6,12)])

describe(df$total)





#### Using apply ####

## apply()   can be used on columns or rows 

df1<-df[c(3:6,12,13)]  # let's put all numerical data into a separate df
head(df1)

apply(df1,2,mean)  #apply runs a function (3rd argument) over a dataframe/matrix (1st argument)
                   #the second argument is either a 1 - refers to rows,  or 2 - refers to columns

apply(df1,2,sem)  # more on the NAs in a little bit


# we can make transformations of data with apply too - 
set.seed(88)
mat <- matrix(runif(100,0,100), 20, 5)
mat

apply(mat, 2, function(x) x/sum(x)*100)  #e.g. getting percentages of each observation within each column

apply(mat,2,cumsum)  #getting cumulative scores across each row



## using apply across rows...
df2 <- df1[c(1:4)]
head(df2)

apply(df2,1,mean)
df2$averagerevs <- apply(df2,1,mean)

head(df2)


apply(df2,1,sem)


## putting the results of apply across rows into the same dataframe containing the data

colnames(df)

df3 <- df[c(1:6)]  # just making a new df to make it easier to see what we're doing
head(df3)

df3[,3:6]  #these are the columns/variables with our numerical data

apply(df3[,3:6] , 1, mean)

df3$mean <- apply(df3[,3:6] , 1, mean)
df3$sem  <- apply(df3[,3:6] , 1, sem)
df3$min  <- apply(df3[,3:6] , 1, min)
df3$max  <- apply(df3[,3:6] , 1, max)

head(df3)










#### Getting summary stats by group/factor level ####


#### Doing things the dplyr way ####

head(df)

library(dplyr)

df %>%
  group_by(strain) %>%
  summarise(mean(day1), mean(day2), mean(day3), mean(day4), mean(total))

df %>%
  group_by(strain) %>%
  summarise(mean(day1), mean(day2), mean(day3), mean(day4, na.rm=T), mean(total, na.rm=T))

df %>%
  group_by(strain) %>%
  summarise(M1=mean(day1), M2=mean(day2), M3=mean(day3), M4=mean(day4, na.rm=T), MTOT=mean(total, na.rm=T))


df %>%
  group_by(strain) %>%
  summarise(mean=mean(total, na.rm=T), sd=sd(total, na.rm=T), sem=sem(total), count = n())


#here, we can't use na.rm=T for 'sem' as we wrote the function - have to adapt it
sem_new <- function(x) sqrt(var(x, na.rm=T)/length(x))


df %>%
  group_by(strain) %>%
  summarise(mean=mean(total, na.rm=T), sd=sd(total, na.rm=T), sem=sem_new(total), count = n())




### Grouping by more than one variable

newdf<-read.csv("parity.csv")   # let's load a different dataset
head(newdf)
tail(newdf)
str(newdf)

newdf %>%
  group_by(parity,sex) %>%
  summarise(mean=mean(latency, na.rm=T), sd=sd(latency, na.rm=T), sem=sem_new(latency), count = n())

newdf %>%
  group_by(sex,parity) %>%
  summarise(mean=mean(total, na.rm=T), sd=sd(total, na.rm=T), sem=sem_new(total), count = n())


newdf %>%
  group_by(sex,parity) %>%
  summarise_each(funs(mean(., na.rm=TRUE)),latency,min1,total)

# adding in 'n' - not sure this is the 'best' way of doing it, but works...
newdf %>%
  group_by(sex,parity) %>%
  tally %>%
  left_join(newdf) %>%
  group_by(sex,parity,n)%>%
  summarise_each(funs(mean=mean(., na.rm=TRUE)),latency,min1,total)


#### Using base functions  - aggregate, by   - still useful to know how to do

head(newdf)
colnames(newdf)

newdf[,5:7]

aggregate(newdf, by=list(newdf$sex,newdf$parity), FUN=length)
aggregate(newdf[,5:7], by=list(newdf$sex,newdf$parity), FUN=mean, na.rm=T)
aggregate(newdf[,5:7], by=list(newdf$sex,newdf$parity), FUN=sd, na.rm=T)
aggregate(newdf[,5:7], by=list(newdf$sex,newdf$parity), FUN=sem_new)
aggregate(newdf[,5:7], by=list(newdf$sex,newdf$parity), FUN=max, na.rm=T)

#naming columns
aggregate(newdf, by=list(sex=newdf$sex,parity=newdf$parity), FUN=length)
aggregate(newdf[,5:7], by=list(sex=newdf$sex,parity=newdf$parity), FUN=mean, na.rm=T)
aggregate(newdf[,5:7], by=list(sex=newdf$sex,parity=newdf$parity), FUN=sd, na.rm=T)
aggregate(newdf[,5:7], by=list(sex=newdf$sex,parity=newdf$parity), FUN=sem_new)
aggregate(newdf[,5:7], by=list(sex=newdf$sex,parity=newdf$parity), FUN=max, na.rm=T)




x <- aggregate(newdf[,5:7], by=list(sex=newdf$sex,parity=newdf$parity), FUN=mean, na.rm=T)
x
round(x[,3:5], digits=2)




#### SUPER FAST - data.table ####

### A final way of getting quick summary stats is to use the (data.table) package -  we'll do a whole topic on that package

library(data.table)      # this may be a package worth knowing about if your data has 1000s of rows/columns - SUPER FAST !

dt <- as.data.table(newdf)
dt


dt[,list(totalmedian=median(total)),by=sex]

dt[,list(totalmedian=median(total)),by=list(sex,parity)]

dt[,list(mean=mean(total), median=median(total)),by=list(sex,parity)]

dt[,list(mean=mean(total), 
         median=median(total),
         sd=sd(total), 
         sem=sem_new(total) ),
         by=list(sex,parity)]

