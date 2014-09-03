##### A quick recap of the different data types in R #####

# Vectors
# Factors
# Data frames
# Matrices
# Arrays
# Lists


#### Vectors ####

# Vectors are an ordered list of primitive R objects [elements] of a given type (e.g. real numbers, strings, logicals).
# Vectors are indexed by integers starting at 1. 

# in RStudio, you'll see vectors stored in the "Values" panel of the global environment

c(1,2,3,4,5)

c("a","b","c","d","e")

x <- c("blue", "green", "yellow", "green", "pink")
str(x) #character

c(T,F,T,F)
c(TRUE, FALSE, TRUE, FALSE) #notice the blue writing - R auto picks up these are logical
x <- c(T, T, T, F, F, F, F, F)
str(x)  #logical

1:5

5:1

x <- 1:12
str(x)  #integer

seq(1,5)

seq(1,5,by=.5)

rep(1,5)

rep(1:2,5)

rep(1:2,each=5)

x <- seq(1,5,by=.5)    # Create a sequence of numbers
x                      # [1] 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0
length(x)              # [1] 9
tail(x)                # [1] 2.5 3.0 3.5 4.0 4.5 5.0
tail(x,1)              # [1] 5
x[length(x)]           # [1] 5
x[9]                   # [1] 5

x <- c(T, T, T, F, F, F, F, F)
x[3]
x[4]


x <- c("blue", "green", "yellow", "green", "pink")
x[4]
x[3]==x[4]
x[2]!=x[4]
x[2]==x[4]
x[5]==x[1]
x[4]!=x[5]





#### Factors ####

# Factors are similar to vectors but where each element is categorical, 
# i.e. one of a fixed number of possibilities (or levels). 
# can be numerical or character



# A factor can also be ordered with the option ordered=T or the function ordered(). 

factor(c("yes","no","yes","maybe","maybe","no","maybe","no","no"))

x1 <- factor(c("yes","no","yes","maybe","maybe","no","maybe","no","no"))
str(x1)

x2 <- c("yes","no","yes","maybe","maybe","no","maybe","no","no")
str(x2)

levels(x1)  # [1] "maybe" "no"    "yes" 
levels(x2)  # NULL




# Ordering factors

factor(c("biggest","middle","biggest","smallest","smallest","middle","smallest","middle","middle"))

factor(c("biggest","middle","biggest","smallest","smallest","middle","smallest","middle","middle"), ordered = T)
#it picks it based on alphabetical order 

factor(c("green", "pink", "pink", "purple", "pink", "green", "blue"), ordered=TRUE)


x1 <- factor(c("green", "pink", "pink", "purple", "pink", "green", "blue"))
x2 <- factor(c("green", "pink", "pink", "purple", "pink", "green", "blue"), ordered=TRUE)

str(x1)
str(x2)

#using ordered()

factor(c("First","Third","Second","Fifth","First","First","Third"), ordered=T) 
ordered(factor(c("First","Third","Second","Fifth","First","First","Third")) )
ordered(c("First","Third","Second","Fifth","First","First","Third"))
ordered(as.factor(c("First","Third","Second","Fifth","First","First","Third")) )
                                 #above are all the same way of writing the same thing - annoyingly


## To reorder the levels of a factor in an appropriate way...
#note in this example, also put 'fourth' in as a level of the factor even though didn't appear in intial list


ordered(as.factor(c("First","Third","Second","Fifth","First","First","Third")),
        levels = c("First","Second","Third","Fourth","Fifth")  )

#but can just do this... 
ordered(c("First","Third","Second","Fifth","First","First","Third"),
        levels = c("First","Second","Third","Fourth","Fifth")  )


x1 <- ordered(as.factor(c("First","Third","Second","Fifth","First","First","Third")),
        levels = c("First","Second","Third","Fourth","Fifth")  )

x2 <- ordered(c("First","Third","Second","Fifth","First","First","Third"),
        levels = c("First","Second","Third","Fourth","Fifth")  )

str(x1)
str(x2)



## Fixing the order of levels of a vector....
#most often need this for plotting graphs

x <- c("Weds", "Tues", "Tues", "Sun", "Sat", "Sat", "Mon", "Fri", "Sat")
x
str(x) # chr [1:9] "Weds" "Tues" "Tues" "Sun" "Sat" "Sat" "Mon" "Fri" "Sat"

x1<-as.factor(x)
str(x1) #Factor w/ 6 levels "Fri","Mon","Sat",..: 6 5 5 4 3 3 2 1 3

x2 <- ordered(x, levels= c("Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun") )
x2
str(x2) # Ord.factor w/ 7 levels "Mon"<"Tues"<"Weds"<..: 3 2 2 7 6 6 1 5 6



### Try and give you a little example of this

days <- c("Weds", "Tues", "Tues", "Sun", "Sat", "Sat", "Mon", "Fri", "Sat")
scores <- c(1,2,3,10,6,2,1,5, 5)
mydf<-data.frame(days,scores)

str(days)  #note in a vector, the days are considered as characters
str(mydf)  #note how the days in a dataframe are already considered a factor

mydf

