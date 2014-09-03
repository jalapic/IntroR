#### Manually entering data using scripts  ####   and some other interesting things ... ###


color<-"blue"
str(color)  # chr "blue"
length(color)  #[1] 1

colors <- c("blue", "green")
str(colors)


mycolors <- rep(colors,2)
mycolors  # [1] "blue"  "green" "blue"  "green"

mycolors <- rep(colors,5)
mycolors  # [1] "blue"  "green" "blue"  "green" "blue"  "green" "blue"  "green" "blue"  "green"

mycolors <- rep(colors, each=2)
mycolors  # [1] "blue"  "blue"  "green" "green"

mycolors <- rep(colors, each=5)
mycolors  # [1] "blue"  "blue"  "blue"  "blue"  "blue"  "green" "green" "green" "green" "green"
str(mycolors)  #  chr [1:10] "blue" "blue" "blue" "blue" "blue" "green" "green" "green" "green" "green"


colors<-c("blue", "green", "pink", "yellow", "white", "black", "brown", "orange", "red", "purple")  #10 here
str(colors) #chr [1:10] "blue" "green" "pink" "yellow" "white" "black" "brown" "orange" "red" "purple"
length(colors)  # [1] 10

colors




### Using sample to randomly pick from a vector

sample(colors)  #we all should have a different first color - check !

set.seed(123)  #you can think of this as pre-determining the random algorithm
sample (colors)  # we should all have pink as first color !

set.seed(29471)
sample (colors)  # we should all have green as first color !
# [1] "green"  "black"  "white"  "orange" "brown"  "red"    "purple" "blue"   "yellow" "pink"  


sample(colors,2)  #again, all should be different

set.seed(17)
sample(colors,2)  #[1] "green" "red"  

set.seed(11)
sample(colors,9)  #[1] "pink"   "blue"   "white"  "red"    "brown"  "orange" "black"  "yellow" "green" 

set.seed(11)
mycolors<-sample(colors,9)
setdiff(colors,mycolors)  # [1] "purple"      setdiff compares two vectors and returns those in 1st but not 2nd argument


#try picking 11 colors
sample(colors,15)   # ERROR !
?sample
sample(colors, 15, replace=TRUE)
sample(colors, 15, replace=T)


#let's just pick 100 colors randomly picked with replacement from our vector of 10 colors....
set.seed(1001)
mycolors <- sample(colors, 100, replace=T)



#### do something similar for shapes

shapes<-c("square", "oblong", "diamond", "triangle", "circle", "oval", "star")

set.seed(1233)
myshapes <- sample(shapes,100,replace=T)



#### some things such as numbers and letters are made easy for us to type in.

LETTERS
# [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"

letters
# [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"

1:20
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

c(1:5, 15:20)
# [1]  1  2  3  4  5 15 16 17 18 19 20



# let's pick 5 LETTERS
set.seed(2111)
letters.chosen<-sample(LETTERS,5)
letters.chosen  #[1] "D" "G" "Q" "B" "X"

#and randomly get 100 of these chosen letters
myletters<-sample(letters.chosen, 100, replace=T)




### Picking random numbers

set.seed(11)
runif(5) #[1] 0.2772497942 0.0005183129 0.5106083730 0.0140479084 0.0646897766

set.seed(11)
runif(5, min=0, max=100) #[1] 27.72497942  0.05183129 51.06083730  1.40479084  6.46897766

set.seed(11)
numbers<-runif(5, min=0, max=100) 
round(numbers,digits=2)  # [1] 27.72  0.05 51.06  1.40  6.47
round(numbers,digits=1)  # [1] 27.7  0.1 51.1  1.4  6.5
round(numbers,digits=0)  # [1] [1] 28  0 51  1  6

set.seed(11)
round( runif(5, min=0, max=100) ,digits=0) #[1] 28  0 51  1  6

set.seed(11)
mynumbers<-round(runif(100, min=0, max=100), digits=0)


mycolors
myshapes
myletters
mynumbers

str(mycolors)
str(myshapes)
str(myletters)
str(mynumbers)





##### Putting things together into a dataframe   .... and switching between formats



data.frame(mycolors,myshapes,myletters,mynumbers)

mydf <- data.frame(mycolors,myshapes,myletters,mynumbers)

mydf

str(mydf)

head(mydf)


mydf$mycolors
mydf$myshapes
mydf$myletters
mydf$mynumbers

str(myshapes)
str(mydf$myshapes)

#converting between formats...

a1<-as.character(mydf$myshapes)
a2<-as.vector(mydf$myshapes)

str(a1)
str(a2)

as.matrix(mydf)


mydf


### Can type in variable headings as you go along like this...

df <- data.frame(foo=1:5,bar=c(T,T,F,F,T), animals=c("cat", "pig", "dog", "cow", "armadillo"))
df





#### What if we want to add in a new variable/column into a pre-existing dataframe.......

#traditional way:

sizes<- c("big", "small")

mydf$size <- sizes
mydf

#can overwrite 
mydf$size <- rep(sizes, each=50)
mydf



#dplyr way  (I want us all to become dplyr acolytes)

set.seed(110)
newnumbers<-round( runif(100, min=0, max=1) ,digits=1) 

library(dplyr)

mydf %>%
 mutate (score = newnumbers)

mydf<-mydf %>% mutate (score = newnumbers)

head(mydf)
tail(mydf)
colnames(mydf) #[1] "mycolors"  "myshapes"  "myletters" "mynumbers" "size"       "score" 
str(mydf)


setwd("C:/Users/James Curley/Dropbox/Work/R/teachingR")
write.table(mydf, "ourdf.csv", sep=",", row.names=F)    # go look in your folder - it should be there



##### A final example way of entering data

mydat <- edit(data.frame())   # I do not like this way, but ok for quick things.




