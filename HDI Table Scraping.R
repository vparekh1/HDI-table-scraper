library('rvest')
library('magrittr')

HDI_Calendar_CourseNames <- character()
HDI_Calendar_Locations <- character()

#loop through all possible pages
for(i in 1:2) {
  
  #Read html page
  HDI_Calendar_Page <- paste("https://www.thinkhdi.com/education/calendar.aspx?pg=", i, sep="") %>%
    read_html()
  
  #get vector of course names from page
  HDI_Calendar_CourseNames <- HDI_Calendar_Page %>%
    html_nodes(".CourseSchedule-CourseLink") %>%
    html_text() %>%
    append(HDI_Calendar_CourseNames)
  
  #get vector of locations
  HDI_Calendar_Locations <- HDI_Calendar_Page %>%
    html_nodes("br+span") %>%
    html_text() %>%
    append(HDI_Calendar_Locations)

}
