library(stringr)
library(dplyr)
library(tidyr)


make_base_df <- function(x){ 
  
  
# x<-("C:/Users/kaniballos/Dropbox/ampatziakas/SampleData/Dataset#1/mclOutput")

  work_list <-scan(file=x,what="character,",sep=" ",nlines=2, allowEscapes = TRUE)%>%
    str_split_fixed(.," ", n = Inf) %>%
    sapply(.,stri_escape_unicode) %>% #Escapes all Unicode (not ASCII-printable) code points ie. single /
    sapply(., function(x) str_split_fixed(x,"[\\\\]+t|[^[:print:]]" , n = Inf)) %>%
    lapply(., function(x) str_split_fixed(x,"\\|", n=Inf))%>%
    lapply(., function(x) data.frame(x, stringsAsFactors=FALSE)) %>%
    lapply(., function(x) separate(x,X1,into = c("Organism", "Protein", "Other"), sep="\\$"))%>%
    lapply(., function(x) x[,names(x) %in% c("Organism", "Protein") ])
  
  for (i in 1:length(work_list)){
    
    work_list[[i]]<-transform(work_list[[i]],Cluster=i)}
  
  
  #Make list to dataframe
  result_df<-bind_rows(work_list)
  rm(work_list)
  
  return(result_df)

            
            
}

cluster_composition<-function(x){
result_df_cl1<-x %>% group_by(.,Cluster,Organism) %>%
  summarise(.,Proteins=length(Protein))
return(result_df_cl1)}

cluster_participation<-function(x){
  result_df_cl2<-x %>% group_by(.,Cluster) %>%
    summarise(.,Organism_Participation=length(unique(Organism)))
  return(result_df_cl2)}


#examples
aa<-make_base_df("C:/Users/kaniballos/Dropbox/ampatziakas/SampleData/Dataset#1/mclOutput")

ab<-cluster_composition(aa)

ac<-cluster_participation(aa)
    