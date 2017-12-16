## JD Dec 2017

## This script reads in 2016_canton_nonperm_birthpl_cit_cleaned.csv and percentage and proportion of all non permanent residents living 
## in switzerland who are canadian. 

 

import pandas as pd
import numpy as np

import argparse 
parser = argparse.ArgumentParser()
parser.add_argument("--input_file", help="There should be four files in this list.")
parser.add_argument("--output_file", help="../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv")
args = parser.parse_args()

 
## "../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv"  
canton_nonperm_birthpl_cit = pd.read_csv(args.input_file, index_col=0)


 
## reduce columns 
canton_nonperm_birthpl_cit_Canada = canton_nonperm_birthpl_cit[["Year", "Commune", "District", "Canton", "Population type",
                           "Place of birth", "Citizenship - Total", "Canada", "Switzerland"]]


 
## filter for non perm residents born abroad and in Canada and retain only Canada col of all countries 
canton_nonperm_Canadians_bornabroad = canton_nonperm_birthpl_cit_Canada.loc[(canton_nonperm_birthpl_cit_Canada["Place of birth"] == "Abroad") & 
                                     (canton_nonperm_birthpl_cit_Canada.District.isnull())][["Year", "Canton", 
                                                                                             "Population type", "Place of birth", 
                                                                                             "Citizenship - Total", "Canada"]]
    


 
## calculate the proportion of canadians/ total non/perm residents 
canadian_props = []
canadian_percent = []

for ind, row in canton_nonperm_Canadians_bornabroad.iterrows():
    canadian_props.append(row["Canada"]/row["Citizenship - Total"])
    canadian_percent.append((row["Canada"]/row["Citizenship - Total"])*100)


 
## append to df as new col 
canton_nonperm_Canadians_bornabroad["Proportion of Nonperm Residents who are Canadian"] = canadian_props
canton_nonperm_Canadians_bornabroad["Percentage of Nonperm Residents who are Canadian"] = canadian_percent


 
## write this out as a file 
canton_nonperm_Canadians_bornabroad.to_csv("data/clean_data/2016_canton_nonperm_Canadians_bornabroad.csv")


 
## read in reduced_g1k15
reduced_g1k15 = pd.read_csv("data/clean_data/reduced_g1k15_withcantons.csv", index_col=0)


 

## remove extra unnamed index col
#reduced_g1k15 = reduced_g1k15.drop('Unnamed: 0.1', axis=1)


 

#reduced_g1k15.head(2)


 

#canton_nonperm_Canadians_bornabroad.head(2)


 
## map proportions and percents from canton_nonperm_Canadians_bornabroad to each row in reduced_g1k15 by canton 
reduced_canton_percent = []
reduced_canton_prop = []

for ind1, row1 in reduced_g1k15.iterrows():
    for ind2, row2 in canton_nonperm_Canadians_bornabroad.iterrows():
        if row1["cantons"] == row2["Canton"]:
            reduced_canton_percent.append(row2["Percentage of Nonperm Residents who are Canadian"])
            reduced_canton_prop.append(row2["Proportion of Nonperm Residents who are Canadian"])


 
## append these rows to reduced_g1k15
reduced_g1k15["Percentage of Nonperm Residents who are Canadian"] = reduced_canton_percent
reduced_g1k15["Proportion of Nonperm Residents who are Canadian"] = reduced_canton_prop


 ## save 
 #"../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"
reduced_g1k15.to_csv(args.output_file)

