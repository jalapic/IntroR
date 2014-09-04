
#### Merging dataframes #####

f1 <- rep(c("A","B","C"), each = 3)
df1 <- data.frame(f1,v1=runif(9))
df2 <- data.frame(f1=c("A","B","C"), n1=c("sp1","sp2","sp3") )

library(dplyr)
df1 %>%
  left_join(df2)

merge(df1,df2)
