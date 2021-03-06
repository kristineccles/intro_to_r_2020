#############################################################
# Exercise 1 - Introduction to R 
# By: Kristin Eccles
# Written in R 3.5.0

#############################################################
# Load Libraries
# Requires athe ggplot2 package that is not part of base installation
# To install the package, uncomment the following line
# install.packages("ggplot2", dependencies=TRUE)
library(ggplot2)

# Load data
sturgeon= read.csv("sturgeon.csv")

getwd()
setwd("/Users/kristineccles/Desktop/intro_to_r")

#############################################################
sturgeon
# Check to see if we have emissing data
is.na(sturgeon)

# Summarize the contents of the sturgeon dataframe
summary(sturgeon)
# you will also see missing data in this summary 

# Clean the data if necessary
# if we had missing data we can remove 
# create new dataset without missing data 
sturgeon_complete <- na.omit(sturgeon)
summary(sturgeon_complete)


#############################################################
# Visualize the data 
# Make a histogram of the variable fklngth in the sturgeon
# this uses the base R plotting 
hist(sturgeon$fklngth)

# Make variables in the sturgeon data.frame directly callable by attaching
attach(sturgeon)

# Redo the same histogram as before
ls()
hist(fklngth)

# use "sturgeon" dataframe to make plot called mygraph
# and define x axis as representing fklngth

plot1 <- ggplot(sturgeon) +
  geom_histogram(aes(x = fklngth, y = ..density..),
                 binwidth = 1, fill = "blue", color = "black")
plot1
# Try changing the binwidth- what happens?

# Data distribution fklngth by subsets of sex and year
# split previous graph per year (rows) and sex (columns)
plot2 <- ggplot(sturgeon) +
  geom_histogram(aes(x = fklngth, y = ..density..),
                 binwidth = 5, fill = "grey", color = "black")+
  facet_grid(sex ~ year)
plot2

# QQ plot de fklngth
qqnorm(fklngth)
qqline(fklngth)
# Are there outliers?

# Wilks-Shapiro test of normality on fklngth
shapiro.test(fklngth)

# Boxplot of fklngth by sex, with whiskers
# base graphics
boxplot(fklngth ~ sex, notch = TRUE)

#ggplot2 version
plot3<-ggplot(sturgeon, aes(x=sex, y=fklngth))
plot3+ geom_boxplot()

# Scatterplot of fklngth as a function of age
# base graphics
plot(fklngth ~ age)

#ggplot2 version
plot4<-ggplot(sturgeon, aes(x=age, y=fklngth))
plot4+ geom_point(size=5, shape=22, color="blue")


# Matrix of scatterplots of all pairs of variables in dataframe sturgeon, with lowess trace
pairs(sturgeon, panel = panel.smooth)

# Create a subset with only females captured in 1978
sturgeon.female.1978 <- subset(sturgeon, sex == "FEMALE" &
                                 year == "1978")

# Create a histogram of fklngth from a subset for females in 1979 and 1980
mysubset = subset(sturgeon, sex == "FEMALE" & (year == "1979" | year == "1980"))
hist(mysubset$fklngth)

