handleResultsDatabaseSeparately<-function(file){
  
  #create the group_table
  xmlDoc<-xmlTreeParse(file)
  xmltop<<-xmlRoot(xmlDoc)
  node_temp<-getNodeSet(xmltop,"//nct_id")
   assign(xmlName(node_temp[[1]]),xmlValue(node_temp[[1]]),envir = .GlobalEnv)
  xmlNodes<<-c("group","recruitment_details","pre_assignment_details","participants","participants_list","milestone")
  
  for(node in xmlNodes){
  
    if(node %in% names(other_tables))
      {
      # print(node)
        table_name<-node
        nodeAddress<-paste("//",node,sep="")
        subnode<<-getNodeSet(xmltop,nodeAddress)
        
        xmlSubNodes<-other_tables[[node]]
        
        counter=0
        for(node in subnode){
          counter=counter+1
          sub_node<<-node
          if(xmlName(sub_node)=="group"){
            group_id<<-xmlGetAttr(sub_node,"group_id")
          }
          if(xmlName(sub_node)=="participants"){
            group_id<<-xmlGetAttr(sub_node,"group_id")
            count<<-xmlGetAttr(sub_node,"count")
          }
          if(xmlName(sub_node)=="milestone"){
            participant_list_id<<-counter
          }
          if(table_name=='participants_list')
          {
          participant_list_id<<-counter
          children_list<-xmlChildren(node)
           for(child in children_list){
             
             group_id<<-xmlGetAttr(child,"group_id")
             count<<-xmlGetAttr(child,"count")
             
             xmlSubNodes<-c("nct_id","group_id","count","participant_list_id")
             
             char_vect<-sapply(xmlSubNodes,function(x)eval(parse(text=x)))
             assign(table_name,data.frame(as.list(char_vect)),envir = .GlobalEnv)
             var_name<-paste(table_name,"temp",sep="_")
             #print(var_name)
             assign(var_name,rbind(eval(parse(text=var_name)),eval(parse(text=table_name))),envir = .GlobalEnv)
           }
          participant_list_id<<-participant_list_id+1
          }
          else{
          for (node in xmlSubNodes){
            nodeName<-node
            nodeAddress<-paste("//",node,sep="")
            node<-getNodeSet(sub_node,nodeAddress)
            if(!(nodeName %in% c('nct_id','group_id','count',"participant_list_id")))
              create_cell(nodeName,node)
            if(xmlName(sub_node)=="participants"){
              participant_id<<-counter
            }
          }
          if(counter==1){
            xmlSubNodes<-append("nct_id",xmlSubNodes)
          }
          if(counter==1 & xmlName(sub_node)=="group" ){
            xmlSubNodes<-append("group_id",xmlSubNodes)
          }
          if(counter==1 & xmlName(sub_node)=="participants" ){
            xmlSubNodes<-append("group_id",xmlSubNodes)
            xmlSubNodes<-append("count",xmlSubNodes)
          }
          if(counter==1 & xmlName(sub_node)=="milestone" ){
            xmlSubNodes<-append("participant_list_id",xmlSubNodes)            
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
    }else{
      nodeName<-node
      nodeAddress<-paste("//",node,sep="")
      node<-getNodeSet(xmltop,nodeAddress)
      create_cell(nodeName,node)  
      }
  }
  
  results<<-data.frame(nct_id,recruitment_details,pre_assignment_details,stringsAsFactors = FALSE)
  temp1<<-rbind(temp1,results)
}