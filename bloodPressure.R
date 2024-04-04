# Data Wrangling HW10
# Andromeda Erikson
# 4/3/24

# Download and read in the bloodPressure.RDS file
# each row is a person
# blood pressure is measure with two values: systolic and diastolic
# each persons blood pressure was measured every day for a month
# reshape the data to only have 4 columns: person, date, systolic/diastolic, and the value
# fix the date to be in the nice format for R
# calculate the mean diastolic and the mean systolic by the days of the week

path = "~/Desktop/university/SPRING 2024/Data wrangling/Assignment 10"
bloodPressure <- readRDS(file=file.path(path, "bloodPressure.RDS"))
library(lubridate)

# Reshaping 
bloodPressureNew <- reshape(data=bloodPressure,
              direction='long', 
              varying=colnames(bloodPressure)[-1], 
              v.names='bloodPressure', 
              timevar='date', 
              times=colnames(bloodPressure)[-1], 
              idvar='person',
)

# Removing redundant information
rownames(bloodPressureNew) <- NULL

# Splitting date and systolic/diastolic into two columns 
x = unlist(strsplit(bloodPressureNew$date, split=" "))
bloodPressureNew$sORd <- x[seq(1, length(x), by=2)]
bloodPressureNew$date <- x[seq(2, length(x), by=2)]

# Fixing date format
bloodPressureNew$date <- ymd(bloodPressureNew$date)

# Adding day of week
bloodPressureNew$wDay <- wday(bloodPressureNew$date, label=T)

# The mean diastolic and the mean systolic by the days of the week
aggregate(bloodPressure ~ sORd + wDay, data=bloodPressureNew, FUN=mean)


