library(XML)
#Read the file

create_cell<-function(nodeName,node){
  if(length(node)==0)
  {
    assign(nodeName,NA,envir = .GlobalEnv)
  }else{
    assign(xmlName(node[[1]]),xmlValue(node[[1]]),envir = .GlobalEnv)
  }
  
}

temp<-NULL

create_observation<-function(file)
{
xmlDoc<-xmlTreeParse(file)
xmltop<<-xmlRoot(xmlDoc)
#get the node

getNodeAndCreateCell<-function(node){
  if(node %in% names(other_tables))
  {
    print(node)
    table_name<-node
    
    nodeAddress<-paste("//",node,sep="")
    subnode<-getNodeSet(xmltop,nodeAddress)
    
    xmlSubNodes<-other_tables[[node]]
    
    sub_node<<-subnode[[1]]
    
    for (node in xmlSubNodes){
      nodeName<-node
      print(nodeName)
      nodeAddress<-paste("//",node,sep="")
      print(nodeAddress)
      node<-getNodeSet(sub_node,nodeAddress)
      #create_cell(nodeName,node)
    }
#     
#     char_vect<-sapply(xmlSubNodes,function(x)eval(parse(text=x)))
#     assign(table_name,data.frame(as.list(char_vect)),envir = .GlobalEnv)
  }
  nodeName<-node
  nodeAddress<-paste("//",node,sep="")
  node<-getNodeSet(xmltop,nodeAddress)
  create_cell(nodeName,node)
}


outcome_struct<-c("measure","time_frame","safety_issue","description")

other_tables<-list(primary_outcome=outcome_struct)

#xmlNodes<-c("nct_id","brief_title","acronym","official_title","source","brief_summary/textblock","detailed_description/textblock","overall_status","start_date","completion_date","primary_completion_date","phase","study_type","study_design","target_duration","number_of_arms","number_of_groups","primary_outcome")
xmlNodes<-c("primary_outcome")

sapply(xmlNodes,function(node) getNodeAndCreateCell(node))

# observation<<-data.frame(nct_id,brief_title,acronym,official_title,source,textblock,textblock,overall_status,start_date,completion_date,primary_completion_date,phase,study_type,study_design,target_duration,number_of_arms,number_of_groups,stringsAsFactors = FALSE)
# names(observation)[6]<-"brief_summary"
# names(observation)[7]<-"det-description"
# temp<<-rbind(temp,observation)
}

files<-dir()
sapply(files,function(file) create_observation(file))
observation<-temp
