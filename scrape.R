#### Very basic web scraping

# the table from this website:   http://www.nhl.com/ice/teamstats.htm?navid=nav-sts-teams#

url <- "http://www.nhl.com/ice/teamstats.htm?navid=nav-sts-teams#"

library(XML)

## scrape

a<-readHTMLTable(doc=url, header=TRUE)

a      #look at output

a[[4]]  #this is the table we want

nhl13 <- a[[4]]

str(nhl13)
colnames(nhl13)

names<-c("blank", "Team",	"GP", "W",	"L",	"OT",	"P",	"ROW",	"HROW",	"RROW",	"Ppct",	"GperG",	"GAperG",	
"fiveFA", "PPpct",	"PKpct",	"SperG",	"SAperG",	"Wscore", "Wtrail",	"Wlead1",	"Wlead2", 	"Woutshoot",	"Woutshot", "FOpct")

colnames(nhl13) <- names

head(nhl13)


str(nhl13)
nhl13[,3:25] <- apply(nhl13[,3:25],2,as.numeric)
nhl13[,1] <- NULL

str(nhl13)


nhl13$playoffs <- c(rep("Y",16), rep("N",14))  #add in who made the playoffs
nhl13$playoffs1 <- ifelse(nhl13$playoffs=="Y", nhl13$playoffs1 <- 1, nhl13$playoffs1 <- 0) #if want to make Y/N - 1/0

nhl13$conf <- c("E","W","W","W","W","E","W","E","E","W",
                "E","W","E","E","W","E","E","W","E","W",
                "E","W","W","E","E", "W","E","W","E","E")

nhl13$country <- c(rep("USA", 8), "CAN", rep("USA", 9), "CAN", "USA", 
                   rep("CAN", 3), rep("USA", 2), "CAN", "USA", "CAN", rep("USA",2)) 
head(nhl13)
tail(nhl13)


setwd("C:/Users/curley/Dropbox/Work/R/nhl")

write.table(nhl13, "nhl13.csv", sep=",", row.names=F)

