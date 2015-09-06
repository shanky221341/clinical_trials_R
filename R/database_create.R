
createTables_in_sqlite<-function(){
  
  
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
PRIMARY KEY ( nct_id,group_id,group_list_id),
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (group_list_id)
REFERENCES participants_flow(group_list_id)
)"
dbSendQuery(conn,sql)

sql<-"CREATE TABLE period_list (
  s_no  integer NOT NULL,
nct_id         varchar(50),
title          text,
period_list_id  text,
milestone_list_id  integer NOT NULL,
drop_withdraw_reason_list_id text,
reason_list text,
PRIMARY KEY ( nct_id,milestone_list_id),
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (period_list_id)
REFERENCES participants_flow(period_list_id)
)"
dbSendQuery(conn,sql)
}