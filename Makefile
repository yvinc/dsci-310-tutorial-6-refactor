.PHONY: all clean report

all:
	make index.html

cleaned/cleaned_penguins.csv: 01_load_data.R
	Rscript 01_load_data.R 

cleaned/cleaned_penguins_02.csv: 02_methods.R cleaned/cleaned_penguins.csv
	Rscript 02_methods.R cleaned/cleaned_penguins.csv

results/model.RDS results/test_data.csv: 03_model.R cleaned/cleaned_penguins_02.csv
	Rscript 03_model.R --file_path=cleaned/cleaned_penguins_02.csv --output_model=results/model.RDS --output_test_data=results/test_data.csv

results/predictions.csv results/conf_mat.png: 04_results.R results/model.RDS results/test_data.csv
	Rscript 04_results.R --model=results/model.RDS --input_test_data=results/test_data.csv --output_pred=results/predictions.csv --output_confmat_fig=results/conf_mat.png
	
index.html: t6-quarto.qmd results/predictions.csv results/conf_mat.png
	quarto render t6-quarto.qmd --output index.html
	
report:
	make index.html