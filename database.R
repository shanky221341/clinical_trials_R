library(RSQLite)
driver<-SQLite()
conn<-dbConnect(driver,dbname="../clinical_trials.sqlite")
row_count<-nrow(participant_flow)
participant_flow_id<-seq(1, row_count, by = 1)
participant_flow<-data.frame(participant_flow_id,participant_flow)

sql <- "INSERT INTO participants_flow
        VALUES ($participant_flow_id, $nct_id, $recruitment_details,$pre_assignment_details,$group_list_id,$period_list_id)"
dbBegin(conn)
tryCatch(dbGetPreparedQuery(conn, sql, bind.data = participant_flow),
         error=function(e) { print("failed to  insert the data") }
)

dbCommit(conn)