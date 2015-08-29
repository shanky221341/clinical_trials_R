library(XML)
#Read the file

#source all the files in R folder
path<-list.files(pattern="[.]R$", path="../R/", full.names=TRUE)
sapply(path, source)

temp<-NULL
temp1<-NULL
temp2<-NULL

create_observation<-function(file)
{
xmlDoc<-xmlTreeParse(file)
xmltop<<-xmlRoot(xmlDoc)
#get the node

outcome_struct<-c("measure","time_frame","safety_issue","description")

other_tables<<-list(primary_outcome=outcome_struct,secondary_outcome=outcome_struct)

xmlNodes<-c("nct_id","brief_title","acronym","official_title","source","brief_summary/textblock","detailed_description/textblock","overall_status","start_date","completion_date","primary_completion_date","phase","study_type","study_design","target_duration","number_of_arms","number_of_groups","secondary_outcome")
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
