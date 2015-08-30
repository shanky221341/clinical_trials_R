library(XML)
#Read the file

#source all the files in R folder
path<-list.files(pattern="[.]R$", path="../R/", full.names=TRUE)
sapply(path, source)

temp<-NULL
temp1<-NULL
temp2<-NULL

outcome_struct<-c("measure","time_frame","safety_issue","description")
condition_struct<-c("condition")
arm_group_struct<-c("arm_group_label","arm_group_type","description")
intervention_struct<-c("intervention_type","intervention_name","description","arm_group_label","other_name")
other_tables<<-list(primary_outcome=outcome_struct,secondary_outcome=outcome_struct,other_outcome=outcome_struct,condition=condition_struct,arm_group=arm_group_struct,intervention=intervention_struct)

temporary_variables<<-paste(names(other_tables),"temp",sep="_")
a<-c(1,1,1,1,1)
for(var in temporary_variables){assign(var,NULL)}

create_observation<-function(file)
{
xmlDoc<-xmlTreeParse(file)
xmltop<<-xmlRoot(xmlDoc)
#get the node


xmlNodes<-c("nct_id","brief_title","acronym","official_title","source","brief_summary/textblock","detailed_description/textblock","overall_status","start_date","completion_date","primary_completion_date","phase","study_type","study_design","target_duration","number_of_arms","number_of_groups","primary_outcome","secondary_outcome","other_outcome","condition","arm_group","intervention","biospec_retention","biospec_descr")
#xmlNodes<-c("primary_outcome")

sapply(xmlNodes,function(node) getNodeAndCreateCell(node))

observation<<-data.frame(nct_id,brief_title,acronym,official_title,source,textblock,textblock,overall_status,start_date,completion_date,primary_completion_date,phase,study_type,study_design,target_duration,number_of_arms,number_of_groups,biospec_retention,biospec_descr,stringsAsFactors = FALSE)
names(observation)[6]<-"brief_summary"
names(observation)[7]<-"det-description"
temp<<-rbind(temp,observation)
}

files<-dir()
sapply(files,function(file) create_observation(file))
rm(list=temporary_variables)
observation<-temp
rm(temp)