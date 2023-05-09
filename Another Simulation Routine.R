rm(list=ls())
library(HotDeckImputation)
set.seed(2)

N = 5000

# generating the data for covariates (auxiliary variables), that are
# completely observed
x1 = runif(N)
x2 = runif(N)
x3 = runif(N)
x4 = rnorm(N)
x5 = rnorm(N)
x6 = rnorm(N)
e = rnorm(N)

x = c(x1,x2,x3,x4,x5,x6) # the entire set of covariates

# generating data for response according to specific models
y1 = -1 + x1 + x2 + e
y2 = -1.5 + x1 + x2 + x3 + x4 + e
y3 = -1.5 + x1 + x2 + x3 + x4 + x5 + x6 + e
y4 = -1 + x1 + x2 + (x1^2) + (x2^2) - (2/3) + e
y5 = -1.5 + x1 + x2 + x3 + x4 + (x1^2) + (x2^2) - (2/3) + e
y6 = -1.5 + x1 + x2 + x3 + x4 + x5 + x6 + (x1^2) + (x2^2) - (2/3) + e

y = c(y1,y2,y3,y4,y5,y6) # the entire set of responses

mu = mean(y) # finite population mean

# The entire data without the missing values (complete data set):

d = data.frame(y,x)

# generating missing values for the response vector y from a logistic 
# response probability model, logit(p) = x'1

p = exp(x1+x2+x3+x4+x5+x6)/(1+exp(x1+x2+x3+x4+x5+x6))
p.avg = mean(p) # average response rate


# Combining the entire data -----------------------------------------------


y[sample(N,N*p.avg,replace=TRUE)] = NA # assigning missing values to y

# The entire data with the missing values (incomplete data):

d.miss = data.frame(y,x)

# Imputing the missing entries using NNHDI (with manhattan distance)

d.imp = impute.NN_HD(d.miss,distance="eukl")


# Taking a sample of size n: SRSWR

routine = function(d,n,mu)
{
  d.sample = d[sample(nrow(d),n,replace=TRUE),]
  
  bias = (mean(d.sample$y,na.rm=T) - mu)
  se = sd(d.sample$y,na.rm=T)/sqrt(n)
  
  res = c(bias,se)
  return(res)
}

M = 1000
bias.miss=array(0)
bias.imp=array(0)

for(i in 1:M)
{
  bias.miss[i] = routine(d.miss,800,mu)[1]
  bias.imp[i] = routine(d.imp,800,mu)[1]
}

mean(bias.miss)
mean(bias.imp)

plot(bias.miss,type="p",pch=19,xlab="number of simulations",
     ylab="bias",ylim=c(-.35,.35),col="#6FB5FF")
points(bias.imp,col="#93031B",cex=0.5,pch=19)
abline(h=0,col="red",lwd=2)
legend("topright",legend=c("pre-imputation","post-imputation"),
       col=c("#6FB5FF","#93031B"),pch=19)


se.miss=array(0)
se.imp=array(0)

for(i in 1:M)
{
  se.miss[i] = routine(d.miss,800,mu)[2]
  se.imp[i] = routine(d.imp,800,mu)[2]
}

mean(se.miss)
mean(se.imp)

plot(se.miss,type="p",pch=19,xlab="number of simulations",
     ylab="se",col="#6FB5FF",ylim=c(min(se.miss),0.070))
points(se.imp,col="#93031B",cex=0.5,pch=19)
legend("topright",legend=c("pre-imputation","post-imputation"),
       col=c("#6FB5FF","#93031B"),pch=19)


# Model wise consideration ------------------------------------------------
rm(list=ls())
library(HotDeckImputation)

set.seed(11)

N = 5000

x1 = runif(N)
x2 = runif(N)
x3 = runif(N)
x4 = rnorm(N)
x5 = rnorm(N)
x6 = rnorm(N)

p.avg = mean(exp(x1+x2+x3+x4+x5+x6)/(1+exp(x1+x2+x3+x4+x5+x6)))

