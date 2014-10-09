IntroR
======


### Here are some introductory tutorials and csv files for learning R

These are files that I use in class to teach begginers/intermediates various things in R.
I have written them with the intention of discussing the code as we go through it in class.
This is why sometimes I repeat myself a lot or change one thing incrementally.

You will probably be fine to just go through these by yourself, but if you need help just ask. 


I first go over some basics of R, though I like to sprinkle some more interesting things in the first few tutorials too.
Then we discuss some simple plotting in base-r and ggplot2.
Interspersed with that we discuss basic statistical analyses.

Throughout I try to emphasize tools that make our data management easier and more fruitful for analysis.
I also add in the odd *cool* thing that beginners might not know they can do in R and that we behavioral scientists don't always do.  For instance, web scraping & text mining to name a couple.


In the future we will expand our understanding of functions, simulations and more advanced programming.  We shall also discuss dynamic visualizations (e.g. ggvis, shiny, rCharts) as well as why we should be using RMarkdown to improve our workflow.

We will also discuss some more specific packages that relate to our lab's research interests (if any of you are still in the class by then!).


NOTE:   As I expand this, I acknowledge the repository is getting messy - I will try to do some management of it shortly.


NOTE2:  As I put this together, I have obviously brought together a lot of information from a lot of sources.  Most (all, I hope) of these are listed in the file called   "usefulRlinks.txt"  .   Please use those resources.   Where I have taken something directly from somebody else's webpage, I have added that link/reference to the original author (e.g. the multiplecortest.R function).




### The files

- r1 - Getting data into and out of RStudio
- r2 - Manually entering data and a couple of other quick things
- r3 - Navigating around a dataframe
- r4 - A quick recap/overview of the different data types in R
- r5 - Getting summary statistics

- histograms.R      - includes testing for normality
- boxplots.R        - includes one-way anova, kruskal-wallis tests, testing for unequal variances
- scatterplots.R   
- cor_regress.R     - basic parametric & non-parametric correlation and linear/logisitic regression
- multiplecortest.R - contains a function to run multiple cor.tests (see reference therewithin)

- stats1.R          - basics of various T-tests and non-parametric group comparison stats 
- permute1.R        - introduction to randomization of data for T-tests, One-Way ANOVAs


... and some other things:
- ranking.R         - just some basics on how to perform ranking
- scape.R           - a very, very brief intro to web scraping with library(XML)



### There are a number of csv files used as example datasets

- bloodwork.csv
- james1.csv
- nhl13.csv
- ourdf.csv
- parity.csv
- rocks.csv
- wheels.csv
- wheels1.csv
 
 






Please read the usefulRlinks for more information and also for some of the sources that the odd tutorial was inspired by.
