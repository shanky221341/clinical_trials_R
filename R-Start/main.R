library(XML)
# Read the file

# source all the files in R folder
path <- list.files(pattern = "[.]R$", path = "../R/", full.names = TRUE)
sapply(path, source)

cat("Setting the temporary variables...\n")
temp <- NULL
temp1 <<- NULL
outcome_struct <- c("measure", "time_frame", "safety_issue", "description")
condition_struct <- c("condition")
arm_group_struct <- c("arm_group_label", "arm_group_type", "description")
intervention_struct <- c("intervention_type", "intervention_name", "description", "arm_group_label", "other_name")
eligibilit_struct <- c("study_pop/textblock", "sampling_method", "criteria/textblock", "gender", "minimum_age", "maximum_age")
investigator_struct <- c("first_name", "last_name", "middle_name", "degrees", "role", "affiliation")
address_struct <- c("city", "state", "zip", "country")
link_struct <- c("url", "description")
reference_struct <- c("citation", "PMID")
responsible_party_struct <- c("name_title", "organization", "responsible_party_type", "investigator_affiliation", "investigator_full_name", "investigator_title")

# structs for results database
group_struct <- c("title", "description")
participant_struct <- c("participant_id")
participants_list_struct <- c("participants_list_id")
milestone_struct <- c("title")
measure_struct <- c("title", "description", "units", "param", "dispersion")
results_outcome_struct <- c("type", "title", "description", "time_frame", "safety_issue", "posting_date", "population")
results_outcome_struct_group <- c("NULL")
participant_flow_struct<-c("recruitment_details","pre_assignment_details")
baseline_struct<-c("population")
period_list_struct<-c("title")
participants_list_struct1<-c("NULL")

other_tables <<- list(primary_outcome = outcome_struct, secondary_outcome = outcome_struct, other_outcome = outcome_struct, condition = condition_struct, arm_group = arm_group_struct, 
    intervention = intervention_struct, eligibility = eligibilit_struct, overall_official = investigator_struct, address = address_struct, link = link_struct, reference = reference_struct, 
    results_reference = reference_struct, responsible_party = responsible_party_struct, group = group_struct, participants = participant_struct, participants_list = participants_list_struct, 
    milestone = milestone_struct, `baseline/measure_list/measure` = measure_struct, `baseline/measure_list/measure/category_list` = measure_struct, `outcome_list/outcome` = results_outcome_struct, 
    `outcome_list/outcome/group_list` = results_outcome_struct_group,participant_flow=participant_flow_struct,'participant_flow/group_list/group'=group_struct,'participant_flow/period_list/period'=period_list_struct,
    'participant_flow/period_list/period/milestone_list/milestone'=milestone_struct,"participant_flow/period_list/period/milestone_list/milestone/participants_list"=participants_list_struct1,baseline=baseline_struct)

temporary_variables <<- paste(names(other_tables), "temp", sep = "_")
for (var in temporary_variables) {
    assign(var, NULL)
}
assign("measure_temp", NULL)
assign("outcome_temp", NULL)
assign("category_details_temp", NULL)
assign("outcome_group_temp", NULL)
assign("group_list_temp", NULL)
assign("period_list_temp",NULL)
assign("milestone_list_temp",NULL)
assign("participants_list_temp",NULL)

xmlNodesResults <<- c("group", "participants", "participants_list", "milestone", "measure", "category_details", "outcome", "outcome_group","participant_flow","group_list","period_list","milestone_list","participants_list","baseline")

create_observation <- function(file) {
    xmlDoc <- xmlTreeParse(file)
    xmltop <<- xmlRoot(xmlDoc)
    # get the node
    
    
    xmlNodes <- c("nct_id", "brief_title", "acronym", "official_title", "source", "brief_summary/textblock", "detailed_description/textblock", "overall_status", "start_date", "completion_date", 
        "primary_completion_date", "phase", "study_type", "study_design", "target_duration", "number_of_arms", "number_of_groups", "primary_outcome", "secondary_outcome", "other_outcome", 
        "condition", "arm_group", "intervention", "biospec_retention", "biospec_descr/textblock", "eligibility", "overall_official", "address", "link", "reference", "results_reference", 
        "verification_date", "lastchanged_date", "firstreceived_date", "firstreceived_results_date", "responsible_party")
    # xmlNodes<-c('primary_outcome')
    
    sapply(xmlNodes, function(node) getNodeAndCreateCell(node))
    
    observation <<- data.frame(nct_id, brief_title, acronym, official_title, source, brief_summary, detailed_description, overall_status, start_date, completion_date, primary_completion_date, 
        phase, study_type, study_design, target_duration, number_of_arms, number_of_groups, biospec_retention, biospec_descr, verification_date, lastchanged_date, firstreceived_date, 
        firstreceived_results_date, stringsAsFactors = FALSE)
    temp <<- rbind(temp, observation)
}

files <- dir()
sapply(files,function(file) create_observation(file))
file_counter<<-0
milestone_list_id<<-0
participants_list_id<<-0
temp3<<-0
temp4<<-1
for(file in files){
  file_counter<<-file_counter+1
  handleResultsDatabaseSeparately(file)
}

cat("Processing and parsing files...\n")
xml_names <- sapply(xmlNodesResults, function(node) paste(node, "temp", sep = "_"))


for (i in 1:length(xmlNodesResults)) {
    assign(xmlNodesResults[i], eval(parse(text = xml_names[i])), envir = .GlobalEnv)
}
rm(list = temporary_variables)
observation <- temp
results <- temp1
rm(group_list_temp)
rm(period_list_temp)
rm(milestone_list_temp)
rm(temp)
rm(temp1)
# rm(participants_list_temp)

library(RSQLite)
cat("Connecting to Sqlite database...\n")
driver<-SQLite()
conn<-dbConnect(driver,dbname="../clinical_trials.sqlite")

tables<-dbListTables(conn)
sapply(tables,function(x)dbRemoveTable(conn,x))

cat("Creating the database schema..\n")
#create the tables(schema in sqlite)
 create_result<-createTables_in_sqlite()

cat("Inserting the values in the tables in the sqlite database...\n")
#insert the values in the tables in the sqlite database
insetInto_tables_in_sqlite()