model_routine = function(N,n,m,p.avg)
{
  if(m==1)
  {
    x1 = runif(N)
    x2 = runif(N)
    e = rnorm(N)
    y1 = -1 + x1 + x2 + e
    mu = mean(y1)
    
    y1[sample(N,N*p.avg,replace=TRUE)] = NA
    d1.miss = data.frame(y1,x1,x2)
    #d1.imp = impute.NN_HD(d1.miss,distance="man")
    
    d1.miss.sample = d1.miss[sample(nrow(d1.miss),n,replace=TRUE),]
    d1.imp.sample = impute.NN_HD(d1.miss.sample,distance="man")
    
    bias.miss = (mean(d1.miss.sample$y1,na.rm=T) - mu)
    bias.imp = (mean(d1.imp.sample$y1) - mu)
    
    se.miss = sd(d1.miss.sample$y1,na.rm=T)/sqrt(n)
    se.imp = sd(d1.imp.sample$y1)/sqrt(n)
    
    res = c(bias.miss,se.miss,bias.imp,se.imp)
    return(res)
  }else if(m==2)
  {
    set.seed(11)
    x1 = runif(N)
    x2 = runif(N)
    x3 = runif(N)
    x4 = rnorm(N)
    e = rnorm(N)
    y1 =-1.5 + x1 + x2 + x3 + x4 + e
    mu = mean(y1)
    
    y1[sample(N,N*p.avg,replace=TRUE)] = NA
    d1.miss = data.frame(y1,x1,x2,x3,x4)
    #d1.imp = impute.NN_HD(d1.miss,distance="man")
    
    d1.miss.sample = d1.miss[sample(nrow(d1.miss),n,replace=TRUE),]
    d1.imp.sample = impute.NN_HD(d1.miss.sample,distance="man")
    
    bias.miss = (mean(d1.miss.sample$y1,na.rm=T) - mu)
    bias.imp = (mean(d1.imp.sample$y1) - mu)
    
    se.miss = sd(d1.miss.sample$y1,na.rm=T)/sqrt(n)
    se.imp = sd(d1.imp.sample$y1)/sqrt(n)
    
    res = c(bias.miss,se.miss,bias.imp,se.imp)
    return(res)
  }else if(m==3)
  {
    set.seed(11)
    x1 = runif(N)
    x2 = runif(N)
    x3 = runif(N)
    x4 = rnorm(N)
    x5 = rnorm(N)
    x6 = rnorm(N)
    e = rnorm(N)
    y1 =-1.5 + x1 + x2 + x3 + x4 + x5 + x6 + e
    mu = mean(y1)
    
    y1[sample(N,N*p.avg,replace=TRUE)] = NA
    d1.miss = data.frame(y1,x1,x2,x3,x4,x5,x6)
    #d1.imp = impute.NN_HD(d1.miss,distance="man")
    
    d1.miss.sample = d1.miss[sample(nrow(d1.miss),n,replace=TRUE),]
    d1.imp.sample = impute.NN_HD(d1.miss.sample,distance="man")
    
    bias.miss = (mean(d1.miss.sample$y1,na.rm=T) - mu)
    bias.imp = (mean(d1.imp.sample$y1) - mu)
    
    se.miss = sd(d1.miss.sample$y1,na.rm=T)/sqrt(n)
    se.imp = sd(d1.imp.sample$y1)/sqrt(n)
    
    res = c(bias.miss,se.miss,bias.imp,se.imp)
    return(res)
  }else if(m==4)
  {
    set.seed(11)
    x1 = runif(N)
    x2 = runif(N)
    e = rnorm(N)
    y1 =-1 + x1 + x2 + (x1^2) + (x2^2) - (2/3) + e
    mu = mean(y1)
    
    y1[sample(N,N*p.avg,replace=TRUE)] = NA
    d1.miss = data.frame(y1,x1,x2)
    #d1.imp = impute.NN_HD(d1.miss,distance="man")
    
    d1.miss.sample = d1.miss[sample(nrow(d1.miss),n,replace=TRUE),]
    d1.imp.sample = impute.NN_HD(d1.miss.sample,distance="man")
    
    bias.miss = (mean(d1.miss.sample$y1,na.rm=T) - mu)
    bias.imp = (mean(d1.imp.sample$y1) - mu)
    
    se.miss = sd(d1.miss.sample$y1,na.rm=T)/sqrt(n)
    se.imp = sd(d1.imp.sample$y1)/sqrt(n)
    
    res = c(bias.miss,se.miss,bias.imp,se.imp)
    return(res)
  }else if(m==5)
  {
    set.seed(11)
    x1 = runif(N)
    x2 = runif(N)
    x3 = runif(N)
    x4 = rnorm(N)
    e = rnorm(N)
    y1 =-1.5 + x1 + x2 + x3 + x4 + (x1^2) + (x2^2) - (2/3) + e
    mu = mean(y1)
    
    y1[sample(N,N*p.avg,replace=TRUE)] = NA
    d1.miss = data.frame(y1,x1,x2,x3,x4)
    #d1.imp = impute.NN_HD(d1.miss,distance="man")
    
    d1.miss.sample = d1.miss[sample(nrow(d1.miss),n,replace=TRUE),]
    d1.imp.sample = impute.NN_HD(d1.miss.sample,distance="man")
    
    bias.miss = (mean(d1.miss.sample$y1,na.rm=T) - mu)
    bias.imp = (mean(d1.imp.sample$y1) - mu)
    
    se.miss = sd(d1.miss.sample$y1,na.rm=T)/sqrt(n)
    se.imp = sd(d1.imp.sample$y1)/sqrt(n)
    
    res = c(bias.miss,se.miss,bias.imp,se.imp)
    return(res)
  }else if(m==6)
  {
    set.seed(11)
    x1 = runif(N)
    x2 = runif(N)
    x3 = runif(N)
    x4 = rnorm(N)
    e = rnorm(N)
    y1 =-1.5 + x1 + x2 + x3 + x4 + + x5 + x6 + (x1^2) + (x2^2) - (2/3) + e
    mu = mean(y1)
    
    y1[sample(N,N*p.avg,replace=TRUE)] = NA
    d1.miss = data.frame(y1,x1,x2,x3,x4,x5,x6)
    #d1.imp = impute.NN_HD(d1.miss,distance="man")
    
    d1.miss.sample = d1.miss[sample(nrow(d1.miss),n,replace=TRUE),]
    d1.imp.sample = impute.NN_HD(d1.miss.sample,distance="man")
    
    bias.miss = (mean(d1.miss.sample$y1,na.rm=T) - mu)
    bias.imp = (mean(d1.imp.sample$y1) - mu)
    
    se.miss = sd(d1.miss.sample$y1,na.rm=T)/sqrt(n)
    se.imp = sd(d1.imp.sample$y1)/sqrt(n)
    
    res = c(bias.miss,se.miss,bias.imp,se.imp)
    return(res)
  }
}

