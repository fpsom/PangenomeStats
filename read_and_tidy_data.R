library(stringr)
library(dplyr)
library(tidyr)

#pipelined

#Function takes MCL output file location as argument
#Returns a dataframe 
read_mcl <- function(x){ 
  
  split_backlash<-function(x){str_split_fixed(x,"[\\\\]|[^[:print:]]" , n = Inf) # / needs to be escaped
  }
  
  work_list <-scan(file=x,what="character,",sep=" ",nlines=2, allowEscapes = TRUE)%>%
    str_split_fixed(.," ", n = Inf) %>%
    sapply(.,stri_escape_unicode) %>% #Escapes all Unicode (not ASCII-printable) code points ie. single /
    sapply(.,function(x) str_split_fixed(x,"[\\\\]|[^[:print:]]" , n = Inf)) %>%
    lapply(.,function(x) str_split_fixed(x,"\\|", n=Inf))%>%
    lapply(., function(x) data.frame(x, stringsAsFactors=FALSE)) %>%
    lapply(.,function(x) separate(x,X1,into = c("Organism", "Protein", "Other"), sep="\\$"))
  
  
  
  #Add cluster membership
  for (i in 1:length(work_list)){
    
    work_list[[i]]<-transform(work_list[[i]],Cluster=i)
  }
  
  
  #Make list to dataframe
  result_df<-bind_rows(work_list)
  rm(work_list)
  
  #Clear cases where database identifier (tr, sp etc) exist and cases
  #where input after second $ is protein annotation
  
  result_df$X4<-result_df$Other
  result_df$Other[nchar(result_df$Other)>3]<-NA #is this right?
  result_df$X4[nchar(result_df$X4)<3]<-NA
  
  result_df$X2[result_df$X2==""]<-result_df$X4[result_df$X2 == "" & !is.na(result_df$X4)]
  result_df$X4[result_df$X2 == result_df$X4]<-NA
  
  if(length(is.na(result_df$X4)==TRUE)==length(result_df$X4)){ 
    
    result_df<- subset(result_df, select=-c(X4))} else{
      result_df$X3[result_df$X3==""]<-result_df$X4[result_df$X3 == "" & !is.na(result_df$X4)]
      result_df$X3[result_df$X2 == result_df$X3]<-NA
      
      if(length(is.na(result_df$X4)==TRUE)==length(result_df$X4)){ 
        result_df<- subset(result_df, select=-c(X4))}
    }
  
  
  if(ncol(result_df)==6){
    colnames(result_df)<-c("Organism","Protein_Identifier","Database_Identifier","Annotation_1","Annotation_2",
                      "Cluster") }
  
  if(ncol(result_df)==7){
    colnames(result_df)<-c("Organism","Protein_Identifier","Database_Identifier","Annotation_1","Annotation_2",
                      "Annotation_3","Cluster") }
  
  result_df$Annotation_1[result_df$Annotation_1==""]<-NA
  result_df$Annotation_2[result_df$Annotation_2==""]<-NA
  
  if("result_df$Annotation_3" %in% colnames(result_df)){
    result_df$Annotation_3[result_df$Annotation_3==""]<-NA
  }
  
  return(result_df)
  }

#Alternative to bind rows
#Should speed test
#Reduce
# result_df <-Reduce(function(...) merge(..., all=T), work_list) %>%
#   arrange(.,Cluster)

#Bind rows
 
#Example
aa<-read_mcl("C:/Users/kaniballos/Dropbox/ampatziakas/SampleData/Dataset#1/mclOutput")



