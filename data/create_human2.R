# Shohreh Kariminezhad
# Data warngling for exercise 5
# link to the data
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# Import data

human1 <- read.table('http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt'
                     , header=T, sep=",")

# Question 

library(dplyr)
names(human1)
head(human1)
dim(human1)
str(human1)

# The dataset 'human' is regarding a dataset with the dimension of (195,9) in which 

# Question 1
# Turning GNI to numeric
# removing the commas and make a numeric version of GNI
library(stringr)
str_replace(human1$GNI, pattern=",", replace ="") %>% as.numeric

# Question 2&3
# Removing the rows with missing values

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human1 <- select(human1, one_of(keep))
complete.cases(human1)

# Question 4&5

tail(human1, 10)
last <- nrow(human1) - 7
human1_ <- human1[1:last, ]
rownames(human1) <- human1$Country
human1_ <- select(human1, -Country)
