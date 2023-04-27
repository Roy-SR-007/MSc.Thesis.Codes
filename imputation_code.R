rm(list=ls())

#install.packages("simputation")
#install.packages("VIM")
library(VIM)
library(simputation)
library(HotDeckImputation)


# Material Deprivation ----------------------------------------------------

# data for material deprivation

d = read.csv("~/Desktop/MD_ag1.csv")
d[d == ''] = NA
d_copy = d[,-c(1,2,3,4,5,6,7,8,9)]

# Summary of the missing variables
x = aggr(d_copy)
missing_summ = as.data.frame(x$missings)

# Segregating the variables according to which we will be creating the 
# donor pool for imputation
grouping_var = array(0)
k=1

for(i in 1:length(missing_summ$Variable))
{
  if(missing_summ$Count[i]==0) # no missing values
  {
    grouping_var[k] = i#missing_summ$Variable[i]
    k=k+1
  }
}

# Segregating the variables to be imputed, i.e., having non-zero count for the
# missing values
impute_var = array(0)
l=1

for(i in 1:length(missing_summ$Variable))
{
  if(missing_summ$Count[i]>0) # missing values
  {
    impute_var[l] = i#missing_summ$Variable[i]
    l=l+1
  }
}

# Recoding the Categorical Variables: Permanent - 1 and Semi-Permanent - 2

for(i in 1:length(d_copy$Fzy_wall))
{
  if(d_copy$Fzy_wall[i]=="Permanent")
  {
    d_copy$Fzy_wall[i] = 1
  }
  else if(d_copy$Fzy_wall[i]=="Semi permanent")
  {
    d_copy$Fzy_wall[i] = 2
  }
  else
  {
    d_copy$Fzy_wall[i] = NA
  }
}

for(i in 1:length(d_copy$Fzy_floor))
{
  if(d_copy$Fzy_floor[i]=="Permanent")
  {
    d_copy$Fzy_floor[i] = 1
  }else if(d_copy$Fzy_floor[i]=="Semi permanent")
  {
    d_copy$Fzy_floor[i] = 2
  }else
  {
    d_copy$Fzy_floor[i] = NA
  }
}

for(i in 1:length(d_copy$Fzy_roof))
{
  if(d_copy$Fzy_roof[i]=="Permanent")
  {
    d_copy$Fzy_roof[i] = 1
  }else if(d_copy$Fzy_roof[i]=="Semi permanent")
  {
    d_copy$Fzy_roof[i] = 2
  }else
  {
    d_copy$Fzy_roof[i] = NA
  }
}

#d_copy$Fzy_wall = as.integer(d_copy$Fzy_wall)
#d_copy$Fzy_floor = as.integer(d_copy$Fzy_floor)
#d_copy$Fzy_roof = as.integer(d_copy$Fzy_roof)

d_copy = as.matrix(data.frame(sapply(d_copy, function(x) as.numeric(as.character(x)))))

#d_CPS_imp=impute.CPS_SEQ_HD(DATA=d_copy,covariates=grouping_var)

#d_CPS_imp_final=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_CPS_imp)
#d_CPS_imp_final$Fzy_wall = ifelse(d_CPS_imp_final$Fzy_wall==1,"Permanent","Semi permanent")
#d_CPS_imp_final$Fzy_floor = ifelse(d_CPS_imp_final$Fzy_floor==1,"Permanent","Semi permanent")
#d_CPS_imp_final$Fzy_roof = ifelse(d_CPS_imp_final$Fzy_roof==1,"Permanent","Semi permanent")
#write.csv(d_CPS_imp_final,"~/Desktop/imp_CPS.csv")

d_copy = as.data.frame(d_copy)


# Manhattan Distance - Range - 0.5 ----------------------------------------------

d_NN_imp=impute.NN_HD(DATA=d_copy,distance="man",weights="range",donor_limit = 0.5)

