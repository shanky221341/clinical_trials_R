
insetInto_tables_in_sqlite<-function(){
if(exists("participant_flow")){
  print("processing")
row_count<-nrow(participant_flow)
participant_flow_id<-seq(1, row_count, by = 1)
participant_flow<-data.frame(participant_flow_id,participant_flow)

sql <- "INSERT INTO participants_flow
        VALUES ($participant_flow_id, $nct_id, $recruitment_details,$pre_assignment_details,$group_list_id,$period_list_id)"
dbBegin(conn)
tryCatch(dbGetPreparedQuery(conn, sql, bind.data = participant_flow),
         error=function(e) { print(e) }
)
}
dbCommit(conn)
if(exists("group_list")){
  print("processing")
  row_count<-nrow(group_list)
  s_no<-seq(1, row_count, by = 1)
  group_list<-data.frame(s_no,group_list)
  
  sql <- "INSERT INTO group_list
  VALUES ($s_no, $nct_id, $group_id,$title,$description,$group_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = group_list),
           error=function(e) { print(e) }
  )
}
dbCommit(conn)
if(exists("period_list")){
  print("processing")
  row_count<-nrow(period_list)
  s_no<-seq(1, row_count, by = 1)
  period_list<-data.frame(s_no,period_list)
  
  sql <- "INSERT INTO period_list
  VALUES ($s_no, $nct_id, $title,$period_list_id,$milestone_list_id,$drop_withdraw_reason_list_id,$reason_list)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = period_list),
           error=function(e) { print(e) }
  )
}
dbCommit(conn)
if(exists("milestone_list")){
  print("processing")
  row_count<-nrow(milestone_list)
  s_no<-seq(1, row_count, by = 1)
  milestone_list<-data.frame(s_no,milestone_list)
  
  sql <- "INSERT INTO milestone_list
  VALUES ($s_no, $nct_id, $title,$milestone_list_id,$participants_list_id)"
  dbBegin(conn)
  tryCatch(dbGetPreparedQuery(conn, sql, bind.data = milestone_list),
           error=function(e) { print(e) }
  )
}
dbCommit(conn)
if(exists("participants_list")){
  print("processing")
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
}
dbCommit(conn)
}