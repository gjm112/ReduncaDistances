set.seed(20240521)
library(jpeg)
library(tidyverse)
library(dplyr)
library(Momocs)
library(fdasrvf)

path <- paste0("./data/bushbuckcomplete/")
file_list_BW_bushbuck <- list.files(path, recursive = TRUE, full.names = TRUE)

start <- Sys.time()
import_BW <- function(x){import_jpg(x)[[1]]}
teeth_BW_bushbuck <- lapply(as.list(file_list_BW_bushbuck), import_BW)
names(teeth_BW_bushbuck) <- unlist(lapply(strsplit(file_list_BW_bushbuck,"/"), function(x){x[[length(x)]]}))
names(teeth_BW_bushbuck) <- substring(names(teeth_BW_bushbuck),1,nchar(names(teeth_BW_bushbuck))-4)
end <- Sys.time()
end - start

save(teeth_BW_bushbuck, file = "./data/teeth_BW_bushbuck.RData")

#Export data to matlab

#Now do data prep for matlab
#Makes all the teeth have the same number of points
make_same_num_points <- function(x, N = 500){
  out <- resamplecurve(t(x),N)
  return(out)
}

load("./data/teeth_BW_bushbuck.RData")
#Make all teeth have 500 points
teeth_BW_bushbuck <- lapply(teeth_BW_bushbuck, make_same_num_points)

write.csv(do.call(rbind,teeth_BW_bushbuck),file = paste0("./data/matlab/data_bushbuck.csv"), row.names = FALSE)
write.csv(do.call(rbind,teeth_BW_bushbuck[c("CD5399fixed.","CD5410fixed.")]),file = paste0("./data/matlab/data_bushbuck_LM2.csv"), row.names = FALSE)
write.csv(do.call(rbind,teeth_BW_bushbuck[c("UW 88 519a","SK 4261.", "CD309fixedB")]),file = paste0("./data/matlab/data_bushbuck_LM3.csv"), row.names = FALSE)
write.csv(do.call(rbind,teeth_BW_bushbuck[c("CD19949.")]),file = paste0("./data/matlab/data_bushbuck_UM2.csv"), row.names = FALSE)


# %CD 309 LM3
# %CD 5399 LM2
# %CD 5410 LM2
# %CD 19949 UM2
# %519 LM3
# %SK1 LM3


#####Compute distances in matlab with bushbuck.m script

#####MDS plot for LM3
set.seed(20240521)
load("./data/teethdata_scriptus_pricei.RData")

#for (toothtype in c("LM3")){print(toothtype)
toothtype <- "LM3"
  
  n_scriptus <- length(data[[toothtype]][["scriptus"]])
  n_pricei <- length(data[[toothtype]][["pricei"]])
  
  class <- c(rep("T. scriptus",n_scriptus),rep("T. pricei",n_pricei))
  id <- c(names(data[[toothtype]][["scriptus"]]),names(data[[toothtype]][["pricei"]]),"UW 88 519a","SK 4261", "CD309B")
  
  #Run this script first in matlab: bushbuck.m
  
  #Pariwise distances for LM3
  ddd <- read.csv(paste0("./data/matlab/pairwise_distances_bushbuck_LM3.csv"), header = FALSE)
  ddd <- as.matrix(ddd)
  
  image(ddd)
  
  
  mdsdat <- data.frame(x = cmdscale(ddd)[,1], 
                       y = cmdscale(ddd)[,2],
                       species = c(class,"UW 88 519a","SK 4261.", "CD309B"), 
                       id = id)
  mdsdat <- data.frame(x = cmdscale(ddd)[,1], 
                       y = cmdscale(ddd)[,2],
                       species = c(class,rep("Fossil",3)), 
                       id = id)
