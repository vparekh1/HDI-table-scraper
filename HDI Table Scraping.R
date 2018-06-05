library('rvest')
library('magrittr')
library('xml2')

HDI_Calendar_CourseNames <- character()
HDI_Calendar_Data <- character()


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
  
  
  # #get vector containing location and start and end dates
  # HDI_Calendar_Dates <- HDI_Calendar_Page %>%
  #   html_nodes(".CourseSchedule-lightbox-dates span") %>%
  #   html_text() %>%
  #   append(HDI_Calendar_Dates, .)
  
  #get vector containing location and start and end dates
  #need the :not selector to avoid picking up the pop-up windows
  HDI_Calendar_Data <- HDI_Calendar_Page %>%
    html_nodes(".CourseList-Item:not(.CourseSchedule-Register) > span  ") %>%
    html_text() %>%
    append(HDI_Calendar_Data, .)

}

#parse vector into start and end dates
HDI_Calendar_Dates_Start <- HDI_Calendar_Data[c(TRUE, FALSE, FALSE, FALSE)]
HDI_Calendar_Dates_END <- HDI_Calendar_Data[c(FALSE, TRUE, FALSE, FALSE)]

#parse vector into city and state
HDI_Calendar_City <- HDI_Calendar_Data[c(FALSE, FALSE, TRUE, FALSE)]
HDI_Calendar_State <- HDI_Calendar_Data[c(FALSE, FALSE, FALSE, TRUE)]

#create data frame
HDI_Calendar.df <- data.frame(Course_Name = HDI_Calendar_CourseNames,
                              Start_Date = HDI_Calendar_Dates_Start, 
                              End_Date = HDI_Calendar_Dates_END, 
                              City = HDI_Calendar_City,
                              State = HDI_Calendar_State)
