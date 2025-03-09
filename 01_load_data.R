# author: Vincy Huang
# date: 2025-03-08
#
# This is a script that loads the built-in R dataframe `penguins` from the
# `palmerpenguins` package, which contains measurements of penguins from three 
# species. This script takes no arguments.
# 
# Usage: Rscript 01_load_data.R

library(tidyverse)
library(palmerpenguins)
library(tidymodels)

data <- penguins 

# Initial cleaning: Remove missing values
data <- data |>
        drop_na()

write_csv(data, "cleaned/cleaned_penguins.csv")