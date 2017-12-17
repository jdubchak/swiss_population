## Makefile 
## 
## Jordan Dubchak, Dec 2017
##
## This file completes the entire project analysis. 
##
## Usage:
##	$ make clean: deletes all intermediate files 
##	$ make all: geneerates the entire report 
##
## Note: This file can be finicky. If 'make all' generates an error, try running 'make __insert rule__' for any rule, and then 
##       try executing 'make all' again. 


## Run the entire project 
all: final_report results/*.png 

## Script 1: This script cleans the Canton/District/Commune column, and transforms latin encoding to utf-8. 
data/clean_data/2016_canton_perm_cit_cleaned.csv data/clean_data/2016_canton_allpop_cit_cleaned.csv data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv: src/clean_CantonDistrictCommune_col.py
	python3 src/clean_CantonDistrictCommune_col.py --file1 "2016_canton_perm_cit" --file2 "2016_canton_allpop_cit" --file3 "2016_canton_nonperm_birthpl_cit" --file4 "2016_canton_perm_birthpl_cit"


## Script 2: This script only takes 1 input as the file uses a dataframe from `ggswissmaps`. 
data/clean_data/shpdfg1k15_adjustedcoords.csv: src/adjust_coords.R 
	RScript src/adjust_coords.R "data/clean_data/shpdfg1k15_adjustedcoords.csv"    


## Script 3: This script maps cantons of the `ggswissmaps` object to the data frames cleaned in script 1.
data/clean_data/reduced_g1k15_withcantons.csv: data/clean_data/shpdfg1k15_adjustedcoords.csv src/map_cantons_g1k15.py
	python3 src/map_cantons_g1k15.py  --input_file "data/clean_data/shpdfg1k15_adjustedcoords.csv" --output_file "data/clean_data/reduced_g1k15_withcantons.csv"


## Scripts 4-7: These scripts calculate the proportion of non permanent and permanent Swiss residents born in Canada. Scripts 4 and 5 calculate non permanent and permanent Canadians per canton / total non permanent and permanent expats, while scripts 6 and 7 caculate non permanent and permanent Canadians per canton / total non permanent and permanent Canadians.

data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv: data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv src/nonperm_percents_props.py
	python3 src/nonperm_percents_props.py --input_file "data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"

data/clean_data/reduced_g1k15_canton_perm_canadians.csv: data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv src/perm_percents_props.py
	python3 src/perm_percents_props.py --input_file "data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "data/clean_data/reduced_g1k15_canton_perm_canadians.csv"

data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv: data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv src/canadian_nonperm_props_percents.py
	python3 src/canadian_nonperm_props_percents.py --input_file "data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv"

data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv: data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv src/canadian_perm_proportions.py
	python3 src/canadian_perm_proportions.py --input_file "data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv"

##Script 8: This script generates figures for the four cleaned data sets from scripts 4-7. Eight figures are generated (two per script), as one figure contains annotations, while the second does not. 
results/*.png: data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv data/clean_data/reduced_g1k15_canton_perm_canadians.csv data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv src/generating_figures.R 
	RScript src/generating_figures.R "data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv" "results/nonperm_Canadian_percentages_by_canton_w5large_text.png" "data/clean_data/reduced_g1k15_canton_perm_canadians.csv" "results/perm_Canadian_percentages_by_canton_w5large_text.png" "data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv" "results/nonperm_all_Canadians_by_canton_w5large_text.png" "data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv" "results/perm_all_canadians_by_canton_w5large_text.png"   ## add -e

## Script 9: This script generates the markdown file for the report. 
final_report: src/Report.Rmd results/*.png
	Rscript -e "ezknitr::ezknit('src/Report.Rmd', out_dir='doc')"

## Clean up intermediate files 
clean: 
	rm -f data/clean_data/*.csv
	rm -f doc/*.html
	rm -f doc/*.md
	rm -f results/*.png