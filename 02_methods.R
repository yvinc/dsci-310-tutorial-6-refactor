# author: Vincy Huang
# date: 2025-03-08


"This script we perform exploratory data analysis (EDA) and prepare the data
for modeling based on cleaned_penguins.csv in the `cleaned` folder.

Usage: 02_methods.R <file_path>
" -> doc

library(tidyverse)
library(tidymodels)
library(docopt)

opt <- docopt(doc)

data <- read_csv(opt$file_path) #opt object is a list of the doc options!

glimpse(data)
summarise(data, 
          mean_bill_length = mean(bill_length_mm), 
          mean_bill_depth = mean(bill_depth_mm))

# Visualizations
ggplot(data, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_boxplot() +
  theme_minimal()

# Prepare data for modeling
data <- data %>%
  select(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g) %>%
  mutate(species = as.factor(species))

write_csv(data, "cleaned/cleaned_penguins_02.csv")