library(ggrepel) 
  png(file = "./MDS_LM3_ShapeOnly.png", h = 6, w = 6, units = "in", res = 300)
  ggplot(aes(x = x, y = y, col = species), data = mdsdat) +
    geom_point(size = 1) +
    theme_bw() +
    geom_text_repel(aes(label = id),color = "#F8766D", size = 2, nudge_x = 0.02, data = mdsdat %>% filter(species == "Fossil")) + ggtitle("LM3 - Shape only") + scale_color_manual(values=c(Fossil = "#F8766D",`T. pricei` = "#619CFF",`T. scriptus` = "#00BA38")) + xlab("") + ylab("")
  dev.off()
  #library(scales)
  #show_col(hue_pal()(3))  
  
  # %CD 309 LM3
  # %CD 5399 LM2
  # %CD 5410 LM2
  # %CD 19949 UM2
  # %519 LM3
  # %SK1 LM3
  
  
  
  ###################################
  #Pariwise distances for LM2
  ###################################
  set.seed(20240521)
  load("./data/teethdata_scriptus_pricei.RData")
  
  toothtype <- "LM2"
  
  n_scriptus <- length(data[[toothtype]][["scriptus"]])
  n_pricei <- length(data[[toothtype]][["pricei"]])
  
  class <- c(rep("scriptus",n_scriptus),rep("pricei",n_pricei))
  id <- c(names(data[[toothtype]][["scriptus"]]),names(data[[toothtype]][["pricei"]]),"CD19949","CD5399","CD5410")
  
  
  ddd <- read.csv(paste0("./data/matlab/pairwise_distances_bushbuck_LM2.csv"), header = FALSE)
  ddd <- as.matrix(ddd)
  
  image(ddd)
  
  
  mdsdat <- data.frame(x = cmdscale(ddd)[,1], 
                       y = cmdscale(ddd)[,2],
                       species = c(class,"CD19949","CD5399fixed.","CD5410fixed."),
                       id = id)
  
  mdsdat <- data.frame(x = cmdscale(ddd)[,1], 
                       y = cmdscale(ddd)[,2],
                       species = c(class,rep("fossil",3)), 
                       id = id)
  mdsdat <- mdsdat %>% filter(id != "CD19949")
  
  library(ggrepel)                       
  ggplot(aes(x = x, y = y, col = species), data = mdsdat) + geom_point(size = 0.5) + theme_bw() + geom_text_repel(label = mdsdat$id, size = 2, nudge_x = 0.02) + ggtitle("LM2 - Shape only")
  
  png(file = "./MDS_LM2_ShapeOnly.png", h = 6, w = 6, units = "in", res = 300)
  ggplot(aes(x = x, y = y, col = species), data = mdsdat) +
    geom_point(size = 1) +
    theme_bw() +
    geom_text_repel(aes(label = id),color = "#F8766D", size = 2, nudge_x = 0.02, data = mdsdat %>% filter(species == "fossil")) + ggtitle("LM2 - Shape only") + scale_color_manual(values=c(fossil = "#F8766D",pricei = "#619CFF",scriptus = "#00BA38")) + xlab("") + ylab("")
  dev.off()
  
  
  ###################################
  #Pariwise distances for UM2
  ###################################
  set.seed(20240521)
  load("./data/teethdata_scriptus_pricei.RData")
  
  toothtype <- "UM2"
  
  n_scriptus <- length(data[[toothtype]][["scriptus"]])
  n_pricei <- length(data[[toothtype]][["pricei"]])
  
  class <- c(rep("scriptus",n_scriptus),rep("pricei",n_pricei))
  id <- c(names(data[[toothtype]][["scriptus"]]),names(data[[toothtype]][["pricei"]]),"CD19949","CD5399","CD5410")
  
  
  ddd <- read.csv(paste0("./data/matlab/pairwise_distances_bushbuck_UM2.csv"), header = FALSE)
  ddd <- as.matrix(ddd)
  
  image(ddd)
  
  
  mdsdat <- data.frame(x = cmdscale(ddd)[,1], 
                       y = cmdscale(ddd)[,2],
                       species = c(class,"CD19949","CD5399fixed.","CD5410fixed."),
                       id = id)
  
  mdsdat <- data.frame(x = cmdscale(ddd)[,1], 
                       y = cmdscale(ddd)[,2],
                       species = c(class,rep("fossil",3)), 
                       id = id)
  mdsdat <- mdsdat %>% filter(id != "CD19949")
  
  
  
  library(ggrepel)                       
  ggplot(aes(x = x, y = y, col = species), data = mdsdat) + geom_point(size = 0.5) + theme_bw() + geom_text_repel(label = mdsdat$id, size = 2, nudge_x = 0.02) + ggtitle("LM2 - Shape only")
  
  png(file = "./MDS_LM2_ShapeOnly.png", h = 6, w = 6, units = "in", res = 300)
  ggplot(aes(x = x, y = y, col = species), data = mdsdat) +
    geom_point(size = 1) +
    theme_bw() +
    geom_text_repel(aes(label = id),color = "#F8766D", size = 2, nudge_x = 0.02, data = mdsdat %>% filter(species == "fossil")) + ggtitle("LM2 - Shape only") + scale_color_manual(values=c(fossil = "#F8766D",pricei = "#619CFF",scriptus = "#00BA38")) + xlab("") + ylab("")
  dev.off()
  
  
  
#####Compute distances for partial shapes.  
#### i did this in the teeth-scriptus-pricei-size repo
  


