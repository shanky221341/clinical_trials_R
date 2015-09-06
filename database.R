library(RSQLite)
driver<-SQLite()
conn<-dbConnect(driver,dbname="../clinical_trials.sqlite")
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