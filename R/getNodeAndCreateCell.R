getNodeAndCreateSeparateTableForNodeswithMultipleChild<-function(node){
  
  table_name<-node
  nodeAddress<-paste("//",node,sep="")
  subnode<<-getNodeSet(xmltop,nodeAddress)
  #print(node)
  #print(length(subnode))
  
  xmlSubNodes<-other_tables[[node]]
  counter=0
  for(node in subnode){
    counter=counter+1
    sub_node<<-node
    
    for (node in xmlSubNodes){
      nodeName<-node
      nodeAddress<-paste("//",node,sep="")
      node<-getNodeSet(sub_node,nodeAddress)
      if(nodeName!='nct_id')
        create_cell(nodeName,node)
      
    }
    if(counter==1){
      
      xmlSubNodes<-append("nct_id",xmlSubNodes)
    }
    
    for(i in 1:length(xmlSubNodes)){
      if(grepl("/",xmlSubNodes[i])){
        xmlSubNodes[i]<-unlist(strsplit(xmlSubNodes[i],split="/"))[1]
      }
    }
    
    char_vect<-sapply(xmlSubNodes,function(x)eval(parse(text=x)))
    assign(table_name,data.frame(as.list(char_vect)),envir = .GlobalEnv)
    
    #print(primary_outcome)
    var_name<-paste(table_name,"temp",sep="_")
    #print(var_name)
    assign(var_name,rbind(eval(parse(text=var_name)),eval(parse(text=table_name))),envir = .GlobalEnv)
  }
}

getNodeAndCreateCell<-function(node){
  if(node %in% names(other_tables))
  {
    #if(node=='overall_official')
      print(node)
    getNodeAndCreateSeparateTableForNodeswithMultipleChild(node)
    #print(nrow(temp1))
    #assign(node,temp1,envir = .GlobalEnv)
    var_name<-paste(node,"temp",sep="_")
    assign(node,eval(parse(text=var_name)),envir = .GlobalEnv)
    
  }else{
    nodeName<-node
    nodeAddress<-paste("//",node,sep="")
    node<-getNodeSet(xmltop,nodeAddress)
    create_cell(nodeName,node)
  }
}