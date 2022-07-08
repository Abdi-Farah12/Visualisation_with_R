# Objective is two-fold

# 1. analyse the BMI of the primary holders, focusing on:
    #a. measures of tendency
    #b. measures of variability
    #c. normality

# 2. Investigate the correlation between the BMI and the amount I4U charges each
     # customer. Take a note of the correlation between these variables and what other variables I4U might use ascorrelation with charges.

# 1. Import packages
library(tidyverse)
library(moments)
library(BSDA)

# import and sense check data
health <- read.csv(file.choose(), header=TRUE)
as_tibble(health)
View(health)

summary(health)

# 1.a: Measure the central tendancies

mean(health$bmi)
median(health$bmi)

# Mean and Median are very similiar suggesting the data is tighlty distributed

# 1.a Measures statistics of extreme values

min(health$bmi)
max(health$bmi)

# 1.b Measure statistics of variability in the BMI column

# range
max(health$bmi) - min(health$bmi)

# Q1 (quartile 1)
quantile(health$bmi, 0.25)

# Q3 (quartile 3)
quantile(health$bmi, 0.75)

# IQR(inter quartile range)
IQR(health$bmi)

# variance
var(health$bmi)

# standard deviation
sd(health$bmi)

# 1.c Check for normality
# check for normality using qqnorm and qqline

qqnorm(health$bmi, col = 'blue', xlab= 'z Value', ylab= 'BMI')
qqline(health$bmi, col = 'red', lwd = 2)

# the result shows the the data points are roughly following in the reference line

shapiro.test(health$bmi)

# The p-value is 2.605e-05 meaning that the data is not normally distributed
# but according to the solution provided 2.605e-05 means that the p value is higher than 0.5 so data is normally distributed

# Check for kurtosis and skewness

kurtosis(health$bmi)
skewness(health$bmi)

# The kurtosis is 2.94 which is very slightly under 3. thus the data is just about platykurtic,
# and will produce less extreme outliers

# Skewness is 0.28 and as such is slightly right skewed


# 2. Check for correlation between the amount I4U charges and the bmi

# correlation between bmi and charges
cor(health$bmi, health$charges)
# at 0.198 there is a very weak positive correlation. This much closer to 0 than 1 so we assume that there is no correlation

# correlation between age and charges
cor(health$age, health$charges)
# Again there is a quite a weak positive correlation between agae and charges


# Practical: Choosing the right graphs




# 4.smoker and sex -----> segmented bar chart/ faceted pie chart
# 5. BMI and sex -------> side by side boxplot/violinbplot
# 6. BMI and region ------> scatter plot/ bar chart (mean)
# 7. BMI and smoker -------- side by side boxplot
# 8. smoker and charges ------ mean bar chart/ side by side box plot


# Clean the dataset
#Round to 2 decimal places

health <- health %>%                   # Using dplyr functions
  mutate_if(is.numeric,
            round,
            digits = 2)

# 1. age ------ univariate graph: Histogram

ggplot(data = health,
       mapping = aes(x = age)) +
  geom_histogram(fill = 'red',
                 color = 'black',
                 bins= 10) + 
  labs(title = 'Distribution of age',
       y = 'Frequency')


# 2. children ---- univarite: (familysize) -> Histogram

ggplot(data = health,
       mapping = aes(x = children, y = ..count.. / sum(..count..))) +
  geom_bar(fill = 'light blue',
          color = 'black') +
  labs(x = "Number of childen by client",
       y = "Percent",
       title = 'Percentage of clients by number of children',
       y = 'Frequency') +
  scale_y_continuous (label = scales::percent) +
  scale_x_continuous(breaks = seq(0,5,1)) +
  labs (x = "Marital status",
       y = "Percent",
       title = "Individuals by marital status")
  

# 3. region and sex ---- bivariate ---- -> stacked bar chart/ segmented bar chart/ grouped bar chart

ggplot(data = health,
       mapping = aes(x= region, fill = sex)) + 
  geom_bar(position = 'fill') +
  labs(title = 'Sex by region',
       y = 'Percent') +
  scale_y_continuous(label = scales::percent)

# 4.smoker and sex -----> segmented bar chart/ faceted pie chart

ggplot(data = health,
       mapping = aes(x= sex, fill = smoker)) + 
  geom_bar(position = 'dodge') +
  labs(title = 'Sex by region',
       y = 'Percent') +
  scale_y_continuous(label = scales::percent)

###### Solutions

# The plots below are suggestions and other plots may work better for you!
# Plot age on a histogram
ggplot (health, aes (x = age)) +
  geom_histogram (stat = "count")

# Plot children on a histogram
ggplot (health, aes (x = children)) +
  geom_histogram (stat = "count")

# Plot region and sex on a stacked bar chart
ggplot(health,
       aes(x = region,
           fill = sex)) +
  geom_bar()

# Plot smoker and sex on a grouped bar chart
ggplot(health,
       aes(x = smoker,
           fill = sex)) +
  geom_bar(position = "dodge")

# Plot BMI and sex on a side-by-side boxplot 
ggplot(health,
       aes(x = sex,
           y = bmi)) +
  geom_boxplot()

# Plot BMI and region on a side-by-side violin plot
ggplot(health,
       aes(x = region,
           y = bmi)) +
  geom_violin()

# Plot BMI and smoker on a side-by-side boxplot
ggplot(health,
       aes(x = smoker,
           y = bmi)) +
  geom_boxplot()

# Select two plots to add colour, titles, and labels
ggplot(health,
       aes(x = smoker,
           y = bmi)) +
  geom_boxplot(fill = "green",
               notch = TRUE,
               outlier.color = "blue") +
  
  ggplot(health,
         aes(x = smoker,
             fill = sex)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("purple", 'orange')) +
  labs(title = "Count of male and female smokers")

# Select two plots and and add a suitable theme.
# For a website
ggplot(health,
       aes(x = region,
           y = bmi)) +
  geom_violin() +
  theme_dark()

# For a publication
ggplot(health,
       aes(x = region,
           fill = sex)) +
  geom_bar() +
  theme_classic()


