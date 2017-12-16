## Driver Script
## 
## Jordan Dubchak, Dec 2017

## Script 1: This script cleans the Canton/District/Commune column, and transforms latin encoding to utf-8. 

python3 clean_CantonDistrictCommune_col.py --file1 "2016_canton_perm_cit" --file2 "2016_canton_allpop_cit" --file3 "2016_canton_nonperm_birthpl_cit" --file4 "2016_canton_perm_birthpl_cit"

## Script 2: This script only takes 1 input as the file uses a dataframe from `ggswissmaps`. 

RScript -e adjust_coords.R "/data/clean_data/shpdfg1k15_adjustedcoords.csv" 

## Script 3: This script maps cantons of the `ggswissmaps` object to the data frames cleaned in script 1.

python3 map_cantons_g1k15.py  --input_file "/data/clean_data/shpdfg1k15_adjustedcoords.csv" --output_file "/data/clean_data/reduced_g1k15_withcantons.csv"

## Scripts 4-7: These scripts calculate the proportion of non permanent and permanent Swiss residents born in Canada. Scripts 4 and 5 calculate non permanent and permanent Canadians per canton / total non permanent and permanent expats, while scripts 6 and 7 caculate non permanent and permanent Canadians per canton / total non permanent and permanent Canadians. 

python3 nonperm_percents_props.py --input_file "/data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "/data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"

python3 perm_percents_props.py --input_file "/data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "/data/clean_data/reduced_g1k15_canton_perm_canadians.csv"

python3 canadian_nonperm_props_percents.py --input_file "/data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "/data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv"

python3 canadian_perm_proportions.py --input_file "/data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "/data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv"

##Script 8: This script generates figures for the four cleaned data sets from scripts 4-7. Eight figures are generated (two per script), as one figure contains annotations, while the second does not. 

RScript -e generating_figures.R "/data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv" "/results/nonperm_Canadian_percentages_by_canton_w5large_text.png" "/data/clean_data/reduced_g1k15_canton_perm_canadians.csv" "/results/perm_Canadian_percentages_by_canton_w5large_text.png" "/data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv" "/results/nonperm_all_Canadians_by_canton_w5large_text.png" "/data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv" "/results/perm_all_canadians_by_canton_w5large_text.png"

## Script 9: This script generates the markdown file for the report. 

Rscript -e "ezknitr::ezknit('Report.Rmd', out_dir='/doc')"