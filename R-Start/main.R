library(XML)
#Read the file

#source all the files in R folder
path<-list.files(pattern="[.]R$", path="../R/", full.names=TRUE)
sapply(path, source)

temp<-NULL
temp1<<-NULL
outcome_struct<-c("measure","time_frame","safety_issue","description")
condition_struct<-c("condition")
arm_group_struct<-c("arm_group_label","arm_group_type","description")
intervention_struct<-c("intervention_type","intervention_name","description","arm_group_label","other_name")
eligibilit_struct<-c("study_pop/textblock","sampling_method","criteria/textblock","gender","minimum_age","maximum_age")
investigator_struct<-c("first_name","last_name","middle_name","degrees","role","affiliation")
address_struct<-c("city","state","zip","country")
link_struct<-c("url","description")
reference_struct<-c("citation","PMID")
responsible_party_struct<-c("name_title","organization","responsible_party_type","investigator_affiliation","investigator_full_name","investigator_title")
group_struct<-c("title","description")
other_tables<<-list(primary_outcome=outcome_struct,secondary_outcome=outcome_struct,other_outcome=outcome_struct,condition=condition_struct,arm_group=arm_group_struct,intervention=intervention_struct,eligibility=eligibilit_struct,overall_official=investigator_struct,address=address_struct,link=link_struct,reference=reference_struct,results_reference=reference_struct,responsible_party=responsible_party_struct,group=group_struct)

temporary_variables<<-paste(names(other_tables),"temp",sep="_")
for(var in temporary_variables){assign(var,NULL)}

xmlNodesResults<<-c("group")
create_observation<-function(file)
{
xmlDoc<-xmlTreeParse(file)
xmltop<<-xmlRoot(xmlDoc)
#get the node


xmlNodes<-c("nct_id","brief_title","acronym","official_title","source","brief_summary/textblock","detailed_description/textblock","overall_status","start_date","completion_date","primary_completion_date","phase","study_type","study_design","target_duration","number_of_arms","number_of_groups","primary_outcome","secondary_outcome","other_outcome","condition","arm_group","intervention","biospec_retention","biospec_descr/textblock","eligibility","overall_official","address","link","reference","results_reference","verification_date","lastchanged_date","firstreceived_date","firstreceived_results_date","responsible_party")
#xmlNodes<-c("primary_outcome")

sapply(xmlNodes,function(node) getNodeAndCreateCell(node))

observation<<-data.frame(nct_id,brief_title,acronym,official_title,source,brief_summary,detailed_description,overall_status,start_date,completion_date,primary_completion_date,phase,study_type,study_design,target_duration,number_of_arms,number_of_groups,biospec_retention,biospec_descr,verification_date,lastchanged_date,firstreceived_date,firstreceived_results_date,stringsAsFactors = FALSE)
#names(observation)[6]<-"brief_summary"
#names(observation)[7]<-"det-description"
temp<<-rbind(temp,observation)
}

files<-dir()
#sapply(files,function(file) create_observation(file))

sapply(files,function(file) handleResultsDatabaseSeparately(file))

xml_names<-sapply(xmlNodesResults,function(node)paste(node,"temp",sep="_"))

for(i in 1:length(xmlNodesResults)){
  assign(xmlNodesResults[i],eval(parse(text=xml_names[i])),envir = .GlobalEnv)  
}

rm(list=temporary_variables)
observation<-temp
results<-temp1
rm(temp)