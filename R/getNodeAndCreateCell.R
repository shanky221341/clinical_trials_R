getNodeAndCreateSeparateTableForNodeswithMultipleChild<-function(){
  
  table_name<-node
  
  nodeAddress<-paste("//",node,sep="")
  subnode<<-getNodeSet(xmltop,nodeAddress)
  
  xmlSubNodes<-other_tables[[node]]
  counter=0
  for(node in subnode){
    counter=counter+1
    sub_node<<-node
    
    for (node in xmlSubNodes){
      nodeName<-node
      nodeAddress<-paste("//",node,sep="")
      node<-getNodeSet(sub_node,nodeAddress)
      if(nodeName=='time_frame')
      {print(node)}
      if(nodeName!='nct_id')
        create_cell(nodeName,node)
      
    }
    if(counter==1){
      
      xmlSubNodes<-append("nct_id",xmlSubNodes)
    }
    char_vect<-sapply(xmlSubNodes,function(x)eval(parse(text=x)))
    assign(table_name,data.frame(as.list(char_vect)),envir = .GlobalEnv)
    
    #print(primary_outcome)
    temp1<<-rbind(temp1,primary_outcome)
  }
}

getNodeAndCreateCell<-function(node){
  if(node %in% names(other_tables))
  {
    getNodeAndCreateSeparateTableForNodeswithMultipleChild(node)
    
    
  }else{
    nodeName<-node
    nodeAddress<-paste("//",node,sep="")
    node<-getNodeSet(xmltop,nodeAddress)
    create_cell(nodeName,node)
  }
}