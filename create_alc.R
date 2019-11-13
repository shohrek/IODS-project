# Shohreh, UEF, 2019, Exercise III
# data source: https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

setwd('E:/PhD/Courses/Open Data/IODS-project/data')

studentmat <- read.csv('E:/PhD/Courses/Open Data/IODS-project/data/student-mat.csv', header=T, sep=";", row.names=NULL)
colnames(studentmat)
dim(studentmat) # the dimension of this dataset is (395,33)


studentpor <- read.csv('E:/PhD/Courses/Open Data/IODS-project/data/student-por.csv', header=T, sep=";",row.names=NULL)
colnames(studentpor)
dim(studentpor) # the dimension of this dataset is (649,33)

# joining the variables in two datasets
install.packages("dplyr")
library(dplyr)
# merging the datasets 
# total <- merge(studentmat,studentpor,by=c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet"))
# dim(total)
# the dimension of the 'total' dataset is (382,53)
# colnames(total)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(studentmat, studentpor, by = join_by, suffix = c(".math", ".por"))

colnames(math_por) #new column names

glimpse(math_por) 


## 5
# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(studentmat)[!colnames(studentmat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

## 6
install.packages("ggplot2")
library(dplyr); 

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(alc, aes(high_use))

# draw a bar plot of high_use by sex
g2 + facet_wrap("sex") + geom_bar()

glimpse(alc) # the dimension of the modified dataset is (382,35) 
#
write.csv(alc, file = "dataIII.csv", quote = TRUE, row.names = F)