library(ggplot2)
ggplot(mydf, aes(days, scores))  + geom_point(size=5)  # days of the week are in alphabetical order

mydf$days <- ordered(mydf$days, levels= c("Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun") )  #order them

ggplot(mydf, aes(days, scores))  + geom_point(size=5)  # that's better  
                                                       # [though notice Thursday still isn't plotted - more on that later]




### Creating factors with function gl()

gl(n, k, length, labels=NULL)
# n is the number of levels, k the number of repetition of each factor and length the total length of the factor.
# labels is optional and gives labels to each level.

gl(n=2, k=2, length=10, labels = c("Male", "Female")) # generate factor levels
gl(2, 8, labels = c("Control", "Treat")) ## First control, then treatment
gl(2, 1, 20)  ## 20 alternating 1s and 2s
gl(2, 2, 20) ## alternating pairs of 1s and 2s

gl(5, 3, 20)  #[1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 1 1 1 2 2    ## notice this starts to repeat and cuts-off
x <- gl(5, 3, 20)
str(x)





#### Dataframes ####
# A dataframe is a list of variables/vectors of the same length. (they HAVE to be of the same length)

#  lots more about dataframes in other files as most commonly used data format

something1 <- 1:5
whatever <-  c(T,T,F,F,T)
animals <- c("cat", "dog", "elephant", "tree shrew", "cat")
whocares <- paste(something1, "carrot")                     #default separator is " " i.e. a space or whitespace
nonsense <- paste(something1, "tangerine", sep="")
blah <- paste(something1, "pineapple", sep="-")
seriously <- "October"
pointless <- 15

df <- data.frame(something1, whatever, animals, whocares, nonsense, blah, seriously, pointless)
df

df[,6]
df$blah



## can type in as you go
df <- data.frame(foo=1:5,bar=c(T,T,F,F,T), animals=c("cat", "pig", "dog", "cow", "armadillo"))
df







#### Matrix ####

# Basically a vector, but elements indexed by two integers [not just 1], both starting at 1..... (i.e. in rows and columns)


###  Creating a  Matrix 

#1. enter a vector of data
#2. enter number of rows and columns
#3. state if want it to be read by row or by column (if say nothing it does it by column)

matrix(data = NA, nrow = 5, ncol = 5)
matrix(data = NA, nrow = 5, ncol = 5, byrow = T)

matrix(data = 1:15, nrow = 5, ncol = 5)              #notice how it will go back to the beginning of the vector to fill the matrix
matrix(data = 1:15, nrow = 5, ncol = 5, byrow = T)  

matrix(0,10,10)

set.seed(11)
matrix (runif(100,0,2), 10, 10)

set.seed(11)
mymatrix<-matrix (runif(100,0,2), 10, 10)
str(mymatrix)

setwd("C:/Users/James Curley/Dropbox/Work/R/teachingR")
write.table(mymatrix, "james1.csv", sep=",", row.names=F, col.names=F)    # go look in your folder - it should be there



matrix (1,8,8)
matrix (1,nrow=2,ncol=2)

mat<-matrix (1,8,8); mat
diag(mat)<-NA
mat

#matrices don't have to be square
matrix (runif(10), nrow=2, ncol=5)
matrix (runif(10), 2, 5)




# If you want to put several vectors together in a matrix there are useful functions for this:

v1 <- 1:5
v2 <- 5:1
v3 <- 10

rbind(v1,v2,v3)
cbind(v1,v2,v3)

x1<-rbind(v1,v2,v3)
x2<-cbind(v1,v2,v3)
str(x1)
str(x2)

cbind(v1,v2,v3)
cbind(v3,v1,v2)

cbind(v2,v1,9,12:16)                 # notice that the last two don't have variables names (colnames)
cbind(v2,v1,9,12:16, letters[1:5])   # matrices can have numeric or characters only

x <- cbind(v2,v1,9,12:16, letters[1:5])
str(x)
colnames(x) # [1] "v2" "v1" ""   ""   ""    - can use colnames on matrices too



a <- matrix(2,2,2)
a

a <- rbind(a,c("A","A"))   #adding to existing matrix
a



# other functions used on dataframes can largely be used for matrices too

x <- matrix(data = 1:15, nrow = 3, ncol = 5, byrow = T)
x

dim(x)   #rows by columns
nrow(x)
ncol(x)

t(x)  #transposes the matrix







#### Lists ####

# a list is a collection of R objects
# The elements of a list can be indexed either by integers or by named strings, 
# The objects in a list do not have to be of the same type or length.


list(x) #creates a list
unlist(x) #turns a list into a vector

x <- c(1:4)
y <- FALSE
z <- matrix(c(1:4),nrow=2,ncol=2)
myList <- list(x,y,z)
myList







lists have very flexible methods for reference

by index number:


a <- list()
a

a[[1]] <- "A"
a


a[[2]]<-"B"
a


#by names

a$fruit = "Apple"

a$color = "green"

a

a[[3]]  #note that this retrieves the third element in the list
a[[4]]





#### Arrays ####
# Arrays are similar to matrices but can have more than 2 dimensions. 

# we're not going to talk about them just yet

