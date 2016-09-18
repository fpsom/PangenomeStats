library(stringi)
library(stringr)
library(dplyr)
library(tidyr)

split_backlash<-function(x){str_split_fixed(x,"[\\\\]|[^[:print:]]" , n = Inf) # / needs to be escaped
}

# approach 1
list<-scan(file="C:/Users/kaniballos/Dropbox/ampatziakas/SampleData/Dataset#1/mclOutput",
           what="character,",sep=" ",nlines=2, allowEscapes = TRUE)

mylist<-str_split_fixed(aaa," ", n = Inf)
mylist<-sapply(mylist,stri_escape_unicode) #Escapes all Unicode (not ASCII-printable) code points ie. single /
mylist<-sapply(mylist,split_backlash)
#mylist<-lapply(mylist, function(x) data.frame(x, stringsAsFactors=FALSE))

mylist2<-lapply(mylist,function(x) str_split_fixed(x,"\\|", n=Inf)) # |needs to be escaped 
#mylist2<-lapply(mylist2,function(x) str_split_fixed(x[,1],"\\$", n=3)) # |needs to be escaped
mylist2<-lapply(mylist2, function(x) data.frame(x, stringsAsFactors=FALSE))


#aa<-mylist2[[1]]
#aa<-mylist2[[2]]
mydf<-separate(aa,X1,into = c("Organism", "Protein", "Other"), sep="\\$")

mydf$X4<-mydf$Other
mydf$Other[nchar(mydf$Other)>3]<-NA #is this right?
mydf$X4[nchar(mydf$X4)<3]<-NA
mydf$X2[mydf$X2==""]<-mydf$X4[mydf$X2 == "" & !is.na(mydf$X4)]
mydf$X4[mydf$X2 == mydf$X4]<-NA

if(length(is.na(mydf$X4)==TRUE)==length(mydf$X4)){ 
  mydf<- subset(mydf, select=-c(X4))} else{
    #insert function made above
  } 


#pipelined
mylist<-scan(file="C:/Users/kaniballos/Dropbox/ampatziakas/SampleData/Dataset#1/mclOutput",
             what="character,",sep=" ",nlines=2, allowEscapes = TRUE)%>%
  str_split_fixed(.," ", n = Inf) %>%
  sapply(.,stri_escape_unicode) %>% #Escapes all Unicode (not ASCII-printable) code points ie. single /
  sapply(.,function(x) str_split_fixed(x,"[\\\\]|[^[:print:]]" , n = Inf)) %>%
  lapply(.,function(x) str_split_fixed(x,"\\|", n=Inf))%>%
  lapply(., function(x) data.frame(x, stringsAsFactors=FALSE)) %>%
  lapply(.,function(x) separate(x,X1,into = c("Organism", "Protein", "Other"), sep="\\$"))

#names(mylist)<-paste("cluster_",seq(1:length(mylist)))

for (i in 1:length(mylist)){
  
  mylist[[i]]<-transform(mylist[[i]],Cluster=i)
}

#Reduce
mydf <-Reduce(function(...) merge(..., all=T), mylist) %>%
  arrange(.,Cluster)

#Bind rows
mydf<-bind_rows(mylist)


mydf$X4<-mydf$Other
mydf$Other[nchar(mydf$Other)>3]<-NA #is this right?
mydf$X4[nchar(mydf$X4)<3]<-NA
mydf$X2[mydf$X2==""]<-mydf$X4[mydf$X2 == "" & !is.na(mydf$X4)]
mydf$X4[mydf$X2 == mydf$X4]<-NA

if(length(is.na(mydf$X4)==TRUE)==length(mydf$X4)){ 
  mydf<- subset(mydf, select=-c(X4))} else{
    #insert function made above
  } 


#vectorise with lapply
#add names
# give choice for list/connect to big data frame?
#???
#win



#str split approach 


aaa<-scan(file="C:/Users/kaniballos/Dropbox/ampatziakas/SampleData/Dataset#1/mclOutput",
          what="character,",sep=" ",nlines=2, allowEscapes = TRUE)


mylist<-str_split_fixed(aaa," ", n = Inf)
mylist<-sapply(mylist,stri_escape_unicode) #Escapes all Unicode (not ASCII-printable) code points ie. single /
mylist<-sapply(mylist,split_backlash)
mylist<-lapply(mylist, function(x) data.frame(x, stringsAsFactors=FALSE))


mylist2<-lapply(mylist,function(x) str_split_fixed(x,"\\|", n=Inf)) # |needs to be escaped 

mylist2<-lapply(mylist2,function(x) str_split_fixed(x[,1],"\\$", n=3)) # |needs to be escaped

aaaa<-mylist2[[1]]

aaaa<-mylist2[[2]]


stri_escape_unicode(mytest)
X <- read.table(textConnection(aaa))

df<-as.data.frame(aaa)
df$aaa<-as.character(df$aaa)

gsplit<-"([:alnum:])([$])([:alnum:])[$tr].*)"
g2<-"[:alnum:].+ \\$[:alnum:].+ \\$tr."

lala<-strsplit(df$aaa,"[\\\\]|[^[:print:]]",fixed=FALSE)

test<-strsplit(lala[[1]],"[\]",fixed=TRUE)


mytest<-lol[3]
aa<-str_split_fixed(lala[[1]]," ", n = Inf)

lala2<-lapply(lala,mystrsp)
lala3<-strsplit(lala[[1]],"\\",fixed = TRUE)


df2<-as.data.frame(lala[[1]])

library(stringr)

str_extract_all(aaa,mystrsp)