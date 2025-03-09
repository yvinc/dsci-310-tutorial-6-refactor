# author: Vincy Huang
# date: 2025-03-09

"
Usage: 04_results.R --model=<model> --input_test_data=<input_test_data> --output_pred=<output_pred> --output_confmat_fig=<output_confmat_fig>
" -> doc

library(docopt)
library(tidymodels)
library(tidyverse)

opt <- docopt(doc)
penguin_fit <- read_rds(opt$model)
test_data <- read_csv(opt$input_test_data, col_types = cols(species = col_factor()))

# Predict on test data
predictions <- predict(penguin_fit, test_data, type = "class") %>%
               bind_cols(test_data)

write_csv(predictions, opt$output_pred)

# Confusion matrix
conf_mat <- conf_mat(predictions, truth = species, estimate = .pred_class)
conf_mat

autoplot(conf_mat, type = 'heatmap')
ggsave(opt$output_confmat_fig)

# # Conclusion
# 
# In this tutorial, we:
#   
#   - Loaded and cleaned the `palmerpenguins` dataset.
# - Performed exploratory data analysis.
# - Built a k-Nearest Neighbors classification model using `tidymodels`.
# - Evaluated the model's performance.