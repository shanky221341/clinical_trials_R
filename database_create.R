library(RSQLite)
driver<-SQLite()
conn<-dbConnect(driver,dbname="../clinical_trials.sqlite")
sql<-"CREATE TABLE if not exists participants_flow (
  participant_flow_id     integer NOT NULL,
nct_id                  varchar(50) NOT NULL,
recruitment_details     text,
pre_assignment_details  text,
group_list_id           integer,
period_list_id          integer,
/* Keys */
PRIMARY KEY (participant_flow_id, nct_id)
)"

dbSendQuery(conn,sql)

sql<-"CREATE TABLE group_list (
  s_no  integer NOT NULL,
  nct_id         varchar(50),
  group_id       text,
  title          text,
  description    text,
  group_list_id  integer NOT NULL, 
  /* Foreign keys */
  CONSTRAINT Foreign_key01
    FOREIGN KEY (group_list_id)
    REFERENCES participants_flow(group_list_id)
)"
dbSendQuery(conn,sql)
dbDisconnect(conn)