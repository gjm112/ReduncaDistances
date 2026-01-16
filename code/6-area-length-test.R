load("./data/teethdata_scriptus_pricei.RData")
library(pracma)
#All the teeth SHOULD go clockwise.  But two teeth are going counter clockwise!x

#1 IMG_1375       LM1 scriptus  1191.361  -51754.13
#2     M21B       UM2   pricei  1426.617    -68316.71

# 
# plot(t(data[["UM2"]][["pricei"]][["M21B"]]), col = "white")
# points(t(data[["UM2"]][["pricei"]][["M21B"]])[1:200,])
# 
# plot(t(data[["LM1"]][["scriptus"]][["IMG_1375"]]), col = "white")
# points(t(data[["LM1"]][["scriptus"]][["IMG_1375"]])[1:200,])
# 
# plot(t(data[["LM1"]][["scriptus"]][[1]]), col = "white")
# points(t(data[["LM1"]][["scriptus"]][[1]])[1:30,])

#Perimeter and area
dat <- data.frame()
for (t in c("LM1", "LM2", "LM3", "UM1", "UM2", "UM3")) {print(t)
  for (s in c("scriptus", "pricei")) {print(s)
    for (j in 1:length(data[[t]][[s]])) {
      pieces <- c()
      for (i in 1:499) {
        pieces[i] <-
          sqrt(sum((t(data[[t]][[s]][[j]])[, i] - t(data[[t]][[s]][[j]])[, i + 1]) ^ 2))
      }
      
      area <- polyarea(t(data[[t]][[s]][[j]])[2,],t(data[[t]][[s]][[j]])[1,])
      
      dat <- rbind(dat,
                   data.frame(
                     name = names(data[[t]][[s]])[j],
                     toothtype = t,
                     species = s,
                     perimeter = sum(pieces)
                    , area = area
                   ))
                   
    }
  }
}

library(scales)
hue_pal()(2)
png("./area-boxplot.png", res = 300, units = "in", h = 3, w = 5)
ggplot(aes(x = toothtype, y = area, col= species), data = dat) + geom_boxplot() + theme_bw() + labs(y = expression ("Area"~(mm^2)), x = "Tooth Type") + scale_color_manual(labels = c("T. pricei","T. scriptus"), values = hue_pal()(2))
dev.off()

library(xtable)
dat %>% group_by(toothtype, species) %>% summarize(mn = mean(area), se = sd(area)/sqrt(n())) %>% pivot_wider(names_from= species, values_from = c(mn,se)) %>% xtable()

#Area tests
t.test(dat$area[dat$toothtype == "LM1"] ~ dat$species[dat$toothtype == "LM1"] )
t.test(dat$area[dat$toothtype == "LM2"] ~ dat$species[dat$toothtype == "LM2"] )
t.test(dat$area[dat$toothtype == "LM3"] ~ dat$species[dat$toothtype == "LM3"] )
t.test(dat$area[dat$toothtype == "UM1"] ~ dat$species[dat$toothtype == "UM1"] )
t.test(dat$area[dat$toothtype == "UM2"] ~ dat$species[dat$toothtype == "UM2"] )
t.test(dat$area[dat$toothtype == "UM3"] ~ dat$species[dat$toothtype == "UM3"] )





ggplot(aes(x = toothtype, y = perimeter, col = species), data = dat) + geom_boxplot()

dat %>% filter(toothtype == "LM1" & species == "pricei") %>% pull(perimeter) %>% qqnorm()
dat %>% filter(toothtype == "LM1" & species == "scriptus") %>% pull(perimeter) %>% qqnorm()

dat %>% filter(toothtype == "LM2" & species == "pricei") %>% pull(perimeter) %>% qqnorm()
dat %>% filter(toothtype == "LM2" & species == "scriptus") %>% pull(perimeter) %>% qqnorm()

t.test(dat$perimeter[dat$toothtype == "LM1"] ~ dat$species[dat$toothtype == "LM1"] )
t.test(dat$perimeter[dat$toothtype == "LM2"] ~ dat$species[dat$toothtype == "LM2"] )
t.test(dat$perimeter[dat$toothtype == "LM3"] ~ dat$species[dat$toothtype == "LM3"] )
t.test(dat$perimeter[dat$toothtype == "UM1"] ~ dat$species[dat$toothtype == "UM1"] )
t.test(dat$perimeter[dat$toothtype == "UM2"] ~ dat$species[dat$toothtype == "UM2"] )
t.test(dat$perimeter[dat$toothtype == "UM3"] ~ dat$species[dat$toothtype == "UM3"] )



