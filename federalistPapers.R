# Data Wrangling HW10
# Andromeda Erikson
# 4/3/24

# Use data(federalistPapers, package='syllogi') to get the federalist paper data
# Create a data frame that paper number, author, journal, date
# Determine the day of the week that each paper was published.
# Get the count of papers by day of the week and author
# create a new data frame that has authors as column names and dates of publication as the values

data(federalistPapers, package='syllogi')
library(lubridate)

# Data frame with meta information
federalist <- data.frame()
for (i in 1:length(federalistPapers)){
  federalist <- rbind(federalist, federalistPapers[[i]]$meta)}
  
# Removing title information to just have paper number, author, journal, and date
federalist$title <- NULL

# Creating column for day of week of each paper
federalist$weekday <- sapply(federalist$date, wday, label=T)

# Count of papers by author and day of week
table(data.frame(author = federalist$author, weekday = federalist$weekday), useNA='ifany')

# New dataframe with authors as column names and publication dates as values

authorDate <- tidyr::pivot_wider(federalist[,c('author','date')],
                   names_from='author',
                   values_from = 'date')

names(authorDate) <- c("HAMILTON",             "JAY",                  "MADISON",              "HAMILTON_AND_MADISON", "HAMILTON_OR_MADISON" )

authorDateNew <- data.frame(HAMILTON=na.omit(authorDate$HAMILTON[[1]]))

authorDateNew$JAY = c(na.omit(authorDate$JAY[[1]]), rep(NA, nrow(authorDateNew)-length(na.omit(authorDate$JAY[[1]]))))
authorDateNew$MADISON = c(na.omit(authorDate$MADISON[[1]]), rep(NA, nrow(authorDateNew)-length(na.omit(authorDate$MADISON[[1]]))))
authorDateNew$HAMILTON_AND_MADISON = c(na.omit(authorDate$HAMILTON_AND_MADISON[[1]]), 
                                       rep(NA, nrow(authorDateNew)-length(na.omit(authorDate$HAMILTON_AND_MADISON[[1]]))))
authorDateNew$HAMILTON_OR_MADISON = c(na.omit(authorDate$HAMILTON_OR_MADISON[[1]]), 
                                       rep(NA, nrow(authorDateNew)-length(na.omit(authorDate$HAMILTON_OR_MADISON[[1]]))))

