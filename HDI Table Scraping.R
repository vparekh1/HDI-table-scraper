library('revest')

#loop through all possible pages
for(i in 1:2) {
  
  #Read html page
  HDI_Calendar_page <- paste("https://www.thinkhdi.com/education/calendar.aspx?pg=", i, sep="") %>%
    read_html()
  
  #get vector of course names from page
  HDI_Calendar_CourseNames
  HDI_Calendar_CourseNames <- HDI_Calendar_page %>%
    html_nodes(".CourseSchedule-CourseLink") %>%
    html_text() %>%
    append(HDI_Calendar_CourseNames)

}

