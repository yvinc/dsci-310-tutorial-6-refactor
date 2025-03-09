# author: Vincy Huang
# date: 2025-03-08

"
Usage: 03_model.R --file_path=<file_path> --output_model=<output_model> --output_test_data=<output_test_data>
" -> doc
library(tidymodels)
library(tidyverse)
library(docopt)

opt <- docopt(doc)

# data <- read_csv(opt$file_path) |>
#          mutate(species = as.factor(species))

data <- read_csv(opt$file_path, col_types = cols(species = col_factor()))

set.seed(123)
data_split <- initial_split(data, strata = species)
train_data <- training(data_split)

test_data <- testing(data_split)
write_csv(test_data, opt$output_test_data)


# Define model
penguin_model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
                set_engine("kknn")

# Create workflow
penguin_workflow <- workflow() %>%
  add_model(penguin_model) %>%
  add_formula(species ~ .)

# Fit model
penguin_fit <- penguin_workflow %>%
               fit(data = train_data)

write_rds(penguin_fit, opt$output_model)
