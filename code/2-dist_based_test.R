set.seed(20240521)
load("./data/teethdata_darti_arundinum_fulvorfula.RData")
pvals <- list()

#These teeth go counterclockwise.  
#They need to be corrected to go clockwise
#LM1  num 15: DSCN0680 

#LM2 num 48 and 70
#DSCN3442
#DSCN4351

#LM3 num 42
#DSCN0986

#UM2 num 71 
#DSCN6138

for (toothtype in c("LM1","LM2","LM3","UM1","UM2","UM3")){print(toothtype)
pvals[[toothtype]] <- c()
  # darti_arundinum_fulvorfula
n_darti <- length(data[[toothtype]][["darti"]])
n_arundinum <- length(data[[toothtype]][["arundinum"]])
n_fulvorufula <- length(data[[toothtype]][["fulvorufula"]])

class <- c(rep("darti",n_darti),
           rep("arundinum",n_arundinum),
           rep("fulvorufula",n_fulvorufula))

#Run this script first in matlab: pairwise_dist_scriptus_pricei.m
#Pariwise distances
#First rows are scriptus and last rows are pricei
ddd <- read.csv(paste0("./data/matlab/pairwise_distances_",toothtype,".csv"), header = FALSE)
ddd <- as.matrix(ddd)

#image(ddd)




#Distrance based permutation testing.  
#Based on the test defined in Soto et al 2021
#1. Use distances based on the shapes projected into the tangent space.  
#to 2. Use distances in the size-shape space.  (I just need a function that computes distance between shapes that preserves size.)

#Mostly interested in darti vs. the two others groups. 
#Not really interested in the arundinum vs fulvorufula comparison


##########################################
#darti vs arundinum
##########################################
Dbar11 <- sum(ddd[class == "darti",class == "darti"])/(n_darti^2)
Dbar22 <- sum(ddd[class == "arundinum",class == "arundinum"])/(n_arundinum^2)
Dbar12 <- sum(ddd[class == "darti",class == "arundinum"])/(n_darti*n_arundinum)

S <- ((n_darti*n_arundinum)/((n_darti+n_arundinum)))*(2*Dbar12 - (Dbar11 + Dbar22))

#Now permute
Sperm <- c()
nsim <- 10000
for (i in 1:nsim){
class_sub <- class[class %in% c("darti","arundinum")]
class_perm <- sample(class_sub,length(class_sub),replace = FALSE)
Dbar11 <- sum(ddd[class_perm == "darti",class_perm == "darti"])/(n_darti^2)
Dbar22 <- sum(ddd[class_perm == "arundinum",class_perm == "arundinum"])/(n_arundinum^2)
Dbar12 <- sum(ddd[class_perm == "darti",class_perm == "arundinum"])/(n_darti*n_arundinum)

Sperm[i] <- ((n_darti*n_arundinum)/((n_darti+n_arundinum)))*(2*Dbar12 - (Dbar11 + Dbar22))
}

pvals[[toothtype]]["darti_arundinum"] <- mean(Sperm >= S)

# hist(Sperm, main = toothtype, xlim = c(0, S + .05))
# abline(v = S, col = "red")


##########################################
#darti vs fulvorufula
##########################################
Dbar11 <- sum(ddd[class == "darti",class == "darti"])/(n_darti^2)
Dbar22 <- sum(ddd[class == "fulvorufula",class == "fulvorufula"])/(n_fulvorufula^2)
Dbar12 <- sum(ddd[class == "darti",class == "fulvorufula"])/(n_darti*n_fulvorufula)

S <- ((n_darti*n_fulvorufula)/((n_darti+n_fulvorufula)))*(2*Dbar12 - (Dbar11 + Dbar22))

#Now permute
Sperm <- c()
nsim <- 10000
for (i in 1:nsim){
  class_sub <- class[class %in% c("darti","fulvorufula")]
  class_perm <- sample(class_sub,length(class_sub),replace = FALSE)
  Dbar11 <- sum(ddd[class_perm == "darti",class_perm == "darti"])/(n_darti^2)
  Dbar22 <- sum(ddd[class_perm == "fulvorufula",class_perm == "fulvorufula"])/(n_fulvorufula^2)
  Dbar12 <- sum(ddd[class_perm == "darti",class_perm == "fulvorufula"])/(n_darti*n_fulvorufula)
  
  Sperm[i] <- ((n_darti*n_fulvorufula)/((n_darti+n_fulvorufula)))*(2*Dbar12 - (Dbar11 + Dbar22))
}

pvals[[toothtype]]["darti_fulvorufula"] <- mean(Sperm >= S)

}

p.adjust(unlist(pvals),"fdr") 


#How to correct for multipel tests? 
#FDR correction?  



out <- data.frame(toothtpye = rep(c("LM1","LM2","LM3","UM1","UM2","UM3"),each = 2),
           comparison = rep(c("darti_arundinum","darti_fulvorufula"),6),
            raw_pvalue = unlist(pvals),
           adjusted_pvalue = p.adjust(unlist(pvals),"fdr"))
write.csv(out, file = "./results/pvalues_shape_only.csv", row.names = FALSE)

# hist(Sperm)
# abline(v = S, col = "red")


