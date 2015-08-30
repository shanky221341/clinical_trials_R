create_cell<-function(nodeName,node){
  if(length(node)==0 )
  {
    if(grepl("/",nodeName)){
      #print(nodeName)
      nodeName<-unlist(strsplit(nodeName,split="/"))[1]
    }
    assign(nodeName,NA,envir = .GlobalEnv)
  }else{
    colName<-xmlName(node[[1]])
    #print(nodeName)
    if(grepl("/",nodeName)){
      #print(nodeName)
      colName<-unlist(strsplit(nodeName,split="/"))[1]
    }
    assign(colName,xmlValue(node[[1]]),envir = .GlobalEnv)
  }
  
}