model_routine(N,800,1,p.avg)



# Change in Distribution --------------------------------------------------

rm(list=ls())
set.seed(29)
library(missMethods)
library(HotDeckImputation)

N = 100

x1 = runif(N)
x2 = runif(N)
x3 = runif(N)
x4 = rnorm(N)
x5 = rnorm(N)
x6 = rnorm(N)
e = rnorm(N)

y1 = -1 + x1 + x2 + e
y2 = -1.5 + x1 + x2 + x3 + x4 + e
y3 = -1.5 + x1 + x2 + x3 + x4 + x5 + x6 + e
y4 = -1 + x1 + x2 + (x1^2) + (x2^2) - (2/3) + e
y5 = -1.5 + x1 + x2 + x3 + x4 + (x1^2) + (x2^2) - (2/3) + e
y6 = -1.5 + x1 + x2 + x3 + x4 + x5 + x6 + (x1^2) + (x2^2) - (2/3) + e

y = c(y1,y2,y3,y4,y5,y6)
x = c(x1,x2,x3,x4,x5,x6)


p = exp(x1+x2+x3+x4+x5+x6)/(1+exp(x1+x2+x3+x4+x5+x6))
p.avg = mean(p) # average response rate

y[sample(N,N*0.30,replace=TRUE)] = NA # assigning missing values to y

d.miss = data.frame(y,x)

d.imp = impute.NN_HD(d.miss,distance="man",optimal_donor="odd")
d.imp1 = impute_sRHD(d.miss)
d.imp2 = impute_mean(d.miss)

plot(density(d.miss$y,na.rm=T),ylim=c(0,max(density(d.imp2$y)$y)),
     main="",xlab="Density estimate coordinates",lwd=4)
lines(density(d.imp$y),col="red",lty=2,lwd=2)
lines(density(d.imp1$y),col="blue",lty=3,lwd=3)
lines(density(d.imp2$y),col="darkgreen",lty=4,lwd=3)
legend("topright",legend=c("Missing y","NNHDI","RHD","Mean"),col=c("black","red",
                                                                          "blue","darkgreen"),
                                                                        lty=c(1,2,3,4))




