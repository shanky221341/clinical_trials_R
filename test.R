id<-1
table_name<-"category_details"
category_details_temp<-NULL
for(item in x){
  categories<-xmlChildren(item)
  
  for(category in categories)
  {
    print("for observation number")
    # print(id)
    subtitle<-getNodeSet(category,"//sub_title")
     # print(length(subtitle))
     if(length(subtitle)!=0){
       # print(xmlValue(subtitle[[1]]))
       create_cell("sub_titile",subtitle)
     }
    measurements<-getNodeSet(category,"//measurement_list")
    measurements<-measurements[[1]]
    measurements<-xmlChildren(measurements)
    for(measurement in measurements){
      group_id<<-xmlGetAttr(measurement,"group_id")
      value<<-xmlGetAttr(measurement,"value")
      lower_limit<<-xmlGetAttr(measurement,"lower_limit")
      upper_limit<<-xmlGetAttr(measurement,"upper_limit")
      xmlSubNodes<-c("id","sub_title","group_id","value","lower_limit","upper_limit")
      char_vect<-sapply(xmlSubNodes,function(x)eval(parse(text=x)))
      assign(table_name,data.frame(as.list(char_vect)),envir = .GlobalEnv)
      var_name<-paste(table_name,"temp",sep="_")
      #print(var_name)
      assign(var_name,rbind(eval(parse(text=var_name)),eval(parse(text=table_name))),envir = .GlobalEnv)
    }
}
  id=id+1
}