#####  Some more on functions  - part 2#####


# 1.  Adding in optional arguments that have defaults

# 2.  Adding in optional arguments that do not have defaults




# Say I have the all-time records of Tennis big-4 players against each other (as of Oct 2014)
# I'm going to write a function to return each players winning percentage

# this is just the data
players <- c("Djokovic", "Federer", "Murray", "Nadal")
wins    <- c(NA, 17, 14, 19, 19, NA, 11, 10, 8, 11, NA, 5, 23, 23, 15, NA)
mat <- matrix(wins, ncol=4, nrow=4, byrow=T)
rownames(mat) <- colnames(mat) <- players  #players get asssigned from right to left to all

mat  #winners are rows, losers are columns



## first write it as if we were just doing it in R without using a function.
## often it's good to work out how you'd do it on example data before generalizing it to a function


apply(mat,1,sum, na.rm=T)  # this gets the sum of all wins (rows) 
                           # - we could have made the diagonal 0 and not need na.rm=T


apply(mat,2,sum, na.rm=T)  # this gets the sum of all losses (columns)


# win percentage would be   total wins / (wins + losses)

z.win <- apply(mat,1,sum, na.rm=T)  
z.loss <- apply(mat,2,sum, na.rm=T)  
z.win + z.loss  # this gives the total games played (wins + losses) for each player
z.games <- z.win + z.loss

z.win / z.games  #this is the winning percentage.



# let's put it into a function...

winpct <- function(x){
  z.win <- apply(x,1,sum, na.rm=T)  
  z.loss <- apply(x,2,sum, na.rm=T)  
  z.games <- z.win + z.loss
  z.win/z.games
}

winpct(mat)  # we have created a function that takes a matrix and returns win percentage of players


## here is another matrix:

players1 <- c("Ashe", "Borg", "Connors", "Laver", "McEnroe")
wins1    <- c(NA, 7, 1, 2, 0, 7, NA, 15, 2, 7, 5, 8, NA, 3, 14, 13, 2, 0, NA, 0, 2, 7, 20, 0, NA)
mat1 <- matrix(wins1, ncol=5, nrow=5, byrow=T)
rownames(mat1) <- colnames(mat1) <- players1  #players get asssigned from right to left to all
mat1

# we already made our function, so just use it:

winpct(mat1)

#     Ashe      Borg   Connors     Laver   McEnroe 
#0.2702703 0.5636364 0.4545455 0.6818182 0.5800000 






### Say we wanted to add an option to the function to reduce the digits returned to 2 or 3.

round(0.352153255, digits=2) #this is how we get 2 dp
round(0.352153255, digits=3) #this is how we get 3 dp
round(0.352153255) # if you don't write digits= then it defaults to 0.

#let's add the argument 'n' to be our digits

winpct1 <- function(x, n){
  z.win <- apply(x,1,sum, na.rm=T)  
  z.loss <- apply(x,2,sum, na.rm=T)  
  z.games <- z.win + z.loss
  round( z.win/z.games , digits=n)
}

winpct1(mat, 2)
winpct1(mat, 3)
winpct1(mat1, 2)
winpct1(mat1, 3)

winpct1(mat)  # if we don't state it, the round function in our user function is defaulting to 0 also.
winpct1(mat1)


### A good solution here would be to make the argument 'n' optional 
### i.e. to have a default value that we choose that it will use if we don't specify.
# let's pick four decimal places as our default

winpct1 <- function(x, n=4){
  z.win <- apply(x,1,sum, na.rm=T)  
  z.loss <- apply(x,2,sum, na.rm=T)  
  z.games <- z.win + z.loss
  round( z.win/z.games , digits=n)
}

winpct1(mat, n=2)
winpct1(mat, 2)
winpct1(mat, 3)
winpct1(mat1, 2)
winpct1(mat1, 3)

winpct1(mat)  # it will now return values to 4 decimal places if we don't specify when we run it
winpct1(mat1)
winpct1(mat1, n=4)
winpct1(mat1, 4)



### Let's add another optional argument... but one that doesn't have a default value

# i.e. you might use it, you might not........


