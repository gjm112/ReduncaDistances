set.seed(20240521)
#Is 900000 pixels a square inch?  
# run teeth_scriptus_pricei_find-mean_combined.m in matlab
load("./data/teethdata_darti_arundinum_fulvorfula.RData")
#Scriptus is the first n rows, pricei is the last some rows. 
length(data[["LM2"]][["scriptus"]])
length(data[["LM2"]][["pricei"]])


pvals_hotelling = list()
for (i in c("LM1", "LM2", "LM3", "UM1", "UM2", "UM3")){print(i)
  
PC_combined <- read.csv(paste0("./data/matlab/PC_feat_",i,"_combined.csv"), header = FALSE)

library(Hotelling)
PC_combined$g <- c(rep(1,length(data[[i]][["scriptus"]])),
                           rep(2,length(data[[i]][["pricei"]])))

PC_combined %>% group_by(g) %>% summarize(mean(V1),
                                          mean(V2),
                                          mean(V3),
                                          mean(V4),
                                          mean(V5),
                                          mean(V6),
                                          mean(V7),
                                          mean(V8),
                                          mean(V9),
                                          mean(V10)
                                          ) 

results <-  hotelling.test(.~g, data = PC_combined, var.equal = FALSE)
results$stats$statistic
#results <-  hotelling.stat(PC_LM1_combined[PC_LM1_combined$g ==1,-11],PC_LM1_combined[PC_LM1_combined$g ==2,-11])
#results$statistic

#Permutation
nsim <- 100000
null <- c()
for (j in 1:nsim){print(j)
temp <- PC_combined
temp$g <- sample(temp$g, length(temp$g),replace = FALSE)
null[j] <-  hotelling.test(.~g, data = temp, var.equal = FALSE)$stat$statistic
}

hist(null, xlim = c(0,results$stats$statistic))
abline(v = results$stats$statistic, col = "red", lwd = 2)

pvals_hotelling[[i]] <- mean(null >= results$stats$statistic)
}

unlist(pvals_hotelling)









