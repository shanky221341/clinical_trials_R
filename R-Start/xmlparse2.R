library(XML)
#Read the file

temp<-NULL
temp1<-NULL

create_observation<-function(file)
{
xmlDoc<-xmlTreeParse(file)
xmltop<<-xmlRoot(xmlDoc)
#get the node

getNodeAndCreateCell<-function(node){
  if(node %in% names(other_tables))
  {
    table_name<-node
    
    nodeAddress<-paste("//",node,sep="")
    subnode<<-getNodeSet(xmltop,nodeAddress)
    
    xmlSubNodes<-other_tables[[node]]
    counter=0
#     if(length(subnode)==8)
#     {
#       print(subnode)
#       x<<-subnode
    
    #print(length(subnode))
    for(node in subnode){
      # print(node)
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
  }else{
  nodeName<-node
  nodeAddress<-paste("//",node,sep="")
  node<-getNodeSet(xmltop,nodeAddress)
  create_cell(nodeName,node)
  }
}


outcome_struct<-c("measure","time_frame","safety_issue","description")

other_tables<-list(primary_outcome=outcome_struct)

xmlNodes<-c("nct_id","brief_title","acronym","official_title","source","brief_summary/textblock","detailed_description/textblock","overall_status","start_date","completion_date","primary_completion_date","phase","study_type","study_design","target_duration","number_of_arms","number_of_groups","primary_outcome")
#xmlNodes<-c("primary_outcome")

sapply(xmlNodes,function(node) getNodeAndCreateCell(node))

observation<<-data.frame(nct_id,brief_title,acronym,official_title,source,textblock,textblock,overall_status,start_date,completion_date,primary_completion_date,phase,study_type,study_design,target_duration,number_of_arms,number_of_groups,stringsAsFactors = FALSE)
names(observation)[6]<-"brief_summary"
names(observation)[7]<-"det-description"
temp<<-rbind(temp,observation)
}

files<-dir()
sapply(files,function(file) create_observation(file))
observation<-temp
