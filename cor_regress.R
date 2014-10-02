#### Correlation and Regression - the basics ####

head(wheels1)
plot(wheels1$day1,wheels1$day4)


#### Correlation ####


#Pearson's correlation

cor.test(wheels1$day1,wheels1$day4)
cor.test(wheels1$day1,wheels1$day4, method="pearson") #same, as is default
cor.test(wheels1$day1,wheels1$day4, method="p") #ditto


# Separman's rank correlation rho
cor.test(wheels1$day1,wheels1$day4,method="s") #method="spearman" abbreviated

# Kendall's rank correlation tau
cor.test(wheels1$day1,wheels1$day4,method="k") #method="kendall" abbreviated



# The alternative hypothesis can be set to "two.sided" (the default), "less", or "greater"

cor.test(wheels1$day1,wheels1$day4, method="p", alternative="two.sided") #default
cor.test(wheels1$day1,wheels1$day4, method="p", alternative="greater") #one-tailed
cor.test(wheels1$day1,wheels1$day4, method="p", alternative="less") #one-tailed


### Correlation and Covariance Matrices

set.seed(17)
mat <- matrix(runif(50,0,100), nrow=10, ncol=5)

mat
cor(mat)
cov(mat) #covariances of matrix
pairs(mat) #visual representation


### Performing multiple correlations

head(wheels1)

cbind(wheels1[,3:6], wheels1[,12:13], wheels1[,10])
cbind(wheels1[,3:6], wheels1[,12:13], wheels1$wheel)
cbind(wheels1[,3:6], wheels1[,12:13], wheel=wheels1$wheel) #look at difference between these

whe <- as.matrix ( cbind(wheels1[,3:6], wheels1[,12:13], wheel=wheels1$wheel) )

whe
plot(whe) #doesn't plot multiple panels if a matrix

whe1 <- as.data.frame(whe)
plot(whe1) #will do if dataframe


pair.cor(whe) #pair.cor is a custom made function - use a matrix as argument 1 containing columns of numerical data





####  Linear regression ####

plot(wheels1$age, wheels1$total)

lm.result<-lm(total~age, data=wheels1)     #outcome~predictor

summary(lm.result)

# In output: 
# 'residuals' is info about the distribution of the residuals.  
# They should be normally distributed: a median of 0 with 1Q/3Q and Min/Max being similar distances
#
# 'coefficients'...   
#   p-value by intercept & slope (independent variable) refer to if they are sig dif from 0
#

abline(lm.result)  #adds a simple regression line to plot


#checking residuals etc.
par(mfrow=c(2,2))  #sets the parameters of the graphics device
plot(lm.result)

plot(wheels1$age, wheels1$total) #see what par is doing... re-run this 4 times...
par(mfrow=c(1,1)) #reset the mfrom paramater

plot(wheels1$age, wheels1$total) #see what par is doing... re-run this 4 times...
plot(lm.result) # see what happens without doing par...


# The first plot is a standard residual plot showing residuals against fitted values.
# Points that tend towards being outliers are labeled. 
# If any pattern is apparent in the points on this plot, then the linear model may not be the appropriate one.

# The second plot is a normal quantile plot of the residuals. Check for normal distribution of residuals.

# The last plot shows residuals vs. leverage (undue influence). 
# Labeled points on this plot represent cases we may want to investigate as possibly having undue 
# influence on the regression relationship. e.g. case 52 & 53...

wheels1[52:53,]
lm.result$fitted[52]
lm.result$fitted[53]
lm.result$residuals[52]
lm.result$residuals[53]

table(wheels1$age) #these are the oldest and 3rd oldest individuals in the study


par(mfrow=c(1,1))                    # if you haven't already done this
plot(cooks.distance(lm.result))


# Cooks Distance - determines which data points have overly high influence on estimated coefficients

# - note, not all outliers will have overly high influence on estimated coefficients.
# - and not every data point with undue influence is an outlier.
# - can be used as a 'validity' check, but also to help influence where more data points needed.


# - case (row/obs) 52 and 53 are the highest

## what to do?  There are a number of ways to procede. 

# i. look at the regression coefficients without the outlying point in the model... 

wheels1a <- rbind(wheels1[1:51,] , wheels1[54:80,])
lm.result1a<-lm(total~age, data=wheels1a)     #outcome~predictor

lm.result1a #age has much less of an effect
lm.result

# ii. Another is to use a procedure that is robust in the face of outlying points...
# Called robust fitting of linear models
library(MASS)
rlm(total ~ age, data=wheels1)
?rlm

library(robustbase)
lmrob(total ~ age, data=wheels1)  #better than rlm

# for more info on robust regression:  http://www.maths.dur.ac.uk/Ug/projects/highlights/CM3/Stuart_Robust_Regression_report.pdf





#### Autocorrelation    (basically serial correlation) ####

# (more of an issue for those using time-series data, but I include it here anyway)
# Effectively you check to see if your residuals are autocorrelated (does n correlated with n+1 ?)


str(lm.result)
acf(lm.result$residuals) #correlation at lag=0 is 1 by default
                         #ideal is to have all residuals between blue dotted lines
                         #also may be ok if see some autocorrelatoin in first few lags but disappears quickly

                         #If have autocorrelation need to use 'diff'


## Durbin-Watson test  - statistical test for autocorrelation in data
library(lmtest)
dwtest(lm.result)  # p > 0.05 provides no evidence of correlation.







################   Switch now to nhl13 dataset ########################################################


#### Logistic regression ####

head(nhl13)  #outcome dependent variable is playoffs Y/N - test if FaceOff Percentage (FOpct) predicts it
str(nhl13)

hist(nhl13$FOpct, col="lightblue")
boxplot(FOpct~playoffs,data=nhl13)

glm.result<-glm(playoffs1~FOpct,family=binomial,data=nhl13)  # need to have numeric values of outcome var.

summary(glm.result)  

# the "estimate" is the increase in log-odds for a one-unit increase in the independent predictor variable
# If the log-odds estimate is positive, an increase in the predictor increases the probability of the outcome occurring. 
# If negative, a decrease in the predictor increases the probability of the outcome occurring.  
# model fit (AIC is Akaike's Information Criterion), is useful for comparing multiple models



## Some multiple regression for NHL data

hist(nhl13$P) #points distribution
plot(nhl13$PPpct, nhl13$P)
plot(nhl13$PKpct, nhl13$P)

lm.result<-lm(P~PPpct+PKpct,data=nhl13) #tests how PPpct and PKpct each affect dependent Points (P)
summary(lm.result)


plot(nhl13$GperG, nhl13$P)
plot(nhl13$GAperG, nhl13$P)

lm.result<-lm(P~GperG*GAperG,data=nhl13) #test interaction between GperG and GAperG as well as main effects 
summary(lm.result)

lm.result<-lm(P~SperG+SAperG+FOpct+SperG:FOpct,data=nhl13) #tests how indep1, indep2, indep3, and the interaction between indep1:indep3 affect dependent
summary(lm.result)









#### Multiple Regression ####

# multiple independent variables can be added in by using the "+" sign 
# interactions between independent variables by using ":"  
# or both the combination and interaction of two variables using the "*" sign

# As long as one variable is continuous, you can include the effects of categorical variables as well.

lm.result<-lm(total~age+strain,data=wheels1) #tests how age and strain predict total
summary(lm.result)

lm.result<-lm(total~age+strain+wheel,data=wheels1) #tests how age, strain and wheel predict total
summary(lm.result)



