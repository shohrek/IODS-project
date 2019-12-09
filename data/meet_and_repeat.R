## Data Wrangling

# BRPS dataset

# an experiment on 40 male assessing brief pschyatric rating scale before treatment and 
# after that for 8 weeks
library(tidyr); library(dplyr);library(ggplot2)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  ="\t", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# print out summaries of the variables

summary(BPRS)

glimpse(BPRS)


# rats dataset

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Look at the (column) names of rats
names(rats)

# Look at the structure of rats
str(rats)

# print out summaries of the variables
summary(rats)

glimpse(BPRS)

# converting categorical to factor variables
# BPRS
BPRS <- within(BPRS, {
  treatment <- factor(BPRS$treatment)
  subject <- factor(BPRS$subject)
})

glimpse(BPRS)

# rats
rats <- within(rats, {
  ID <- factor(ID)
  Group <- factor(Group)
})

glimpse(rats)


# converting to long formats
# BPRS

BPRSL <- gather(BPRS, key = weeks, value = bprs, week0:week8) %>%
  mutate(week = as.integer(substr(weeks, 5, 5)))

glimpse(BPRSL)

# rats

ratsL <- gather(rats, key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

glimpse(ratsL)


# recheking the datasets with long format
# BPRSL

names(BPRSL)

str(BPRSL)

summary(BPRSL)

glimpse(BPRS)

# ratsL

names(ratsL)

str(ratsL)

summary(ratsL)

glimpse(ratsL)

# writing the csv files
write.csv(BPRSL, file = 'E:/PhD/Courses/Open Data/IODS-project/BPRSL.csv')
write.csv(ratsL, file = 'E:/PhD/Courses/Open Data/IODS-project/ratsL.csv')


