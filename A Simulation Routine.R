rm(list=ls())
library(HotDeckImputation)
#install.packages("missMethods")
library(missMethods)
library(VIM)
#install.packages("mice")
library(mice)
#install.packages("tidyverse")
library(tidyverse)

set.seed(29)

data = read.csv("~/Desktop/HH_FullData.csv")

# x: total household income per month
# y: total household expenditure per month

x = data$add_hhincomepm
y = data$add_hhexppm

Y.mean = mean(y) # population mean

N = length(y) # population size

plot(x,y,cex=0.5,pch=16,ylab="Total Monthly Expenditure",xlab="Total Monthly Income")

d = data.frame(x,y)

# Generating missingness in y ---------------------------------------------

gamma_1 = 0.0009#c(0,0,0,0,0,1,1,1,1,1,2,2,2,2,2)
gamma_2 = -0.00006#c(-0.02,-.01,0,0.01,.02,-0.03,-0.02,-.01,0,.01,-.04,-0.03,-0.02,-0.01,0)

# probability of missingness (response indicator, a: P(a=1|x) = logit(gamma_1+gamma_2.x))
# Considering MAR

p = exp(gamma_1 + (gamma_2*x))/(1+exp(gamma_1 + (gamma_2*x)))
p_plus = max(p)
p_minus = min(p)
p_avg = mean(p) # average response rate

d$y[sample(N,N*p_avg,replace=FALSE)] = NA

aggr(d,combined=F,col=c("#93031B","#6FB5FF"))
# NNDI estimators for SRS (WOR) and Single Imputation Class ---------------


# SRS sample of size 200 --------------------------------------------------

n1 = 200

d_n1 = d[sample(nrow(d),n1,replace=FALSE),]

# impute the missing values in y using mice

k = 5 # 5 imputed data sets
d_imp_mice = mice(d_n1,k,mehtod="norm")

Y_imp = map(seq(k), ~mice::complete(d_imp_mice, .x))
xx = array(0)

for(i in 1:k)
{
  xx[i] = mean(Y_imp[[i]]$y)
}

Y.mean.mice = mean(xx)

(Y.mean.mice - Y.mean)/Y.mean

# imputing the missing values in y using manhattan distance: NNHDI

d_imp_NNHDI = impute.NN_HD(d_n1,distance="man")

Y.mean.NNHDI = mean(d_imp_NNHDI$y)

Y.mean.NNHDI-Y.mean # bias for NNHDI

# imputing the missing values in y using mean imputation

d_imp_mean = impute_mean(d_n1,"columnwise")

Y.mean.mean = mean(d_imp_mean$y)

Y.mean.mean - Y.mean # bias for mean imputation

# imputing the missing values using simple random hot deck

d_imp_rhd = impute_sRHD(d_n1)

Y.mean.rhd = mean(d_imp_rhd$y)

Y.mean.rhd - Y.mean # bias for RHD imputation
