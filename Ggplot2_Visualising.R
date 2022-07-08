# install and import packages
install.packages("ggplot2")
install.packages("tidyverse")
library(tidyverse)

# Import data
wages <- read.csv(file.choose(), header = TRUE)

wages # print/return the data frame
View(wages) # View the data frame

# 2. Summarise the data
summary(wages)

# 3. Create a scatterplot with qplot

qplot(age,wage,data = wages)

# 4. Create histogram with an x-variable
qplot(age, data = wages)

# 5. Adjust histogram bins
qplot(age, bins = 5, data = wages)

# 6. Create scatterplot with y-variable
qplot(y=wage, data = wages)

# 7. Create bar graph
qplot(age, data = wages, geom = 'bar')

# 8. Create stacked bar chart
qplot(age, fill= education, data = wages, geom ='bar')

# 9. Create boxplot
qplot( age, race, data = wages, geom = 'boxplot')

#10. changing aesthetics in qplot
qplot( age, race, data = wages, colour = I('red'),geom = 'boxplot')

# 11. Create Heatmaps
qplot(race, education, fill = wage, data = wages, geom = 'raster')

# 12. Facets in qplot
qplot(age,wage, data= wages, facets = education ~ race)


