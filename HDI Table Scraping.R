library('rvest')
library('magrittr')

HDI_Calendar_CourseNames <- character()
HDI_Calendar_Locations <- character()
HDI_Calendar_Dates <- character()


#loop through all possible pages
for(i in 1:2) {
  
  #Read html page
  HDI_Calendar_Page <- paste("https://www.thinkhdi.com/education/calendar.aspx?pg=", i, sep="") %>%
    read_html()
  
  #get vector of course names from page
  HDI_Calendar_CourseNames <- HDI_Calendar_Page %>%
    html_nodes(".CourseSchedule-CourseLink") %>%
    html_text() %>%
    append(HDI_Calendar_CourseNames, .)
  
  
  #get vector of dates.
  HDI_Calendar_Dates <- HDI_Calendar_Page %>%
    html_nodes(".CourseSchedule-lightbox-dates span") %>%
    html_text() %>%
    append(HDI_Calendar_Dates, .)
  
  #get vector of locations
  HDI_Calendar_Locations <- HDI_Calendar_Page %>%
    html_nodes(".CourseList-Item:not(.CourseSchedule-Register) > span  ") %>%
    html_text() %>%
    append(HDI_Calendar_Locations, .)
  
}

#Split dates into start and end
HDI_Calendar_Dates_Start <- HDI_Calendar_Dates[c(TRUE, FALSE)]
HDI_Calendar_Dates_END <- HDI_Calendar_Dates[c(FALSE, TRUE)]

#Get locations from matrix
HDI_Calendar_City <- HDI_Calendar_Locations[c(FALSE, FALSE, TRUE, FALSE)]
HDI_Calendar_State <- HDI_Calendar_Locations[c(FALSE, FALSE, FALSE, TRUE)]