#### Histograms and Density Plots ####

### We shall cover base-R plotting (useful for quick looks at data)

### We shall start learning how to use ggplot2  (to make better looking publication quality figures)




library(ggplot2)

wheels1          #import datasets
head(wheels1)  



hist(wheels1$total)
hist(wheels1$total, col="lightblue")
hist(wheels1$total, col="lightblue", ylim=c(0,25))
hist(wheels1$total, col="lightblue", ylim=c(0,25), main="Total wheel revolutions")

hist(wheels1$total, col="lightblue", ylim=c(0,25), 
     main="Total wheel revolutions", xlim=c(0,100000))  #notice the x-axis


hist(wheels1$total)   #10 bins as default with this plot
hist(wheels1$total, breaks=15)
hist(wheels1$total, breaks=5, col="pink")

# more precise control over breaks
hist(wheels1$day1)
hist(wheels1$day1, breaks=c(0, 2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000, 22500, 25000))
hist(wheels1$day1, breaks=seq(0,25000,by=2500)) #better way of writing above line



# Instead of counting the number of datapoints per bin, show probability densities 
hist(wheels1$total, freq=FALSE, main="Density plot of wheel revolutions")


hist(wheels1$total, 
     col="lightblue", ylim=c(0,25), main="Density of wheel revolutions",
     xlab="number of revolutions")



#### Doing histograms and density plots the ggplot2 way


m <- ggplot(wheels1, aes(x=total))  # build from here

m + geom_histogram() # stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.

m + geom_histogram(binwidth = 1000)
m + geom_histogram(binwidth = 5000)
m + geom_histogram(binwidth = 10000)

m + geom_histogram(color = "darkgreen", fill = "white", binwidth = 10000)
m + geom_histogram(color = "darkgreen", fill = "darkseagreen3", binwidth = 10000)


m + geom_histogram(aes(fill = ..count..))  #looks a bit silly
m + geom_histogram(aes(fill = ..count..), binwidth = 10000)  #still silly


m + geom_histogram(color = "firebrick", fill = "lightcoral", binwidth = 10000)


m + geom_histogram(aes(y = ..density..)) #Removed 4 rows containing non-finite values (stat_density). 

m + geom_histogram(aes(y = ..density..), color = "firebrick", fill = "lightcoral", binwidth = 10000)

m + geom_histogram(aes(y = ..density..), color = "firebrick", fill = "lightcoral", binwidth = 10000) +
  geom_density() 

m + geom_histogram(aes(y = ..density..), color = "firebrick", fill = "lightcoral", binwidth = 10000) + 
  geom_density(lwd=2) 


m + geom_histogram(aes(y = ..density..), color = "firebrick", fill = "lightcoral", binwidth = 10000) + 
  geom_density(lwd=1, lty=2, color="blue") 


m + geom_histogram(aes(y = ..density..), color = "black", fill = "white", binwidth = 10000) + 
  geom_density(lwd=1, color="darkred", alpha=.4, fill="red") 


#storing a graph
m1 <-    m + geom_histogram(aes(y = ..density..), 
                   color = "firebrick", fill = "lightcoral", binwidth = 10000) + 
                   geom_density(lwd=1, lty=2, color="blue") 

m1 #plots can be r-objects

m1 + geom_vline(aes(xintercept=mean(total, na.rm=T)),   # Ignore NA values for mean
           color="black", lty=5, size=1)

m1 + geom_vline(aes(xintercept=mean(total, na.rm=T)),   
                color="black", lty=5, size=1) + 
                theme_minimal()


### Use facets to show groups
head(wheels1)
m1
m1 + facet_grid( ~ strain)


# Or if you want to be fancy, maybe even this
ggplot(wheels1, aes(total, fill = strain)) + geom_density(alpha = 0.2)

ggplot(wheels1, aes(total, fill = strain)) + geom_density(alpha = 0.2) + theme_minimal()



### Test for normality - one sample, + split samples by strain

# Shapiro-Wilk test of normality  - powerful!

shapiro.test(wheels1$total)


# Shapiro-Wilk normality test
#
# data:  wheels1$total
# W = 0.9822, p-value = 0.363


split(wheels1$total, wheels1$strain)

mydata <- split(wheels1$total, wheels1$strain)
str(mydata)

lapply(mydata, shapiro.test)  # performs the function shapiro.test across list 'mydata'
  

# If you have <4 groups and many observations per group, 
# then could check for normality separately per group
# If you have many groups, or few observations per group - 
# better to use whole sample as one





# QQ Plot

qqnorm(wheels1$total) #plots observed vs. expected normal quantiles for any numerical variable

# If the data are normally-distributed, the points should fall along a line through the first and third quartiles.  To add that line, use:
  
qqline(wheels1$total) #adds the interquartile line to the existing plot

#nb. if your variances between groups are not equivalent, then a qqplot isn't helpful (could do a separate qqplot by group if have large samples)

library(qualityTools)
qqPlot(wheels1$total) # i prefer this way of doing a qqplot


