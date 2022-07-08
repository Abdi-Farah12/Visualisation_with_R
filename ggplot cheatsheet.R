library(ggplot2)

wages <- read.csv(file.choose(), header = TRUE)

View(wages)

# qplots are quick plots and create fast and quick basic plots

# quick histogram
qplot(wage, data = wages)

# quick bar chary
qplot(marital, data = wages)

# quick scatter plot
qplot(age,wage, data = wages)

#  density plot/ similiar to a histogram (basic)
ggplot(wages, aes(x = wage)) + geom_density()

# scatter plot (basic)
ggplot(wages, aes(x = age, y = wage)) + geom_point()

# scatter plot with jitter to space out the points
ggplot(wages, aes(x = jitter(age), y = wage)) + geom_point()

# scatter plot with a smooth lm (linear regression line). not ideal here
ggplot(wages, aes(x = age, y = wage)) + geom_point() + geom_smooth(method = lm)

# smooth scatter plot without the lm
ggplot(wages, aes(x = age, y = wage)) + geom_point() + geom_smooth()

# scatter plot using a thirD variable to highlight points in colour
ggplot(wages, aes(x = age, y = wage, col = job_class)) + geom_point() + geom_smooth()

# scatter plot with with the error shading turned off
ggplot(wages, aes(x = age, y = wage, col = job_class)) + geom_point() + geom_smooth(se = FALSE)

# a smooth chart without the scatter plot points
ggplot(wages, aes(x = age, y = wage, col = job_class)) + geom_smooth()

# basic bar chart using ggplot
ggplot(wages, aes(x = marital)) + geom_bar()

# stacked bar plot created by adding another variabel with the fill function
ggplot(wages, aes(x = marital, fill = education)) + geom_bar()

# same bar plot by with side-by-side bars rather than stacked
ggplot(wages, aes(x = marital, fill = education)) + geom_bar(position = 'dodge')

# setting a title using ggtitle
ggplot(wages, aes(x = marital, fill = education)) + geom_bar(position = 'dodge') +
  ggtitle('Customer education level by marital status')

# change plot theme to classic
ggplot(wages, aes(x = age, y = wage, col = job_class)) + geom_point()+ geom_smooth() +
  theme_classic()

#change plot theme to dark  
ggplot(wages, aes(x = age, y = wage, col = job_class)) + geom_point()+ geom_smooth() +
  theme_dark()

# change line width using lwd
ggplot(wages, aes(x = age, y = wage, col = job_class)) + geom_point()+ geom_smooth(lwd = 2, se = FALSE) +
  theme_classic()

# smooth plot without error shading
ggplot(wages, aes(x = age, y = wage, col = education)) + geom_smooth(se = FALSE)


                 ##Demonstration: Exploring data in R (ggplot)

# 2. build plot
ggplot (data = wages,  # [1a] Set the data source.
        mapping = aes(x = age, y = wage))  # [1b] Add mapping elements.

# 3. Add geoms

ggplot (data = wages, 
        mapping = aes(x = age, y = wage))  +
  geom_point()

# 4. Create a scatterplot

# lets first remove the outliers
wages.new <- filter(wages, wage  <300)

# [1] Specify the ggplot function and [2] the geom_point function:  

ggplot(data = wages.new,  # [1a] Set data source.
       mapping = aes(x = age, y = wage)) +  # [1b] Add mapping element.
  geom_point(color = "red", # [2a] Set the colour to red.
             alpha = 0.5,  # [2b] Set the alpha transparency to 0.5.
             size = 3)  # [2c] Set the point size to 3.


#5. Add a smoothing line

ggplot(data = wages.new,
       mapping = aes(x = age, y = wage)) +
  geom_point(color = "red",
             alpha = .5,
             size = 3) +  # Note: A plus symbol adds another layer to our plot.
  geom_smooth(method = "lm")  # [1] Add the line-of-best-fit to the plot.


#6. Group variables

# [1] Run the ggplot function: 

ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +  # [2] Specify 'color'.
  geom_point(alpha = .5,
             size = 3) +  # [3] Remove colour argument.
  geom_smooth(method = "lm",
              se = FALSE,  
              size = 1.5)  # [4] Add lines-of-best-fit, remove the confidence intervals, and set the size.

# 7. Add scales

# [1] Run the ggplot function: 
ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +  
  geom_point(alpha = .5,
             size = 3) +  
  geom_smooth(method = "lm",
              se = FALSE,  
              size = 1.5) +
  scale_x_continuous(breaks = seq(0,90,5)) + # [2] Add a scale layer for x.
  scale_y_continuous(breaks = seq(0,350,50)) # [3] Add a scale layer for y.
  
# [1] Run the ggplot function:

ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +
  geom_point(alpha = .5,
             size = 3) +
  geom_smooth(method = "lm",
              se = FALSE,
              size = 1.5) +
  scale_x_continuous (breaks = seq(0, 90, 5), "Age of the Individual") +  # [2] Add argument/title (x).
  scale_y_continuous(breaks = seq(0, 350, 50), "Wage in $1000s") +  # [3] Add argument/title (y).
  scale_color_manual(values = c("red", "blue", "green", "orange", "yellow"))  # [4] Add layer (colours).

