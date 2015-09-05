handleResultsDatabaseSeparately <- function(file) {
    
    # create the group_table
    xmlDoc <- xmlTreeParse(file)
    xmltop <<- xmlRoot(xmlDoc)
    node_temp <- getNodeSet(xmltop, "//nct_id")
    assign(xmlName(node_temp[[1]]), xmlValue(node_temp[[1]]), envir = .GlobalEnv)
    xmlNodes <<- c("participant_flow","group", "participants", "participants_list", "milestone", "baseline/measure_list/measure", "baseline/measure_list/measure/category_list", 
        "outcome_list/outcome", "outcome_list/outcome/group_list")
    xmlNodes <<- c("participant_flow")
    for (node in xmlNodes) {
        
        if (node %in% names(other_tables)) {
            if (node == "baseline/measure_list/measure") {
                table_name <- "measure"
            } else {
                table_name <- node
            }
            if (table_name == "baseline/measure_list/measure/category_list") {
                table_name <- "category_details"
            }
            if (table_name == "outcome_list/outcome") {
                table_name <- "outcome"
            }
            if (table_name == "outcome_list/outcome/group_list") {
                table_name <- "outcome_group"
                node <- "outcome_list/outcome"
            }
            
            
            
            nodeAddress <- paste("//", node, sep = "")
            subnode <<- getNodeSet(xmltop, nodeAddress)
            xmlSubNodes <- other_tables[[node]]
            
            counter = 0
            for (node in subnode) {
                counter = counter + 1
                sub_node <<- node
                if (xmlName(sub_node) == "group") {
                  group_id <<- xmlGetAttr(sub_node, "group_id")
                }
                if (xmlName(sub_node) == "participants") {
                  group_id <<- xmlGetAttr(sub_node, "group_id")
                  count <<- xmlGetAttr(sub_node, "count")
                }
                if (xmlName(sub_node) == "milestone") {
                  participant_list_id <<- counter
                }
                if (table_name == "participants_list") {
                  participant_list_id <<- counter
                  children_list <- xmlChildren(node)
                  for (child in children_list) {
                    
                    group_id <<- xmlGetAttr(child, "group_id")
                    count <<- xmlGetAttr(child, "count")
                    
                    xmlSubNodes <- c("nct_id", "group_id", "count", "participant_list_id")
                    
                    char_vect <- sapply(xmlSubNodes, function(x) eval(parse(text = x)))
                    assign(table_name, data.frame(as.list(char_vect)), envir = .GlobalEnv)
                    var_name <- paste(table_name, "temp", sep = "_")
                    # print(var_name)
                    assign(var_name, rbind(eval(parse(text = var_name)), eval(parse(text = table_name))), envir = .GlobalEnv)
                  }
                  participant_list_id <<- participant_list_id + 1
                } else if (table_name == "category_details") {
                  category_list_id <<- counter
                  categories <- xmlChildren(node)
                  # print(length(categories))
                  for (category in categories) {
                    subtitle <- getNodeSet(category, "//sub_title")
                    # print(category)
                    
                    if (length(subtitle) != 0) {
                      # print(xmlValue(subtitle[[1]]))
                      create_cell("sub_titile", subtitle)
                    } else {
                      assign("sub_title", NA, envir = .GlobalEnv)
                    }
                    
                    measurements <- getNodeSet(category, "//measurement_list")
                    measurements <- measurements[[1]]
                    measurements <- xmlChildren(measurements)
                    for (measurement in measurements) {
                      group_id <<- xmlGetAttr(measurement, "group_id")
                      value <<- xmlGetAttr(measurement, "value")
                      if (length(value) == 0) 
                        value <<- NA
                      lower_limit <<- xmlGetAttr(measurement, "lower_limit")
                      if (length(lower_limit) == 0) 
                        lower_limit <<- NA
                      upper_limit <<- xmlGetAttr(measurement, "upper_limit")
                      if (length(upper_limit) == 0) 
                        upper_limit <<- NA
                      xmlSubNodes <- c("nct_id", "category_list_id", "sub_title", "group_id", "value", "lower_limit", 
                        "upper_limit")
                      char_vect <- sapply(xmlSubNodes, function(x) eval(parse(text = x)))
                      assign(table_name, data.frame(as.list(char_vect)), envir = .GlobalEnv)
                      var_name <- paste(table_name, "temp", sep = "_")
                      assign(var_name, rbind(eval(parse(text = var_name)), eval(parse(text = table_name))), envir = .GlobalEnv)
                    }
                  }
                } else if (table_name == "outcome_group") {
                  group_list <- getNodeSet(node, "//group_list")
                  group_list_id <<- counter
                  if (length(group_list) != 0) {
                    
                    group_list <- group_list[[1]]
                    groups <- xmlChildren(group_list)
                    for (group in groups) {
                      group_id <<- xmlGetAttr(group, "group_id")
                      node <- getNodeSet(group, "//title")
                      create_cell("title", node)
                      node <- getNodeSet(group, "//description")
                      create_cell("description", node)
                      xmlSubNodes <- c("nct_id", "group_list_id", "group_id", "title", "description")
                      char_vect <- sapply(xmlSubNodes, function(x) eval(parse(text = x)))
                      print(char_vect)
                      assign(table_name, data.frame(as.list(char_vect)), envir = .GlobalEnv)
                      var_name <- paste(table_name, "temp", sep = "_")
                      assign(var_name, rbind(eval(parse(text = var_name)), eval(parse(text = table_name))), envir = .GlobalEnv)
                    }
                  }
                } else {
                  for (node in xmlSubNodes) {
                    print(counter)
                    nodeName <- node
                    nodeAddress <- paste("//", node, sep = "")
                    node <- getNodeSet(sub_node, nodeAddress)
                    if (!(nodeName %in% c("nct_id", "group_id", "count", "participant_list_id","group_list_id","period_list_id"))) 
                      create_cell(nodeName, node)
                    if (xmlName(sub_node) == "participants") {
                      participant_id <<- counter
                    }
                    if(xmlName(sub_node)=="participant_flow"){
                      group_list_id<<-file_counter
                      period_list_id<<-file_counter
                    }
                  }
                  if (counter == 1) {
                    xmlSubNodes <- append("nct_id", xmlSubNodes)
                  }
                  if (counter == 1 & xmlName(sub_node) == "group") {
                    xmlSubNodes <- append("group_id", xmlSubNodes)
                  }
                  if (counter == 1 & xmlName(sub_node) == "participants") {
                    xmlSubNodes <- append("group_id", xmlSubNodes)
                    xmlSubNodes <- append("count", xmlSubNodes)
                  }
                  if (counter == 1 & xmlName(sub_node) == "milestone") {
                    xmlSubNodes <- append("participant_list_id", xmlSubNodes)
                  }
                  if(counter == 1 & table_name == "participant_flow"){
                    xmlSubNodes <- append("group_list_id", xmlSubNodes)
                    xmlSubNodes <- append("period_list_id", xmlSubNodes)
                  }
                  for (i in 1:length(xmlSubNodes)) {
                    if (grepl("/", xmlSubNodes[i])) {
                      xmlSubNodes[i] <- unlist(strsplit(xmlSubNodes[i], split = "/"))[1]
                    }
                  }
                  
                  char_vect <- sapply(xmlSubNodes, function(x) eval(parse(text = x)))
                  assign(table_name, data.frame(as.list(char_vect)), envir = .GlobalEnv)
                  
                  # print(primary_outcome)
                  var_name <- paste(table_name, "temp", sep = "_")
                  # print(var_name)
                  assign(var_name, rbind(eval(parse(text = var_name)), eval(parse(text = table_name))), envir = .GlobalEnv)
                }
            }
        } else {
            nodeName <- node
            nodeAddress <- paste("//", node, sep = "")
            node <- getNodeSet(xmltop, nodeAddress)
            create_cell(nodeName, node)
        }
    }
} 