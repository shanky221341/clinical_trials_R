create_cell<-function(nodeName,node){
  if(length(node)==0 )
  {
    assign(nodeName,NA,envir = .GlobalEnv)
  }else{
    assign(xmlName(node[[1]]),xmlValue(node[[1]]),envir = .GlobalEnv)
  }
  
}