#### T-tests, Non-parametric tests####


df <- bloodwork
str(df)
head(df)
tail(df)



## One-sample T-tests   

boxplot(df$bpsyst)
t.test(df$bpsyst, alternative = "less", mu = 130) # is mean < 130 ?

boxplot(df$hrate)
t.test(df$hrate, alternative = "greater", mu = 70) # is mean > 70 ?

boxplot(df$age)
blah <- df$age  #could just put data into a vector
blah
t.test(blah, alternative = "greater", mu = 40) 




# One sample:  The Single-Sample Wilcoxin Test

boxplot(df$cellcount)
wilcox.test(df$cellcount, mu=0.1, alternative = "greater")
wilcox.test(df$cellcount, mu=0.25, alternative = "less")

boxplot(df$immuncount)
wilcox.test(df$immuncount, mu=1, alternative = "greater")
wilcox.test(df$immuncount, mu=3, alternative = "less")

boxplot(df$immuncount2)
wilcox.test(df$immuncount2, mu=1, alternative = "greater")
wilcox.test(df$immuncount2, mu=4, alternative = "less")




## e.g. is there a difference between immuncount & immuncount2 
# (will also do this with paired t-test later)

temp <- df$immuncount2 - df$immuncount
temp
boxplot(temp)
wilcox.test(temp, mu=0, alternative = "greater")



#another way...

temp
sum(temp>0)   #14
length(temp)  #number of cases = 30

binom.test(x=14, n=30, p=0.5, alternative="greater")  #a binomial test - is x out of n observation a sig deviation from chance?
binom.test(14, 30, 0.5, alternative="greater") #1 tailed



## Two-sample t-tests

boxplot(df$hrate ~ df$smoker)  # quick simple boxplot


t.test(df$hrate ~ df$smoker)

t.test(hrate ~ smoker, data=df)

t.test(hrate ~ smoker, df)

t.test(df$hrate ~ df$smoker, var.equal=T)  #the default is actually for variances not to be equal
                                          #unequal variances assumed is the Welch correction


t.test(df$hrate ~ df$smoker, var.equal=T, alternative="less")
t.test(df$hrate ~ df$smoker, var.equal=T, alternative="greater")



# another way of doing it

split(df$hrate, df$smoker)  #split variable by factor

#$no
#[1] 63 65 66 67 71 62 68 63 63 66 68 77 73 62 71

#$yes
#[1] 73 80 74 80 70 77 73 77 71 61 77 74 65 77 80


split(df$hrate, df$smoker)$yes
split(df$hrate, df$smoker)$no

split(df$hrate, df$smoker)[1]
split(df$hrate, df$smoker)[2]

split(df$hrate, df$smoker)[[1]]
split(df$hrate, df$smoker)[[2]]

# see the difference between the above 3?   
# try putting str() around each to see what's different?


a <- split(df$hrate, df$smoker)[1]
b <- split(df$hrate, df$smoker)[2]
t.test(a,b,alternative="two.sided", var.equal=TRUE) # why doesn't it work?


a <- split(df$hrate, df$smoker)[[1]]
b <- split(df$hrate, df$smoker)[[2]]
t.test(a,b,alternative="two.sided", var.equal=TRUE) # why does it work ?


t.test(split(df$hrate, df$smoker)[[1]],
       split(df$hrate, df$smoker)[[2]],
       alternative="two.sided", var.equal=TRUE) # why does it work ?


a
b

t.test(a,b,alternative="two.sided", var.equal=TRUE)
t.test(a,b,alternative="less", var.equal=TRUE)

t.test(a,b,alternative="two.sided")   #default uses Welch's correction for unequal variances - look at dfs
t.test(a,b,alternative="less")





## non-parametric tests - Wilcox test / Kruskal-Wallis

# independent 2-group Mann-Whitney U Test - now called Wilcoxin-Mann-Whitney Test

shapiro.test(df$immuncount) #not normal
boxplot(df$immuncount~df$sex)

wilcox.test(df$immuncount~df$sex) 
wilcox.test(immuncount~sex, df) 



shapiro.test(df$immuncount2) #definitely not normal
boxplot(df$immuncount2~df$sex)

wilcox.test(immuncount2~sex, df) 
wilcox.test(immuncount2~sex, df, alternative=c("two.sided")) #default 
wilcox.test(immuncount2~sex, df, alternative=c("less")) 
wilcox.test(immuncount2~sex, df, alternative=c("greater")) 


a<-split(df$immuncount2, df$sex)[[1]] #females
b<-split(df$immuncount2, df$sex)[[2]] #males - it's done alphabetically

wilcox.test(a,b) # where y and x are numeric
wilcox.test(a,b, alternative=c("greater")) # where y and x are numeric



# Kruskal Wallis Test One Way Anova by Ranks 
boxplot(immuncount~state, df)
kruskal.test(immuncount~state, df) 

boxplot(immuncount2~state, df)
kruskal.test(immuncount2~state, df) 






#### Doing multiple tests #####


### quicker way of doing multiple t-tests across columns, 
### e.g. for hrate, bpsyst, cellcount, immuncount, immuncount2

head(df)
df[,7:11]

lapply(df[,7:11], function(x) t.test(x ~ df$smoker, var.equal = TRUE))  #easier if all data in consecutive columns

lapply(df[,c("age", "hrate", "immuncount2")], function(x) t.test(x ~ df$smoker, var.equal = TRUE)) # can name columns

mycolumns <- c("age", "immuncount", "cellcount", "hrate")
lapply(df[,mycolumns], function(x) t.test(x ~ df$smoker, var.equal = TRUE)) # can do it like this if easier 



### doing multiple normality tests (e.g. Wilks-Shapiro)

head(df)
df[,7:11]
apply(df[,7:11], 2, shapiro.test) #apply shapiro.test across columns 7-11 of df.



### doing multiple non-parametric tests

lapply(df[,7:11], function(x) wilcox.test(x ~ df$smoker)) #will get warnings about ties - it's ok



## Multiple One-Way ANOVA / linear regression
lapply(df[,7:11], function(x) anova(lm(x ~ df$smoker)))
lapply(df[,7:11], function(x) anova(lm(x ~ df$state)))
lapply(df[,7:11], function(x) anova(lm(x ~ df$sex)))
lapply(df[,7:11], function(x) summary(lm(x ~ df$age)))


## Multiple Kruskal-Wallis tests 
lapply(df[,7:11], function(x) kruskal.test(x ~ df$sex))
lapply(df[,7:11], function(x) kruskal.test(x ~ df$state))




#### doing multiple pairwise t-tests ####


## when have more than 2 levels of a factor

pairwise.t.test(df$immuncount,df$state , p.adjust.method="holm")





#### Paired t-test ####

df$immuncount2 - df$immuncount

hist(df$immuncount2 - df$immuncount, breaks=10)
abline(v=0, col="red", lwd=2)

t.test(df$immuncount, df$immuncount2, alternative=c("two.sided"), paired=TRUE)

# dependent 2-group Wilcoxon Signed Rank Test 
wilcox.test(df$immuncount, df$immuncount2, paired=TRUE) # where y1 and y2 are numeric






