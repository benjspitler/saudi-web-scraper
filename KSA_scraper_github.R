library(tidyverse)
library(rvest)

# Crawls through HTML on the first page of results for the search term "??????" and returns all matching titles:
list1 <- read_html("https://www.spa.gov.sa/ajax/search.php?searchbody=1&search=%D8%AD%D9%83%D9%85&cat=0&cabinet=0&royal=0&lang=ar&pg=1&pg=1") %>% html_nodes(".h2NewsTitle") %>% html_text()
  
# Crawls through same HTML and returns corresponding URLs:
list2 <- read_html("https://www.spa.gov.sa/ajax/search.php?searchbody=1&search=%D8%AD%D9%83%D9%85&cat=0&cabinet=0&royal=0&lang=ar&pg=1&pg=1") %>% html_nodes(".aNewsTitle") %>% html_attr("href")
    
# Returns indices of all list1 elements containing the word "??????????", which appears only in execution announcements:
grep_list <- grep("??????????", list1)
      
# Creates blank list:
link_list <- vector("list", length(grep_list))
        
# Populates blank list with URLs corresponding to titles of execution announcements in grep_list:
for (i in grep_list){
link_list[i] <- paste("https://www.spa.gov.sa", list2[i], sep = "")}
        
# Removes null values:
link_list = link_list[-which(sapply(link_list, is.null))]
          
# Creates data frame and exports to .csv file:
link_df <- as.data.frame(link_list)
link_df <- t(link_df)
write.csv(link_df,"C:/Users/benpi/OneDrive/Documents/R/ksa_executions.csv", row.names = FALSE)