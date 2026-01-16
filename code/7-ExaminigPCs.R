#source("/Users/gregorymatthews/Dropbox/shape_completion_Matthews_et_al/R/curve_functions.R")
#source("/Users/gregorymatthews/Dropbox/full_shape_classification_SRVF/R/curve_functions.R")
library(fdasrvf)
source("/Users/gregorymatthews/Dropbox/combining_rules_for_shapes/R/curve_functions.R")
source("/Users/gregorymatthews/Dropbox/combining_rules_for_shapes/R/utility.R")

mean <- read.csv("/Users/gregorymatthews/Dropbox/teeth-scriptus-pricei/data/matlab/data_LM1_pricei.csv", header = TRUE)
VV <- as.matrix(read.csv("/Users/gregorymatthews/Dropbox/teeth-scriptus-pricei/data/matlab/VV_LM1_pricei.csv", header = TRUE))

mean <- resamplecurve(mean,18)
mean <- curve_to_q(mean)

# mean <- read.csv("/Users/gregorymatthews/Dropbox/full_shape_classification_SRVF_preserving_size/data/means/mean_LM1_Alcelaphini.csv", header = FALSE)
# VV <- as.matrix(read.csv("/Users/gregorymatthews/Dropbox/full_shape_classification_SRVF_preserving_size/data/fulldata/LM1_train_individual.csv", header = FALSE))
VV <- VV[,1:18]
pc <- princomp(VV)
pc$sdev[1]*pc$loadings[,1]

plot(t(q_to_curve(project_curve(as.matrix(mean)))))
plot(t(q_to_curve((as.matrix(mean)))))


#Modify the mean by k sd
meanPC1 <- list()
k <- 1
for (k in c(-1.5,-1,-0.5,0,0.5,1,1.5)){
  temp <- as.matrix(mean + matrix(k*pc$sdev[1]*pc$loadings[,1], nrow = 2, ncol = 18))
  meanPC1[[as.character(k)]] <- t(q_to_curve(as.matrix(mean + matrix(k*pc$sdev[1]*pc$loadings[,1], nrow = 2, ncol = 18))))
}

meanPC2 <- list()
k <- 1
for (k in c(-1.5,-1,-0.5,0,0.5,1,1.5)){
  meanPC2[[as.character(k)]] <- t(q_to_curve(as.matrix(mean + matrix(k*pc$sdev[2]*pc$loadings[,2], nrow = 2, ncol = 18))))
}

meanPC3 <- list()
k <- 1
for (k in c(-1.5,-1,-0.5,0,0.5,1,1.5)){
  meanPC3[[as.character(k)]] <- t(q_to_curve(as.matrix(mean + matrix(k*pc$sdev[3]*pc$loadings[,3], nrow = 2, ncol = 18))))
}

dat1 <- data.frame(do.call(rbind,meanPC1))
names(dat1) <- c("x","y")
dat1$k <- rep(c(-1.5,-1,-0.5,0,0.5,1,1.5), each = 18)
dat1$PC <-"PC1"

dat2 <- data.frame(do.call(rbind,meanPC2))
names(dat2) <- c("x","y")
dat2$k <- rep(c(-1.5,-1,-0.5,0,0.5,1,1.5), each = 18)
dat2$PC <-"PC2"

dat3 <- data.frame(do.call(rbind,meanPC3))
names(dat3) <- c("x","y")
dat3$k <- rep(c(-1.5,-1,-0.5,0,0.5,1,1.5), each = 18)
dat3$PC <-"PC3"

dat <- rbind(dat1,dat2,dat3)


ggplot(aes(x = x, y = y), data = dat) + geom_path() + facet_grid(factor(PC)~factor(k)) + theme(aspect.ratio =1) + scale_x_continuous(breaks=c(-200,0,200)) + scale_y_continuous(breaks=c(-200,0,200)) 





cd /Users/gregorymatthews/Dropbox/full_shape_classification_SRVF_preserving_size/data/fulldata 
csvwrite(strcat(toothtype,"_train_individual.csv"), train_individual)
