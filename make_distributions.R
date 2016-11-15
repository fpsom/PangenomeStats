
ab<-my_list$cluster_composition
organism_names<-my_list$organism_names

mylist<-split(ab,ab$Cluster) #ab is cluster_composition output

a<-lapply(mylist, function(x) organism_names %in% x$Organism)

ac2<-bind_cols(a)
rm(mylist)
rm(a)





#distribution


#Remove singlets and doublets

#subset
ac3<-ac2[c(1:10,60:70),]
ac3<-ac3[,-which(apply(ac3,2,sum)==1)]
ac3<-ac3[,-which(apply(ac3,2,sum)==2)]

singleton_number<- length(which(apply(ac3,2,sum)==1))
doublet_number<- length(which(apply(ac3,2,sum)==2))
core_genome<-length(which((apply(ac3,2,sum)==nrow((ac3)))))
my_distribution<- data_frame(genomes=seq(1:nrow(ac3)),clusters=c(NA))

my_distribution$clusters[nrow(ac3)]<-core_genome


for(i in 6:6){
poss_comb<-as.data.frame(combn(nrow(ac3),nrow(ac3)-i))
mysize<-nrow(ac3[c(poss_comb[,i]),])
comb_list<-c()
for(j in 1:ncol(poss_comb)){

  comb_list[j]<- length(which(apply(ac3[c(poss_comb[,j]),],2,sum)==mysize))
  
}
my_distribution$clusters[nrow(ac3)-i]<-max(comb_list)
}





comb_list<-lapply(comb_list,as.data.frame)
lapply(comb_list,function (x) length(which(apply(x,2,sum)==nrow(x))))






my_results<-c()
for(i in 1:500){
  ac_test<-ac3[c(aaa2[,i]),]
my_results[i]<-length(which(apply(ac_test,2,sum)==nrow(ac_test)))
}

