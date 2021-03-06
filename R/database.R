
insetInto_tables_in_sqlite<-function(){
if(exists("participant_flow")& is.data.frame(participant_flow)){
  print("processing participant_flow")
row_count<-nrow(participant_flow)
participant_flow_id<-seq(1, row_count, by = 1)
participant_flow<-data.frame(participant_flow_id,participant_flow)

sql <- "INSERT INTO participants_flow
        VALUES ($participant_flow_id, $nct_id, $recruitment_details,$pre_assignment_details,$group_list_id,$period_list_id)"
dbBegin(conn)
tryCatch(dbGetPreparedQuery(conn, sql, bind.data = participant_flow),
         error=function(e) { print(e) }
)
dbCommit(conn)
}

if(exists("group_list") & is.data.frame(group_list)){
  print("processing group_list")
  row_count<-nrow(group_list)
  s_no<-seq(1, row_count, by = 1)
  group_list<-data.frame(s_no,group_list)
  
  sql <- "INSERT INTO group_list
  VALUES ($s_no, $nct_id, $group_id,$title,$description,$group_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = group_list),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("period_list")& is.data.frame(period_list)){
  print("processing period_list")
  row_count<-nrow(period_list)
  s_no<-seq(1, row_count, by = 1)
  period_list<-data.frame(s_no,period_list)
  
  sql <- "INSERT INTO period_list
  VALUES ($s_no, $nct_id, $title,$period_list_id,$milestone_list_id,$drop_withdraw_reason_list_id,$reason_list)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = period_list),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("milestone_list")& is.data.frame(milestone_list)){
  print("processing milestone_list")
  row_count<-nrow(milestone_list)
  s_no<-seq(1, row_count, by = 1)
  milestone_list<-data.frame(s_no,milestone_list)
  
  sql <- "INSERT INTO milestone_list
  VALUES ($s_no, $nct_id, $title,$milestone_list_id,$participants_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = milestone_list),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("participants_list")& is.data.frame(participants_list)){
  print("processing participants_list")
  row_count<-nrow(participants_list)
  s_no<-seq(1, row_count, by = 1)
  participants_list<-data.frame(s_no,participants_list)
  names(participants_list)[5]<-"participants_list_id"
  
  sql <- "INSERT INTO participants_list
  VALUES ($s_no, $nct_id, $group_id,$count,$participants_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = participants_list),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("observation")& is.data.frame(observation)){
  print("processing observation")
  row_count<-nrow(observation)
  s_no<-seq(1, row_count, by = 1)
  observation<-data.frame(s_no,observation)
  
  sql <- "INSERT INTO observation
  VALUES ($s_no, $nct_id, $brief_title,$acronym,$official_title,$source,$brief_summary,$detailed_description,$overall_status,$start_date,$completion_date,$primary_completion_date,$phase,$study_type,$study_design,$target_duration,$number_of_arms,$number_of_groups,$biospec_retention,$biospec_descr,$verification_date,$lastchanged_date,$firstreceived_date,$firstreceived_results_date)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = observation),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("address")& is.data.frame(address)){
  print("processing address")
  
  sql <- "INSERT INTO address
  VALUES ( $nct_id, $city,$state,$zip,$country)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = address),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("arm_group")& is.data.frame(arm_group)){
  print("processing arm_group")
  
  sql <- "INSERT INTO arm_group
  VALUES ( $nct_id, $arm_group_label,$arm_group_type,$description)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = arm_group),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("condition")& is.data.frame(condition)){
  print("processing condition")
  
  sql <- "INSERT INTO condition
  VALUES ( $nct_id, $condition)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = condition),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("eligibility")& is.data.frame(eligibility)){
  print("processing eligibility")
  
  sql <- "INSERT INTO eligibility
  VALUES ( $nct_id, $study_pop,$sampling_method,$criteria,$gender,$minimum_age,$maximum_age)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = eligibility),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("intervention")& is.data.frame(intervention)){
  print("processing intervention")
  
  sql <- "INSERT INTO intervention
  VALUES ( $nct_id, $intervention_type,$intervention_name,$description,$arm_group_label,$other_name)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = intervention),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("other_outcome")& is.data.frame(other_outcome)){
  print("processing other_outcome")
  
  sql <- "INSERT INTO other_outcome
  VALUES ( $nct_id, $measure,$time_frame,$safety_issue,$description)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = other_outcome),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("baseline")& is.data.frame(baseline)){
  print("processing baseline")
  sql <- "INSERT INTO baseline
  VALUES ( $nct_id, $population,$group_list_id,$measure_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = baseline),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("overall_official")& is.data.frame(overall_official)){
  print("processing overall_official")
  sql <- "INSERT INTO overall_official
  VALUES ( $nct_id, $first_name,$last_name,$middle_name,$degrees,$role,$affiliation)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = overall_official),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("primary_outcome")& is.data.frame(primary_outcome)){
  print("processing primary_outcome")
  sql <- "INSERT INTO primary_outcome
  VALUES ( $nct_id, $measure,$time_frame,$safety_issue,$description)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = primary_outcome),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("reference")& is.data.frame(reference)){
  print("processing reference")
  sql <- "INSERT INTO reference
  VALUES ( $nct_id, $citation,$PMID)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = reference),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("responsible_party")& is.data.frame(responsible_party)){
  print("processing responsible_party")
  sql <- "INSERT INTO responsible_party
  VALUES ( $nct_id, $name_title,$organization,$responsible_party_type,$investigator_affiliation,$investigator_full_name,$investigator_title)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = responsible_party),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("secondary_outcome")& is.data.frame(secondary_outcome)){
  print("processing secondary_outcome")
  sql <- "INSERT INTO secondary_outcome
  VALUES ( $nct_id, $measure,$time_frame,$safety_issue,$description)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = secondary_outcome),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("group_list_baseline")& is.data.frame(group_list_baseline)){
  print("processing group_list_baseline")
  row_count<-nrow(group_list_baseline)
  s_no<-seq(1, row_count, by = 1)
  group_list_baseline<-data.frame(s_no,group_list_baseline)
  
  sql <- "INSERT INTO group_list_baseline
  VALUES ($s_no, $nct_id, $group_id,$title,$description,$group_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = group_list_baseline),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
if(exists("measure_list")& is.data.frame(measure_list)){
  print("processing measure_list")
  row_count<-nrow(measure_list)
  s_no<-seq(1, row_count, by = 1)
  measure_list<-data.frame(s_no,measure_list)
  
  sql <- "INSERT INTO measure_list
  VALUES ($s_no, $nct_id,$title,$description,$units,$param,$dispersion,$measure_list_id,$category_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = measure_list),
           error=function(e) { print(e) }
  )
  dbCommit(conn)
}
}