#### Scatter plots ####

library(ggplot2)

wheels1          #import datasets
head(wheels1)  


## get a quick picture of the dataset with plot()

plot(wheels1)    # O M G


head(wheels1)  #identify variables we're actually interested in 

plot(wheels1[c(3,4,5,6,12, 10)])   # can cope with this - btw, what's with wheel6 on day 1?



# Let's look at day1 versus day4 

plot(wheels1$day1, wheels1$day4)

day1 <- wheels1$day1
day4 <- wheels1$day4

plot(day1,day4)


plot(day1,day4, xlab="Day1 revs", ylab="Day4 revs", main="Comparing Day1 vs Day4 wheel running")

plot(day1,day4, xlab="Day1 revs", ylab="Day4 revs", main="Comparing Day1 vs Day4 wheel running",
     xlim=c(0,30000), ylim=c(0,30000))

plot(day1,day4, 
     xlab="Day1 revs", 
     ylab="Day4 revs", 
     main="Comparing Day1 vs Day4 wheel running",
     xlim=c(0,30000), 
     ylim=c(0,30000),
     col="blue")

plot(day1,day4, 
     xlab="Day1 revs", 
     ylab="Day4 revs", 
     main="Comparing Day1 vs Day4 wheel running",
     xlim=c(0,30000), 
     ylim=c(0,30000),
     col="blue",
     pch=19)          #google "pch r" to see possible shape types


#back to basics.....
plot(day1,day4)


#change color and shape of point based on group...

as.integer(wheels1$strain)
plot(day1,day4, pch=as.integer(wheels1$strain),col=as.integer(wheels1$strain))



# if you want to manually edit color schemes...
unique(wheels1$strain)

data.frame(strain=unique(wheels1$strain))

colorsdf <- data.frame(strain=unique(wheels1$strain))
colorsdf$color <- c("black", "dodgerblue4", "dodgerblue2", "grey", "red")

colorsdf

merge(wheels1,colorsdf)

wheels1 <- merge(wheels1,colorsdf)

plot(day1,day4, pch=19,col=wheels1$color)



## changing size of points with cex
plot(day1,day4, pch=19,col=wheels1$color, cex = .9)
plot(day1,day4, pch=19,col=wheels1$color, cex = 1.5)



## Add fit lines
abline(lm(day4~day1), col="red") # regression line (y~x) 
abline(lm(day4~day1), col="black")  
abline(lm(day4~day1), col="red", lwd=3) 





#### Scatterplots with ggplot2

wheels1$color <- NULL
head(wheels1)


# Basic scatterplots with regression lines

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=1)      

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19)      

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5)      

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5) +
       geom_smooth(method=lm)   # Add linear regression line 
                                #  (by default includes 95% confidence region)

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5) +
        geom_smooth(method=lm, se=FALSE)   # Add linear regression line 
                                           #  Don't add shaded confidence region

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5) +
  geom_smooth(method=lm, se=FALSE, fullrange=T) # Extend regression lines



ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5) +
  geom_smooth()   # Add a loess smoothed fit curve with confidence region



## Set color by another variable
ggplot(wheels1, aes(x=day1, y=day4, color=strain)) + geom_point(shape=19, size=5)      

## we can do endless things to make the color look nicer....
ggplot(wheels1, aes(x=day1, y=day4, color=strain)) + geom_point(shape=19, size=5) +
   scale_colour_hue(l=50)  # Use a slightly darker palette than normal
  
ggplot(wheels1, aes(x=day1, y=day4, color=strain)) + geom_point(shape=19, size=5) +
  scale_colour_brewer()

ggplot(wheels1, aes(x=day1, y=day4, color=strain)) + geom_point(shape=19, size=5) +
  scale_colour_brewer(palette="Set1")

ggplot(wheels1, aes(x=day1, y=day4,color=strain)) + geom_point(shape=19, size=5) +
  scale_colour_brewer(palette="Set3")

ggplot(wheels1, aes(x=day1, y=day4,color=strain)) + geom_point(shape=19, size=5) +
    scale_color_manual(values = c("darkolivegreen", "orange4", "orange1", "sienna1", "darkseagreen2"))

ggplot(wheels1, aes(x=day1, y=day4,color=strain)) + geom_point(shape=19, size=5) +
  scale_color_manual(values = c("darkolivegreen", "orange4", "orange1", "sienna1", "darkseagreen2")) +
  theme_bw()

#..... just keep playing around with it.....







## Set shape by condition
ggplot(wheels1, aes(x=day1, y=day4, shape=strain)) + geom_point(size=5) #take shape out of point into main

# Same, but with different shapes
ggplot(wheels1, aes(x=day1, y=day4, shape=strain)) + geom_point(size=5) +
  scale_shape_manual(values=c(1,2, 5, 7, 10))  # google shape types



# Jitter the points - more useful when there are many more data points

ggplot(wheels1, aes(x=day1, y=day4, color=strain, shape=strain)) + geom_point(size=5) ## no jitter

ggplot(wheels1, aes(x=day1, y=day4, color=strain, shape=strain)) + 
      geom_point(size=5, position=position_jitter(width=100,height=100))   ## keep running this to see what's happening






### Adding regression lines by group... 

ggplot(wheels1, aes(x=day1, y=day4, color=strain, shape=strain)) + 
     geom_point(size=5)  +
     geom_smooth(method=lm, se=FALSE)  


ggplot(wheels1, aes(x=day1, y=day4, color=strain, shape=strain)) + 
  geom_point(size=5)  +
  geom_smooth(method=lm, se=F, lwd=1.5)  




### Faceting by group

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5)  +
  facet_grid( ~ strain)

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5)  +
  geom_smooth(method=lm, se=F, lwd=1.5)  +
  facet_grid( ~ strain)

ggplot(wheels1, aes(x=day1, y=day4)) + geom_point(shape=19, size=5)  +
  geom_smooth(method=lm, se=F, lwd=1, lty=2, color="red")  +
  facet_grid( ~ strain)









