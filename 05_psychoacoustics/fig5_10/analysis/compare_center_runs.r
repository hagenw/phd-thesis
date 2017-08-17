#!/usr/bin/R -f
#
# AUTHOR: Hagen Wierstorf


# Compare the two independent runs for central listening position
# speech
data = read.csv('../data/speech_center.csv')
data = matrix(data=c(data$m1,data$m2,rep(seq(1,2),each=length(data$m1))),ncol=2,nrow=2*length(data$m1))
colnames(data) <- c('res','ind')
data = as.data.frame(data)
data$ind <- as.factor(data$ind)
wilcox.test(res ~ ind, data=data)
# noise
data = read.csv('../data/noise_center.csv')
data = matrix(data=c(data$m1,data$m2,rep(seq(1,2),each=length(data$m1))),ncol=2,nrow=2*length(data$m1))
colnames(data) <- c('res','ind')
data = as.data.frame(data)
data$ind <- as.factor(data$ind)
wilcox.test(res ~ ind, data=data)
