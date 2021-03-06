#TRAINING USING GBM::Gradient Boosted Model"
rm(list=ls()) #clears workspace
setwd('~/MLfinalproject/data/')
load('weighted_smallsub.RData')
ls()

#install.packages("gbm")
library(gbm)

#Video tutorial: http://vimeo.com/71992876
#GENERATING MODEL
fitgbm<-list()
system.time(fitgbm[[1]]<-gbm.fit(x=datatrain[train0,], y=ytrain[train0]
                                 , distribution="bernoulli"
                                 , n.trees = 100
                                 , shrinkage = 1
                                 , interaction.depth = 3
                                 , n.minobsinnode = 10
                                 , keep.data = FALSE
                                 , verbose = FALSE))
#569.411   4.867 573.688
#interaction=2: 1004.997    5.823 1010.887
#interaction=3: 1454.484    5.550 1460.064
save.image("weighted_gbm2.RData")
system.time(fitgbm[[2]]<-gbm.fit(x=datatrain[train1,], y=ytrain[train1]
                                 , n.trees = 100
                                 , shrinkage = 1
                                 , interaction.depth = 2
                                 , n.minobsinnode = 10
                                 , keep.data = FALSE
                                 , distribution="bernoulli", verbose = FALSE))
#1145.877   10.190 1154.894
#2006.688    9.800 2016.545
save.image("weighted_gbm2.RData")
system.time(fitgbm[[3]]<-gbm.fit(x=datatrain, y=ytrain
                                 , n.trees = 100
                                 , shrinkage = 1
                                 , interaction.depth = 2
                                 , n.minobsinnode = 10
                                 , keep.data = FALSE
                                 , distribution="bernoulli", verbose = FALSE))
#
save.image("weighted_gbm2.RData")
#2349.197   22.782 2369.626
#4103.233   23.015 4126.407

##### PERFORM PREDICT
for(x in c(1:8)) {
  cat(paste0('system.time(predgbm[['
             ,x
             ,']]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[['
             ,x
             ,']],], n.trees=newtrees, type="response"))'
             ,'\n'
  ))
  flush.console()
}
for(x in seq(4,8,1)) {
  cat(paste0('system.time(predgbm[['
             ,x+5
             ,']]<-predict.gbm(object=fitgbm[[2]], newdata=datatest[small[['
             ,x
             ,']],], n.trees=newtrees, type="response"))'
             ,'\n'
  ))
  flush.console()
}
for(x in seq(4,8,1)) {
  cat(paste0('system.time(predgbm[['
             ,x+10
             ,']]<-predict.gbm(object=fitgbm[[1]], newdata=datatest[small[['
             ,x
             ,']],], n.trees=newtrees, type="response"))'
             ,'\n'
  ))
  flush.console()
}

system.time(newtrees<-gbm.perf(fitgbm[[1]], plot.it=FALSE, oobag.curve=FALSE
                               ,overlay=FALSE, method="cv"))
newtrees<-100
predgbm<-list()
system.time(predgbm[[1]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[1]],], n.trees=newtrees, type="response"))
#0.078   0.000   0.080
system.time(predgbm[[2]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[2]],], n.trees=newtrees, type="response"))
#0.133   0.023   0.156
system.time(predgbm[[3]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[3]],], n.trees=newtrees, type="response"))
#0.464   0.051   0.516
system.time(predgbm[[4]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[4]],], n.trees=newtrees, type="response"))
#0.254   0.000   0.253
system.time(predgbm[[5]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[5]],], n.trees=newtrees, type="response"))
#0.254   0.000   0.253
system.time(predgbm[[6]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[6]],], n.trees=newtrees, type="response"))
#0.228   0.000   0.227
system.time(predgbm[[7]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[7]],], n.trees=newtrees, type="response"))
#0.227   0.000   0.226 
system.time(predgbm[[8]]<-predict.gbm(object=fitgbm[[3]], newdata=datatest[small[[8]],], n.trees=newtrees, type="response"))
#0.226   0.000   0.227

system.time(predgbm[[9]]<-predict.gbm(object=fitgbm[[2]], newdata=datatest[small[[4]],], n.trees=newtrees, type="response"))
#0.228   0.000   0.227
system.time(predgbm[[10]]<-predict.gbm(object=fitgbm[[2]], newdata=datatest[small[[5]],], n.trees=newtrees, type="response"))
#0.228   0.000   0.228
system.time(predgbm[[11]]<-predict.gbm(object=fitgbm[[2]], newdata=datatest[small[[6]],], n.trees=newtrees, type="response"))
#0.228   0.000   0.228
system.time(predgbm[[12]]<-predict.gbm(object=fitgbm[[2]], newdata=datatest[small[[7]],], n.trees=newtrees, type="response"))
#0.227   0.000   0.228
system.time(predgbm[[13]]<-predict.gbm(object=fitgbm[[2]], newdata=datatest[small[[8]],], n.trees=newtrees, type="response"))
#0.23    0.00    0.23

