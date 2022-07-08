install.packages("plotly")


library(plotly)  # Call the plotly library.
library(ggplot2)
library(tidyverse)
# Create the plot - this a basic plot and data set included in the package:
fig <- plot_ly(midwest, 
               x = ~percollege,
               color = ~state, 
               type = "box")

fig  # Print the plot.

# Syntax

plot_ly(data, 
        x = ~variable,
        y = ~variable 
        colors = "Color",
        title = "Plot Title", 
        type = "plot type")

# Import data

cars <- mtcars

# check type
typeof(cars)

# as its is a list convert to df
cars <- as.data.frame(cars)

head(cars)

# create a visualisation using one variable

plot_ly(cars,
        x = ~wt)

# create vis with two variables (barchart)

plot_ly(cars,
        x = ~wt,
        y = ~mpg,
        type = 'bar')

# add a third variable to the plot as color
 # we have to add factor to tell R that cyl is a categorical variable
  

plot_ly(cars,
        x = ~wt,
        y = ~mpg,
        type = 'scatter',
        mode = 'markers',
        color = ~factor(cars$cyl))

# add symbols

plot_ly(cars,
        x = ~wt,
        y = ~mpg,
        type = 'scatter',
        mode = 'markers',
        color = ~factor(cars$cyl),
        symbols = ~cars$cyl,
        symbols = c('circle','x','o'),
        size = 2,
        alpha = 1)

# 3d charts
plot_ly(cars,
        x = ~wt,
        y = ~mpg,
        z = ~cyl,
        color = factor(cars$gear))

# animated plot

plot_ly(cars,
        x = ~wt,
        y = ~mpg,
        type = 'scatter',
        mode = 'markers',
        frame = ~cars$cyl,
        show.legend = FALSE)

viz = plot_ly(cars,
              x = ~wt,
              y = ~mpg,
              type = 'scatter',
              mode = 'markers',
              frame = ~cars$cyl,
              show.legend = FALSE)


# Using the ggplotly() function


# [2] Import the data set:
wages <- read.csv (file.choose (), header = T)

# [3] Create an object 'plot' and [4] specify the function:
plot <- ggplot(data = wages,
               mapping = aes(x = age, y=wage)) +
  geom_point()
ggplotly(plot)  # [5] Specify the function and pass the plot.



