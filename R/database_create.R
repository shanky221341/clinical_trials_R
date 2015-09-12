
createTables_in_sqlite<-function(){
  
  
sql<-"CREATE TABLE if not exists participants_flow (
  participant_flow_id     integer NOT NULL,
nct_id                  varchar(50) NOT NULL,
recruitment_details     text,
pre_assignment_details  text,
group_list_id           integer,
period_list_id          integer,
/* Keys */
PRIMARY KEY (participant_flow_id, nct_id),
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
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

sql<-"CREATE TABLE milestone_list (
  s_no  integer NOT NULL,
nct_id         varchar(50),
title          text,
milestone_list_id  integer NOT NULL,
participants_list_id integer,
PRIMARY KEY ( nct_id,participants_list_id),
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (milestone_list_id)
REFERENCES period_list(milestone_list_id)
)"
dbSendQuery(conn,sql)

sql<-"CREATE TABLE participants_list (
  s_no  integer NOT NULL,
nct_id         varchar(50),
group_id          text,
count  text,
participants_list_id integer,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (participants_list_id)
REFERENCES milestone_list(participants_list_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE observation (
  s_no  integer NOT NULL,
nct_id         varchar(50),
brief_title          text,
acronym  text,
official_title text,
source text,
brief_summary text,
detailed_description text,
overall_status text,
start_date text,
completion_date text,
primary_completion_date text,
phase text,
study_type text,
study_design text,
target_duration text,
number_of_arms text,
number_of_groups text,
biospec_retention text,
biospec_descr text,
verification_date text,
lastchanged_date text,
firstreceived_date text,
firstreceived_results_date text)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE address (
nct_id         varchar(50),
city          text,
state  text,
zip text,
country text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE arm_group (
nct_id         varchar(50),
arm_group_label          text,
arm_group_type  text,
description text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE condition (
nct_id         varchar(50),
condition          text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE eligibility (
nct_id         varchar(50),
study_pop          text,
sampling_method text,
criteria text,
gender text,
minimum_age text,
maximum_age text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE intervention (
nct_id         varchar(50),
intervention_type          text,
intervention_name text,
description text,
arm_group_label text,
other_name text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE other_outcome (
nct_id         varchar(50),
measure          text,
time_frame text,
safety_issue text,
description text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE baseline (
nct_id         varchar(50),
population          text,
group_list_id text,
measure_list_id text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE overall_official (
nct_id         varchar(50),
first_name          text,
last_name text,
middle_name text,
degrees text,
role text,
affiliation text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE primary_outcome (
nct_id         varchar(50),
measure          text,
time_frame text,
safety_issue text,
description text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE reference (
nct_id         varchar(50),
citation          text,
PMID text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE responsible_party (
nct_id         varchar(50),
name_title          text,
organization text,
responsible_party_type text,
investigator_affiliation text,
investigator_full_name text,
investigator_title text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE secondary_outcome (
nct_id         varchar(50),
measure          text,
time_frame text,
safety_issue text,
description text,
/* Foreign keys */
CONSTRAINT Foreign_key01
FOREIGN KEY (nct_id)
REFERENCES observation(nct_id)
)"
dbSendQuery(conn,sql)
sql<-"CREATE TABLE group_list_baseline (
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
REFERENCES baseline(group_list_id)
)"
dbSendQuery(conn,sql)
}