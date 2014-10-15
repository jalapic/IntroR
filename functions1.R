#### Writing functions - part 1 ####

# Functions really are what elevates R above all other stats programming languages (imo)

# Functions to aid in your analysis
# Functions to help you avoid repeating yourself
# Functions to customize your output



myname <- function(<arguments.in.here>){  
#put code in here to do stuff#
#sometimes a command to print, return or cat the output - sometimes not#
} 

# things about functions that will prove useful to you:
  #i.   functions can be passed as arguments to other functions
  #ii.  functions can be nested - one function can be inside another function
  #iii. arguments can be formal (required) or optional
  #iv.  arguments may also have default values if not specified by user


args(sd)  # function (x, na.rm = FALSE) 
formals(sd)  # what are required ?

# $x
# $na.rm [1] FALSE

?sd


## example

x<-c(4,5,2,NA,2)
x # [1]  4  5  2 NA  2

sd(x)           #[1] NA
sd(x,na.rm=T)   #[1] 1.5

# although the function sd still ran with only y it was defaulting to na.rm=F
# overrode that by including na.rm=T



## next example

# let's do a simple function on a vector x that has these numbers
# say I want to write a function that returns the mean, sd and a histogram

x <- c(5,1,7,8,3,2,4,4,6,4,6,6,5,5,3,5,7,3,5,6,4,9)
x


getstuff <- function(x){

mean(x)
sd(x)
hist(x)  
}

getstuff(x)  # what got returned/printed to you ?  what didn't ?


# The returned value of a function is by default 
# is what got produced by the last expression in the function

dev.off() # this just clears the plot area (so you can see what's going on better)



# make sure you put 'print' in front of things that you want to get
getstuff1 <- function(x){
  
print(  mean(x) )
print(    sd(x) )
        hist(x)  
}


getstuff1(x)  #see what got returned this time ?

#print basically prints the returned value to the console.








#### Passing more than one argument to a function.

# An argument is something that you pass to the function (i.e. tell the function)
# that it's coming and that it is to use it in the function.

getstuff2 <- function(x, mycolor){  # <- here 'x' is an argument, so is 'mycolor'

dev.off() #clear console
  

getstuff2 <- function(x, mycolor){
    
    print(  mean(x) )
    print(    sd(x) )
    hist(x, col=mycolor)  
  }
  
  
getstuff2(x)  #get an error message.  It was expecting 'mycolor' and you didn't put it in.

getstuff2(x, red) #error: remember that colors have to be in quotes for plots

getstuff2(x, "red")
getstuff2(x, "pink")
getstuff2(x=x, mycolor="darkseagreen") # you can also name arguments like this if easier for you
                                       


## if you don't name your required arguments, then R will try to find them in this order:

# partial matching:   does some name look like the argument name?
# ordered matching:   reads the arguments in the order defined in the function

getstuff2(mycol="magenta", x)  

# it partially matched mycol to mycolor even though the arguments are not in order


dev.off() #clear console




### NOTE: There are some arguments where you HAVE TO name arguments that you are using

a <- 1:5
b <- letters[1:5]
a
b

paste(a,b)
paste(a,b, sep="-")

c <- "x"

paste(a,b,c,sep="-")

args(paste) # function (..., sep = " ", collapse = NULL) 
# the " ... " means here that many things could go before   sep=
# therefore you need to tell it when sep=  is starting.


#NOTE 2:   the   ...   in function arguments can mean other things too (more later)



#### Alternative ways of getting output from functions ####

# Say we want to return the mean, sd and n of a vector in one list

#using return


getstuff4 <- function(x){
  mean(x)
  sd(x)
  length(x)
     
}

x
getstuff4(x)  # remember the function only returns the last run expression 



getstuff5 <- function(x){
  x1 <- mean(x)
  x2 <- sd(x)
  x3 <- length(x)
}

x
getstuff5(x)  # it didn't return anything as all 
              # you did was assign mean,sd,length to an internal vector




getstuff6 <- function(x){
  x1 <- mean(x)
  x2 <- sd(x)
  x3 <- length(x)
  return(x2)
}

x
getstuff6(x)  # you told it to return x2 (the sd of x)





getstuff7 <- function(x){
  x1 <- mean(x)
  x2 <- sd(x)
  x3 <- length(x)
  return(x1)
  return(x2)
  return(x3)
}

x
getstuff7(x)  # this seems logical but doesn't work - in fact, it's a bit weird



### need to return results of each internal function in a list like this:


getstuff8 <- function(x){
  x1<-mean(x)
  x2<-sd(x)
  x3<-length(x)
  result <- list(x1,x2,x3)
  return(result)   
}

x
getstuff8(x)


# which could be shortened to ...

getstuff9 <- function(x){
  x1<-mean(x)
  x2<-sd(x)
  x3<-length(x)
  return(list(x1,x2,x3))
}

x
getstuff9(x)



#### Or, using cat

getstuff10 <- function(x){
  x1<-mean(x)
  x2<-sd(x)
  x3<-length(x)
  cat("Mean=", x1, "\n", "SD=", x2, "\n", "N=", x3, "\n")
}

x
getstuff10(x)  #the "\n" means new line.



## we could have written the above like this, but I think it's harder to read

getstuff11 <- function(x){
  cat("Mean=", mean(x), "\n", "SD=", sd(x), "\n", "N=", length(x), "\n")
}

x
getstuff11(x)  