# 8. Create faceted plots

ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +
  geom_point(alpha = .5,
             size = 3) +
  geom_smooth(method = "lm",
              se = FALSE,
              size = 1.5) +
  scale_x_continuous (breaks = seq(0, 90, 5), "Age of the Individual") +  # [2] Add argument/title (x).
  scale_y_continuous(breaks = seq(0, 350, 50), "Wage in $1000s") +  # [3] Add argument/title (y).
  scale_color_manual(values = c("red", "blue", "green", "orange", "yellow")) + # [4] Add layer (colours).
  facet_wrap(~job_class) # [2] Add a facet layer. 

# 9. Add labels

ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +
  geom_point(alpha = .5,
             size = 3) +
  geom_smooth(method = "lm",
              se = FALSE,
              size = 1.5) +
  scale_x_continuous (breaks = seq(0, 90, 5), "Age of the Individual") +  # [2] Add argument/title (x).
  scale_y_continuous(breaks = seq(0, 350, 50), "Wage in $1000s") +  # [3] Add argument/title (y).
  scale_color_manual(values = c("red", "blue", "green", "orange", "yellow")) + # [4] Add layer (colours).
  facet_wrap(~job_class) +# [2] Add a facet layer.
  labs(title = "Relationship between wages and age", 
       subtitle = "Survey from the mid-Atlantic region, USA",
       caption = "Source: US govt data")# [4] Add labels for title, subtitle, and caption.



# [1] Run the ggplot function: 

ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +
  geom_point(alpha = .5,
             size = 3) +
  geom_smooth(method = "lm",
              se = FALSE,
              size = 1.5) + 
  scale_x_continuous (breaks = seq(0, 90, 5)) +
  scale_y_continuous(breaks = seq(0, 350, 50)) +
  scale_color_manual(values = c("red", "blue", "green", "orange", "yellow")) +
  facet_wrap(~job_class) +
  labs(title = "Relationship between wages and age",
       subtitle = "Survey from the mid-Atlantic region, USA",
       caption = "Source: US govt data",
       x = "Individuals' Age",
       y = "Wage in $ (x1000)",
       color = "Education Level"
  )  # [3] Add labels to labs function.


# 10. Customise the theme

ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education)) +
  geom_point(alpha = .5,
             size = 3) +
  geom_smooth(method = "lm",
              se = FALSE,
              size = 1.5) + 
  scale_x_continuous (breaks = seq(0, 90, 5)) +
  scale_y_continuous(breaks = seq(0, 350, 50)) +
  scale_color_manual(values = c("red", "blue", "green", "orange", "yellow")) +
  facet_wrap(~job_class) +
  labs(title = "Relationship between wages and age",
       subtitle = "Survey from the mid-Atlantic region, USA",
       caption = "Source: US govt data",
       x = "Individuals' Age",
       y = "Wage in $ (x1000)",
       color = "Education Level") +
  theme_grey()# [3] Add labels to labs function.

######## Univariate Graphs

#We’ll begin with focusing on univariate graphs – graphs that plot the distribution 
#of a single variable. The variable can be:
  
#a) categorical data (such as gender or ethnicity)
#b) quantitative or continuous data (such as age or height).

####### 1. Categorical data

# 1. create a df with outliers above 300 removed
new_wages = filter(wages, wage <300)

# 2. Plot the distribution
ggplot(data = new_wages,
       mapping = aes(x= marital)) +
         geom_histogram(stat = 'count' )


# 3. Add attributes
# [1] Specify the ggplot function:  

ggplot (new_wages, aes (x = maritl)) +
  geom_histogram (fill = "red",
                  color = "black",
                  stat = "count") +  # [2] Add fill, colour, and a statistic.  
  labs (x = "Marital status",
        y = "Frequency",
        title = "Individuals by marital status")  # [3] Add the labs function for labels.  


# 4. Visualise the percentages


# [1] Specify the ggplot function:  

ggplot (new_wages, 
        aes (x = marital, 
             y = ..count.. / sum(..count..))) +  # [1] Specify 'y' to create a percentage. 
  geom_histogram (fill = "red",
                  color = "black",
                  stat = "count") +  # [2] Specify attributes.
  labs (x = "Marital status",
        y = "Percent",
        title = "Individuals by marital status") +  # [3] Specify titles.
  scale_y_continuous (label = scales::percent)  # [4] Pass labels to the scale. 

# 5. Flip axis

ggplot (new_wages, 
        aes (x = marital, 
             y = ..count.. / sum(..count..))) +  # [1] Specify 'y' to create a percentage. 
  geom_histogram (fill = "red",
                  color = "black",
                  stat = "count") +  # [2] Specify attributes.
  labs (x = "Marital status",
        y = "Percent",
        title = "Individuals by marital status") +  # [3] Specify titles.
  scale_y_continuous (label = scales::percent) +  # [4] Pass labels to the scale.
  coord_flip() # [1] Flip the x-axis and y-axis.