system.time(predgbm[[14]]<-predict.gbm(object=fitgbm[[1]], newdata=datatest[small[[4]],], n.trees=newtrees, type="response"))
#0.227   0.000   0.227
system.time(predgbm[[15]]<-predict.gbm(object=fitgbm[[1]], newdata=datatest[small[[5]],], n.trees=newtrees, type="response"))
#0.229   0.000   0.227
system.time(predgbm[[16]]<-predict.gbm(object=fitgbm[[1]], newdata=datatest[small[[6]],], n.trees=newtrees, type="response"))
#0.228   0.000   0.227
system.time(predgbm[[17]]<-predict.gbm(object=fitgbm[[1]], newdata=datatest[small[[7]],], n.trees=newtrees, type="response"))
#0.229   0.000   0.228 
system.time(predgbm[[18]]<-predict.gbm(object=fitgbm[[1]], newdata=datatest[small[[8]],], n.trees=newtrees, type="response"))
#0.229   0.000   0.228

rm(datatrain, x, fitgbm)
save.image("weighted_gbm.RData")

pred<-predgbm[[1]]
pred[which(pred>=0.5)]<-1
pred[which(pred<0.5)]<-0
table(pred, ytest[small[[1]]], dnn=list('predicted','actual'))
############################################
predgbm2<-predgbm
for(g in 1:length(predgbm)) {
  p<-predgbm[[g]]
  p[which(p>=0.5)]<-1
  p[which(p<0.5)]<-0
  predgbm[[g]]<-p
}
gbm_acc<-c(0,0,0)
gbm_fp<-c(0,0,0)
gbm_fn<-c(0,0,0)
gbm_prec<-c(0,0,0)
gbm_rec<-c(0,0,0)
for(x in seq(4,8,1)) {
  gbm_acc[3]<-gbm_acc[3]+
    1-(sum(abs(ytest[small[[x]]] - as.numeric(as.character(predgbm[[x]]))))/length(ytest[small[[x]]]))
  gbm_fp[3]<-gbm_fp[3]+
    table(predgbm[[x]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,1]/length(ytest[small[[x]]])
  gbm_fn[3]<-gbm_fn[3]+
    table(predgbm[[x]], ytest[small[[x]]], dnn=list('predicted','actual'))[1,2]/length(ytest[small[[x]]])
  tp<-table(predgbm[[x]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,2]
  fp<-table(predgbm[[x]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,1]
  gbm_prec[3]<-gbm_prec[3]+tp/(fp+tp)
  tt<-table(predgbm[[x]], ytest[small[[x]]], dnn=list('predicted','actual'))[1,2]+
    table(predgbm[[x]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,2]
  gbm_rec[3]<-gbm_rec[3]+tp/tt
  
  gbm_acc[2]<-gbm_acc[2]+
    1-(sum(abs(as.numeric(as.character(ytest[small[[x]]])) - as.numeric(as.character(predgbm[[x+5]]))))/length(ytest[small[[x]]]))
  gbm_fp[2]<-gbm_fp[2]+
    table(predgbm[[x+5]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,1]/length(ytest[small[[x]]])
  gbm_fn[2]<-gbm_fn[2]+
    table(predgbm[[x+5]], ytest[small[[x]]], dnn=list('predicted','actual'))[1,2]/length(ytest[small[[x]]])
  tp<-table(predgbm[[x+5]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,2]
  fp<-table(predgbm[[x+5]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,1]
  gbm_prec[2]<-gbm_prec[2]+tp/(fp+tp)
  tt<-table(predgbm[[x+5]], ytest[small[[x]]], dnn=list('predicted','actual'))[1,2]+
    table(predgbm[[x+5]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,2]
  gbm_rec[2]<-gbm_rec[2]+tp/tt
  
  gbm_acc[1]<-gbm_acc[1]+
    1-(sum(abs(as.numeric(as.character(ytest[small[[x]]])) - as.numeric(as.character(predgbm[[x+10]]))))/length(ytest[small[[x]]]))
  gbm_fp[1]<-gbm_fp[1]+
    table(predgbm[[x+10]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,1]/length(ytest[small[[x]]])
  gbm_fn[1]<-gbm_fn[1]+
    table(predgbm[[x+10]], ytest[small[[x]]], dnn=list('predicted','actual'))[1,2]/length(ytest[small[[x]]])
  tp<-table(predgbm[[x+10]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,2]
  fp<-table(predgbm[[x+10]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,1]
  gbm_prec[1]<-gbm_prec[1]+tp/(fp+tp)
  tt<-table(predgbm[[x+10]], ytest[small[[x]]], dnn=list('predicted','actual'))[1,2]+
    table(predgbm[[x+10]], ytest[small[[x]]], dnn=list('predicted','actual'))[2,2]
  gbm_rec[1]<-gbm_rec[1]+tp/tt
}
gbm_acc<-gbm_acc/5
gbm_fp<-gbm_fp/5
gbm_fn<-gbm_fn/5
gbm_prec<-gbm_prec/5
gbm_rec<-gbm_rec/5
gbm_acc
gbm_fp
gbm_fn
gbm_prec
gbm_rec

#Obtains optimal number of trees based on cv
system.time(newtrees<-gbm.perf(fit))
#newtrees = 100
#user  system elapsed 
#0.686   1.955   1.297

system.time(predgbm<-predict.gbm(object=fit
                              , newdata=datatest[smalltest,]
                              , n.trees=newtrees
                              , type="response"))

predgbm[which(predgbm>=0.9)]<-1
predgbm[which(predgbm<0.9)]<-0
table(predgbm, ytest[smalltest], dnn=list('predicted','actual'))
accuracy<-1-(sum(abs(as.numeric(as.character(ytest[smalltest])) - 
                       as.numeric(as.character(predgbm))))/length(ytest[smalltest]))
#test = 300, accuracy: 0.79