d_NN_imp_final=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp)
d_NN_imp_final$Fzy_wall = ifelse(d_NN_imp_final$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final$Fzy_floor = ifelse(d_NN_imp_final$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final$Fzy_roof = ifelse(d_NN_imp_final$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final,"~/Desktop/imp_NN_1.csv")


# Euclidean Distance - Range - 0.5 ----------------------------------------------

d_NN_imp_1=impute.NN_HD(DATA=d_copy,distance="eukl",weights="range",donor_limit = 0.5)

d_NN_imp_final_1=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_1)
d_NN_imp_final_1$Fzy_wall = ifelse(d_NN_imp_final_1$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_1$Fzy_floor = ifelse(d_NN_imp_final_1$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_1$Fzy_roof = ifelse(d_NN_imp_final_1$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_1,"~/Desktop/imp_NN_2.csv")

# Chebyshev Distance - Range - 0.5 ----------------------------------------------

d_NN_imp_2=impute.NN_HD(DATA=d_copy,distance="tscheb",weights="range",donor_limit = 0.5)

d_NN_imp_final_2=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_2)
d_NN_imp_final_2$Fzy_wall = ifelse(d_NN_imp_final_2$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_2$Fzy_floor = ifelse(d_NN_imp_final_2$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_2$Fzy_roof = ifelse(d_NN_imp_final_2$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_2,"~/Desktop/imp_NN_3.csv")

# Manhattan Distance - var - 0.5 ----------------------------------------------

d_NN_imp_3=impute.NN_HD(DATA=d_copy,distance="man",weights="var",donor_limit = 0.5)

d_NN_imp_final_3=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_3)
d_NN_imp_final_3$Fzy_wall = ifelse(d_NN_imp_final_3$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_3$Fzy_floor = ifelse(d_NN_imp_final_3$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_3$Fzy_roof = ifelse(d_NN_imp_final_3$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_3,"~/Desktop/imp_NN_4.csv")

# Euclidean Distance - var - 0.5 ----------------------------------------------

d_NN_imp_4=impute.NN_HD(DATA=d_copy,distance="eukl",weights="var",donor_limit = 0.5)

d_NN_imp_final_4=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_4)
d_NN_imp_final_4$Fzy_wall = ifelse(d_NN_imp_final_4$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_4$Fzy_floor = ifelse(d_NN_imp_final_4$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_4$Fzy_roof = ifelse(d_NN_imp_final_4$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_4,"~/Desktop/imp_NN_5.csv")

# Chebyshev Distance - var - 0.5 ----------------------------------------------

d_NN_imp_5=impute.NN_HD(DATA=d_copy,distance="tscheb",weights="var",donor_limit = 0.5)

d_NN_imp_final_5=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_5)
d_NN_imp_final_5$Fzy_wall = ifelse(d_NN_imp_final_5$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_5$Fzy_floor = ifelse(d_NN_imp_final_5$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_5$Fzy_roof = ifelse(d_NN_imp_final_5$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_5,"~/Desktop/imp_NN_6.csv")

# Manhattan Distance - Range - 1.0 ----------------------------------------------

d_NN_imp_6=impute.NN_HD(DATA=d_copy,distance="man",weights="range",donor_limit = 1.0)

d_NN_imp_final_6=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_6)
d_NN_imp_final_6$Fzy_wall = ifelse(d_NN_imp_final_6$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_6$Fzy_floor = ifelse(d_NN_imp_final_6$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_6$Fzy_roof = ifelse(d_NN_imp_final_6$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_6,"~/Desktop/imp_NN_7.csv")

# Euclidean Distance - Range - 1.5 ----------------------------------------------

d_NN_imp_7=impute.NN_HD(DATA=d_copy,distance="eukl",weights="range",donor_limit = 1.5)

d_NN_imp_final_7=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_7)
d_NN_imp_final_7$Fzy_wall = ifelse(d_NN_imp_final_7$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_7$Fzy_floor = ifelse(d_NN_imp_final_7$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_7$Fzy_roof = ifelse(d_NN_imp_final_7$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_7,"~/Desktop/imp_NN_8.csv")

# Euclidean Distance - var - 2.0 ----------------------------------------------

d_NN_imp_8=impute.NN_HD(DATA=d_copy,distance="eukl",weights="var",donor_limit = 2.0)

d_NN_imp_final_8=cbind(d[,c(1,2,3,4,5,6,7,8,9)],d_NN_imp_8)
d_NN_imp_final_8$Fzy_wall = ifelse(d_NN_imp_final_8$Fzy_wall==1,"Permanent","Semi permanent")
d_NN_imp_final_8$Fzy_floor = ifelse(d_NN_imp_final_8$Fzy_floor==1,"Permanent","Semi permanent")
d_NN_imp_final_8$Fzy_roof = ifelse(d_NN_imp_final_8$Fzy_roof==1,"Permanent","Semi permanent")

write.csv(d_NN_imp_final_8,"~/Desktop/imp_NN_9.csv")


