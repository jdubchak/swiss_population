# swiss_population

## Aim of the Project

This project is intended to explore and expand my data analysis skills in Python and R.  

This dataset will be explored to answer the question of where non permanent residents, specifically Canadians, lived in Switzerland in 2016. The hypothesis for this project is the majority (>50%) of non permanent residents born outside of Switzerland, specifically Canada, lived in cantons containing major city centres in 2016. For this project, major city centres are defined as Zurich, Geneva, Basel, Lausanne, and Bern, as all have populations greater than 125,000 inhabitants. 

In order to summarize the data, proportions of non permanent residents living in city centres were be calculated. This includes filtering for Canadians. The data was be visualized as proportions on a map of Switzerland, generated using R. The final report can be viewed as a [pdf](https://github.com/jdubchak/swiss_population/blob/master/swiss_population/doc/report.pdf) or [markdown document](https://github.com/jdubchak/swiss_population/blob/master/swiss_population/doc/report.md). 

## The Data

The data for this project was manually collected from the [Swiss STAT-TAB](https://www.pxweb.bfs.admin.ch/pxweb/en/px-x-0102010000_104/-/px-x-0102010000_104.px) website for the year 2016, and the 4 files can be found [here](https://github.com/jdubchak/swiss_population/tree/master/swiss_population/data/raw_data). 

## Requirements

This project was completed using Python 3, and `pandas` `v0.20.1`, and figures were generated in R, using `tidyverse` `v1.1.1`, `ggplot2` `v2.2.1` and `ggswissmaps` `v0.1.1`. As required by Milestone 2, the project release can be found [here](https://github.com/jdubchak/swiss_population/releases/tag/2.0). 

## Reproducibility

This project runs 9 scripts contained in the `src` directory. It is designed to run all scripts on the command line from within the src directory, please navigate to this directory using `cd /local_path/src`. Please download the 4 files contained in `/data/raw_data/` as they are required for the program to execute properly, as the data was manually downloaded from a government website. 

Script 1: This script cleans the Canton/District/Commune column, and transforms latin encoding to utf-8. 

`python3 clean_CantonDistrictCommune_col.py --file1 "2016_canton_perm_cit" --file2 "2016_canton_allpop_cit" --file3 "2016_canton_nonperm_birthpl_cit" --file4 "2016_canton_perm_birthpl_cit"`

Script 2: This script only takes 1 input as the file uses a dataframe from `ggswissmaps`. 

`RScript -e adjust_coords.R "../data/clean_data/shpdfg1k15_adjustedcoords.csv"`  

Script 3: This script maps cantons of the `ggswissmaps` object to the data frames cleaned in script 1.

`python3 map_cantons_g1k15.py  --input_file "../data/clean_data/shpdfg1k15_adjustedcoords.csv" --output_file "../data/clean_data/reduced_g1k15_withcantons.csv"`

Scripts 4-7: These scripts calculate the proportion of non permanent and permanent Swiss residents born in Canada. Scripts 4 and 5 calculate non permanent and permanent Canadians per canton / total non permanent and permanent expats, while scripts 6 and 7 caculate non permanent and permanent Canadians per canton / total non permanent and permanent Canadians. 

`python3 nonperm_percents_props.py --input_file "../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"`

`python3 perm_percents_props.py --input_file "../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv"`

`python3 canadian_nonperm_props_percents.py --input_file "../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv"`

`python3 canadian_perm_proportions.py --input_file "../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv" --output_file "../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv"`

Script 8: This script generates figures for the four cleaned data sets from scripts 4-7. Eight figures are generated (two per script), as one figure contains annotations, while the second does not. 

`RScript -e generating_figures.R "../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv" "../results/nonperm_Canadian_percentages_by_canton_w5large_text.png" "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv" "../results/perm_Canadian_percentages_by_canton_w5large_text.png" "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv" "../results/nonperm_all_Canadians_by_canton_w5large_text.png" "../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv" "../results/perm_all_canadians_by_canton_w5large_text.png"`

Script 9: This script generates the markdown file for the report. 

`Rscript -e "ezknitr::ezknit('Report.Rmd', out_dir='../doc')"`




