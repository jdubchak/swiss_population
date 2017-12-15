## for this file
## JD Dec 2017 



## This file reads in 2016_canton_perm_birthpl_cit_cleaned.csv and generates the percentage and proportion of Canadian 
## permanent residents in Switzerland by canton.

##This script reads in 2016_canton_nonperm_birthpl_cit_cleaned.csv and percentage and proportion of all non permanent residents living 
## in switzerland who are canadian. 

Percentage of all non permanent residents living in Switzerland born in Canada

Percentage of Canadian Non Permanent Residents in Switzerland by Canton 

import argparse 
parser = argparse.ArgumentParser()
parser.add_argument("--input_file", help="There should be four files in this list.")
parser.add_argument("--output_file", help="This should only be the 'clean_data' directory.")
args = parser.parse_args()

python3 clean_CantonDistrictCommune_col.py --file1 "2016_canton_perm_cit" --file2 "2016_canton_allpop_cit" --file3 "2016_canton_nonperm_birthpl_cit" --file4 "2016_canton_perm_birthpl_cit" 

RScript -e adjust_coords.R "../data/clean_data/shpdfg1k15_adjustedcoords.csv"    --> only contains 1 because input is a ggswissmaps object 

python3 map_cantons_g1k15.py  --input_file "../data/clean_data/shpdfg1k15_adjustedcoords.csv" --output_file "../data/clean_data/reduced_g1k15_withcantons.csv"

python3 nonperm_percents_props.py --input_file "../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"

python3 perm_percents_props.py --input_file "../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv"

python3 canadian_nonperm_props_percents.py --input_file "../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv"

python3 canadian_perm_proportions.py --input_file "../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv"

RScript -e generating_figures.R "../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv" "../results/nonperm_Canadian_percentages_by_canton_w5large_text.png" "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv" "../results/perm_Canadian_percentages_by_canton_w5large_text.png" "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv" "../results/nonperm_all_Canadians_by_canton_w5large_text.png" "../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv" "../results/perm_all_canadians_by_canton_w5large_text.png"

Rscript -e "ezknitr::ezknit('Report.Rmd', out_dir='../doc')"

nonperm_all_in <- args[1] ## "../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"
nonperm_all_out <- args[2] ## "../results/nonperm_Canadian_percentages_by_canton_w5large_text.png"

perm_all_in <- args[3] ## "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv" "../results/perm_Canadian_percentages_by_canton_w5large_text.png"
perm_all_out <- args[4] ## "../results/perm_Canadian_percentages_by_canton_w5large_text.png"

nonperm_can_in <- args[5] ## "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv" "../results/nonperm_all_Canadians_by_canton_w5large_text.png"
nonperm_can_out <- args[6] ## "../results/nonperm_all_Canadians_by_canton_w5large_text.png"

perm_can_in <- args[7] ## "../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv" "../results/perm_all_canadians_by_canton_w5large_text.png"
perm_can_out <- args[8] ## "../results/perm_all_canadians_by_canton_w5large_text.png"