# say we might want to get winning percentages when removing one specific individual from the group.
# e.g. let's remove Ashe from mat1

# how we'd do it writing out the code in long-hand, i.e. not putting in a function just yet:

mat1  # we need to know which row/column Ashe is in

rownames(mat1)=="Ashe"    # [1]  TRUE FALSE FALSE FALSE FALSE

q <- rownames(mat1)=="Ashe"
q
min(which(q == TRUE))  #using which find which element of this vector q is the first to be 'TRUE'


q <- rownames(mat1)=="Laver"
q
min(which(q == TRUE))  #Just to show that it works even if position isn't =1


q <- rownames(mat1)=="Ashe"
q
min(which(q == TRUE))  #using which find which element of this vector q is the first to be 'TRUE'

q1 <- min(which(q == TRUE))
q1  #we now have a number that refers to the row number and column number we wish to remove.

mat1[-q1,]  #with a numerical index we can simply use -q1 to get rid of row number 1
mat1[,-q1]  #get rid of column numbr 1

mat1["Ashe",]  # you can refer to a row or column of a matrix by name too to return that row/column
mat1[-"Ashe", ]  # you can use negative indexing to remove it though if it is a name/character

#so, to remove Ashe from both rows and columns

mat1a <- mat1[-q1,]
mat1a
mat1b <- mat1a[,-q1]
mat1b #he has been removed completely

# or, more quickly
mat1
mat1[-q1,-q1]


## let's add that to our function

## in the first instance, we shall make it mandatory to add a player name


winpct2 <- function(x, n=4, player){

  q <- rownames(x)==player
  q1 <- min(which(q == TRUE))
  x <- x[-q1,-q1]

  z.win <- apply(x,1,sum, na.rm=T)  
  z.loss <- apply(x,2,sum, na.rm=T)  
  z.games <- z.win + z.loss
  round( z.win/z.games , digits=n)
}

mat1
winpct2(mat1, n=2)  # Error in winpct2(mat1, n = 2) : argument "player" is missing, with no default
winpct2(mat1, n=2, player="Ashe")
winpct2(mat1, n=2, "Ashe")
winpct2(mat1, 3, "Laver")



### OK, but the whole point was to make it optional and not have a default....

# using argument=NULL  with an if - else  and is.null statement

# the steps here are as follows:

# 1. check whether the argument player is.null (i.e. not present)
# 
# 2. if it is not present then do everything that comes after the is.null expression and
#    which is contained within the { } brackets that start right after the is.null and end
#    before the else
# 
# 3. If the player is not null (i.e. we put something in), then skip the stuff in the {} brackets after if
#    and go straight to the stuff after the 'else' and work on that instead.  (This is not in { } brackets ).


winpct3 <- function(x, n=4, player=NULL){
  
if(is.null(player)){
  
  z.win <- apply(x,1,sum, na.rm=T)  
  z.loss <- apply(x,2,sum, na.rm=T)  
  z.games <- z.win + z.loss
  winp <- round( z.win/z.games , digits=n)
  return(winp)

}

else

  q <- rownames(x)==player
  q1 <- min(which(q == TRUE))
  x <- x[-q1,-q1]

  z.win <- apply(x,1,sum, na.rm=T)  
  z.loss <- apply(x,2,sum, na.rm=T)  
  z.games <- z.win + z.loss
  winp1 <- round( z.win/z.games , digits=n)
  return(winp1)
}



winpct3(mat1)
winpct1(mat1) #just to show you it is the same as the function we wrote prior to adding the 'player' argument

winpct3(mat1,2)
winpct1(mat1,2)

winpct3(mat1, 2, player="Ashe")
winpct2(mat1, 2, player="Ashe") # this is the one that forces you to put a player in.

winpct3(mat1, 3, "Connors")
winpct3(mat, 2, "Murray")



# basically what we are writing is :
# if 'player' is absent, then do winpct1 function
# if 'player' is present, then do winpct2 function

# We could have written it like this - 

winpct4 <- function(x, n=4, player=NULL){
  if(is.null(player)){
    winpct1(x, n=2)
  }
 else
   winpct2(x, n=2, player)
}

winpct4(mat1, 3, "Ashe")
