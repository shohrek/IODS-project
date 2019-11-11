# Shohreh, UEF, 2019, Exercise II

# use ?read.csv to read the file. We also added the argument header=TRUE to have the headers 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Check the dimensions of the data

DimData <- dim(lrn14) # the result shows the dimension of the data is (183,60)


# Check the dimensions of the data 

str(lrn14) # the structure of the variables are integer exept for the variable 'gender' which is a factor variable


# Deep <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
# Surf <- c("SU02", "SU18", "SU26", "SU05", "SU13", "SU21", "SU29", "SU08","SU16",  "SU24", "SU32")

deep <- (lrn14$D03 + lrn14$D11 + lrn14$D19 + lrn14$D27 + lrn14$D07 + lrn14$D14 + lrn14$D22 + lrn14$D30 + lrn14$D06 + lrn14$D15+ lrn14$D15+ lrn14$D23+ lrn14$D31)/12
surf <- (lrn14$SU02 + lrn14$SU18 + lrn14$SU26 + lrn14$SU05 + lrn14$SU13 + lrn14$SU21 + lrn14$SU29 + lrn14$SU08 + lrn14$SU16 + lrn14$SU24+ lrn14$SU32)/11
stra <- (lrn14$ST04 + lrn14$ST12 + lrn14$ST20 + lrn14$ST28 + lrn14$ST01 + lrn14$ST09 + lrn14$ST17 + lrn14$ST25)/8 
gender <- lrn14$gender
age <- lrn14$Age
attitude <- lrn14$Attitude
points <- lrn14$Points

dataset1 <- cbind(deep,surf,stra,gender,age,attitude,points)
dataset1

dataset1[points==0] <- NA
dataset2 <- dataset1[complete.cases(dataset1),]
write.csv(dataset2, file = "data.csv", quote = TRUE, row.names = F)


# Data Analysing

# dataset <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)

dim(dataset2) # the dimension of the dataset is (166,7)
summary(dataset2)  

# the summary of the dataset reveal the minimum, mean, 1st Qu, median, mean, 3rd Qu and maximum of the data. Using the hist function we can also
# observe the distribution of the variables. For instance, variable 'stra' is a normally ditributed (mean = 3.121, min = 1.25, max= 5) 
# while the variable 'Age' is skewed (mean = 25.51, min = 17, max= 55). 


# check the  ditribution of the variables using the hist function
layout(matrix(c(1,2,3,4,5,6),3,2))
hist(age)  # the variable 'age' is skewed
hist(attitude)  # the variable 'attitude' is normal
hist(deep) 
hist(stra)  
hist(surf)  
hist(points)

# we can also use the cor.test function to assess the correlation between the variables
# check the correlation between the variables 
cor.test(attitude, age)
# for example, the results checking the correlation between the age and attitude reveal that the correlation between these two variables is 
# not significant
# 

# we check the relationship between the output 'points' and two input variables 'attitude' and 'age'
model1 <- lm(points ~ attitude + age)
summary(model1)
# after checking the model we produce the diagnostic plots 
layout(matrix(c(1,2,3,4),2,2))
plot(model1)


# after we see that the input 'age' has no statistically significant relationship with the output, we 
# remove it and refit the model
model2 <- lm(points ~ attitude)
summary(model2)
# after checking the model we produce the diagnostic plots 
layout(matrix(c(1,2,3,4),2,2))
plot(model2)
