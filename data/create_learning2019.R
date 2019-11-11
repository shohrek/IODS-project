# Shohreh, UEF, 2019, Exercise II

# reading the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Checking the dimensions of the data
DimData <- dim(lrn14)

# Access the dplyr library
# library(dplyr)


# Deep <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
# Surf <- c("SU02", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08","SU16",  "SU24", "SU32")

Deep <- (lrn14$D03 + lrn14$D11 + lrn14$D19 + lrn14$D27 + lrn14$D07 + lrn14$D14 + lrn14$D22 + lrn14$D30 + lrn14$D06 + lrn14$D15+ lrn14$D15+ lrn14$D23+ lrn14$D31)/12
Surf <- (lrn14$SU02 + lrn14$SU18 + lrn14$SU26 + lrn14$SU05 + lrn14$SU13 + lrn14$SU21 + lrn14$SU29 + lrn14$SU08 + lrn14$SU16 + lrn14$SU24+ lrn14$SU32)/11
Stra <- (lrn14$ST04 + lrn14$ST12 + lrn14$ST20 + lrn14$ST28 + lrn14$ST01 + lrn14$ST09 + lrn14$ST17 + lrn14$ST25)/8 
Gender <- lrn14$gender
Age <- lrn14$Age
Attitude <- lrn14$Attitude
points <- lrn14$Points

Questions <- cbind(Deep,Surf,Stra,Gender,Age,Attitude,points)
Questions

Questions[Questions==0] <- NA
Questions2 <- Questions[complete.cases(Questions),]
# Deep <- lrn14$Deep
# Stra <- lrn14$Stra
# Surf <- lrn14$Surf
write.csv(Questions2, file = "data.csv", quote = TRUE, row.names = F)


#Data Analysing
##Reading the data
dataset <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)
summary(dataset)

#
model1 <- lm(points ~ Attitude + Age)
summary(model1)
layout(matrix(c(1,2,3,4),2,2))
plot(model1)
