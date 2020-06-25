##Peloton scripts
library(dplyr)

## Load data
peloton <- read.csv("CourseraWork/pizza2watts_workouts.csv")

cycling_classes <- peloton %>%
  filter(Fitness.Discipline == "Cycling")%>%
  filter(!grepl("*Just Ride", Title) & !grepl("*Scenic*", Title))

cycling_instructors <- cycling_classes%>%
  select(Instructor.Name)

unique_cycling_instructors <- cycling_instructors %>%
  unique()

## Summarize cycling classes, filtering out anything 10 min or less
od_live_summary <- cycling_classes %>%
  filter(Length..minutes. >= 10 & Avg..Watts >= 10)%>%
  group_by(Live.On.Demand)%>%
  summarize(avg_pwr = mean(Avg..Watts),
            n_classes = n()
  )
od_live_summary

instr_summary <- cycling_classes %>%
  filter(Length..minutes. >= 10)%>%
  group_by(Instructor.Name)%>%
  summarize(avg_pwr = mean(Avg..Heartrate),
            n_classes = n()
  )

length_summary <- cycling_classes %>%
  filter(Avg..Watts >= 10)%>%
  group_by(Length..minutes.)%>%
  summarize(avg_pwr = mean(Avg..Watts),
            n_classes = n()
  )
length_summary

jr_summary <- peloton %>%
  filter(grepl("*Just Ride", Title))%>%
  filter(Length..minutes. >= 10)%>%
  #group_by(Instructor.Name)%>%
  summarize(avg_pwr = mean(Avg..Watts),
            n_classes = n()
  )
