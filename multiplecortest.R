#### Function for running multiple correlation tests

# from:  https://sites.google.com/site/manabusakamoto/home/r-functions-and-scripts/lm-npredictors-r

  pair.cor <- function(x, test=c("pearson", "kendall", "spearman"), p.adj.method=c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none")){
    mat <- as.matrix(x)
    n <- length(mat[1,])
    N <- n*(n-1)/2
    cor.stats <- matrix(nrow=length(mat[1,]),ncol=length(mat[1,]))
    p.value <- matrix(nrow=length(mat[1,]),ncol=length(mat[1,]))
    p.adj <- matrix(nrow=length(mat[1,]),ncol=length(mat[1,]))
    for( i in 1:length(mat[1,]) ){
      v1 <- mat[,i]
      cor <- vector()
      p <- vector()
      padj <- vector()
      for( j in 1:length(mat[1,]) ){
        v2 <- mat[,j]
        COR <- cor.test(v1,v2, method=test)
        cor <- append(cor,COR$estimate)
        p <- append(p,COR$p.value)
        padj <- append(padj,p.adjust(p[j], method = p.adj.method, n=N ))
      }
      cor.stats[i,] <- cor
      p.value[i,] <- p
      p.adj[i,] <- padj
      colnames(cor.stats)<-colnames(mat)
      rownames(cor.stats)<-colnames(mat)
      colnames(p.value)<-colnames(mat)
      rownames(p.value)<-colnames(mat)
      colnames(p.adj)<-colnames(mat)
      rownames(p.adj)<-colnames(mat)
    }
    result <- list(stats=cor.stats, p.values=p.value, p.adjust=p.adj)
    return(result)
  }





################################################################################################################

# lm.Nresponse

# A function to fit N linear models for N number of response variables (Yi) 
# against one predictor variable (X) and return the R2- and p-values.

# Arguments:

# x: either a matrix containing the X variable in the first column and Y variables 
# in the subsequent columns, or a vector of X values (if y is indicated as a separate argument)
# y: optional argument to supply a matrix of response variables Yi separately of X

# Description: When you've got one predictor variable (X) and multiple response variables (Y1, Y2, ...Yi), 
# and you want to fit a linear model on each (X, Yi) pair, 
# but can't be bothered to manually code multiple lm(Yi~X) models, then this is the function for you.


  
  lm.Nresponse <- function(x, y=NULL){
    if(is.null(y)){X <- x[,1];Y<-x[,-1]}else{
      X<-as.numeric(x)
      Y<-as.matrix(y)}
    modstats <- matrix(ncol=2,nrow=ncol(Y))
    for(i in 1:ncol(Y)){
      mods <- summary(lm(Y[,i]~X))
      r2 <- mods$r.squared
      p <- pf(mods$fstatistic[1], mods$fstatistic[2], mods$fstatistic[3], lower.tail = FALSE)
      modstats[i,]<-c(r2,p)
    }
    colnames(modstats)<-c("r.squared","p.value")
    rownames(modstats)<-colnames(Y)
    return(modstats)
  }


##### Function by Manabu Sakamoto, 2012: manabu.sakamoto@gmail.com