########### 2. Quantitative data


# [1] Specify the ggplot function:

ggplot (new_wages, aes(x = age)) +
  geom_density() +  # [2] Specify the geom_density.
  labs (title = "Participants by age")  # [3] Specify title.

# 2. Add colour

ggplot (new_wages, aes(x = age)) +
  geom_density(fill = 'red',
               bw = 1) +  # [2] Specify the geom_density.
  labs (title = "Participants by age")  # [3] Specify title.


############ Bivariate and multivariate graphs

#If we want to see the relationship between two or more variables, 
#as opposed to the nature of a single variable, we use bivariate graphs or 
#multivariate graphs. As with univariate graphs, our choice of graph depends 
#on the nature of the variables we choose to compare:

#a) quantitative versus quantitative

#b) categorical versus categorical

#c) categorical versus quantitative

######## 1. Comparing categorical variables

#To compare categorical variables, we can use:
  
#a) stacked bar charts
#b) grouped bar charts
#c) segmented bar charts.


# 1. Stack bar chart

# [1] Specify the ggplot function; [1a] set data source and [1b] set and pass x: 

ggplot(new_wages,
       aes(x = education,
           fill = jobclass)) +  
  geom_bar()  # [2] Specify the geom_bar function. 

# 2. Segmented bar charts

# we use the same code as stack bar but add position = fill and y-axis title 'Proportion,

# [1] Specify the ggplot function; [1a] set data source and [1b] set and pass x: 

ggplot(new_wages,
       aes(x = education,
           fill = job_class)) +
  geom_bar(position = "fill") +  # [1] Add position.
  labs(y = "Proportion")  # [2] Add a label to y


# 3. Grouped bar chart

# in grouped bar chart the compared variables are placed side by side.
# we set position to = 'dodge' in the geom_bar()

ggplot(new_wages,
       aes(x = education,
           fill = job_class)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("blue", "dark green"))  # [1] Change fill colours.


ggplot(new_wages,
       aes(x = education,
           fill = job_class)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("blue", "dark green")) + # [1] Change fill colours.
  labs(fill = 'job_class') + # change label of right side legend
  scale_y_continuous(breaks = seq(0,700,100)) # set relevent breaks
  

##### 2. Comparing categorical and quantitative variables

# a) boxplots
# b) side-by-side boxplots
# c) side-by-side violinplots.


####### Boxplots

# [1] Specify the ggplot function; [1a] set data source and [1b] set and pass x: 

ggplot(new_wages,
       aes(x = education,
           y = wage)) +
  geom_boxplot()  # [2] Specify the geom_boxplot function.


# [1] Specify the ggplot function; [1a] set data source and [1b] set and pass x: 

# Specify [1] the ggplot and [2] geom_boxplot functions:

ggplot(new_wages,
       aes(x = education,
           y = wage)) +
  geom_boxplot(fill = "red",
               notch = TRUE,
               outlier.color = "red"
  ) +  
  labs(title = "Wages by education level") +  # [3] Specify the titles.
  theme_minimal()  # [4] Add a 'minimal' theme.

#### Violinplots

# [1] Specify the ggplot function; [1a] set data source and [1b] pass x and y variables:

ggplot(new_wages, 
       aes(x = education, 
           y = wage)) +
  geom_violin()  # [2] Specify the geom_violin function.


# [1] Specify the ggplot function; [1a] set data source and [1b] pass x and y variables:

ggplot(new_wages, 
       aes(x = education, 
           y = wage)) +
  geom_violin(fill = 'red', alpha = .5) + # color read and change transparency to .5
  labs(title = 'Wages by education')

# [1] Specify the ggplot function:

ggplot(new_wages, 
       aes(x = education, 
           y = wage)) +
  geom_violin(fill = "red") +  #[2] Specify the geom_violin function and fill.
geom_boxplot(fill = "green",
             width = .25,
             outlier.color = "green",
             outlier.size = 1,
             outlier.shape = "square")  # [3] Specify the geom_boxplot. 



####### Multivariate data


ggplot(data = wages.new,
       mapping = aes(x = age, 
                     y = wage,
                     color = education,
                     shape = job_class)) +
  geom_point(alpha = 1,
             size = 3) +
  scale_x_continuous (breaks = seq(0, 90, 5)) +
  scale_y_continuous(breaks = seq(0, 350, 50)) +
  scale_fill_brewer('set2')
  facet_wrap(~job_class) +
  labs(title = "Relationship between wages and age",
       subtitle = "Survey from the mid-Atlantic region, USA",
       caption = "Source: US govt data",
       x = "Individuals' Age",
       y = "Wage in $ (x1000)",
       color = "Education Level"
  )  # [3] Add labels to labs function.




