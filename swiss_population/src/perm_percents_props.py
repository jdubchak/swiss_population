## JD Dec 2017

## This script reads in 2016_canton_perm_birthpl_cit_cleaned.csv and percentage and proportion of all permanent residents living 
## in switzerland who are canadian. 

# coding: utf-8


import pandas as pd
import numpy as np
import argparse 

parser = argparse.ArgumentParser()
parser.add_argument("--input_file", help="../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv")
parser.add_argument("--output_file", help="../data/clean_data/reduced_g1k15_canton_perm_canadians.csv")
args = parser.parse_args()

## "../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv"
canton_perm_birthpl_cit = pd.read_csv(args.input_file, index_col=0)



## reduce columns 
canton_perm_birthpl_cit_Canada = canton_perm_birthpl_cit[["Year", "Commune", "District", "Canton", "Population type", "Place of birth",
                        "Citizenship - Total", "Canada", "Switzerland"]]




#canton_perm_birthpl_cit_Canada.head()



## filter for expats born in Canada 
canton_perm_Canadians_bornabroad = canton_perm_birthpl_cit_Canada.loc[(canton_perm_birthpl_cit_Canada["Place of birth"] == "Abroad") & 
                                     (canton_perm_birthpl_cit_Canada.District.isnull())][["Year", "Canton", 
                                                                                             "Population type", "Place of birth", 
                                                                                             "Citizenship - Total", "Canada"]]
    



## calculate proportions and percentages of perm canadians / total expat perm residents 
canadian_props = []
canadian_percent = []

for ind, row in canton_perm_Canadians_bornabroad.iterrows():
    canadian_props.append(row["Canada"]/row["Citizenship - Total"])
    canadian_percent.append((row["Canada"]/row["Citizenship - Total"])*100)



## append to df 
canton_perm_Canadians_bornabroad["Proportion of Perm Residents who are Canadian"] = canadian_props
canton_perm_Canadians_bornabroad["Percentage of Perm Residents who are Canadian"] = canadian_percent



## read in main reduced_g1k15 
reduced_g1k15 = pd.read_csv("../data/clean_data/reduced_g1k15_withcantons.csv", index_col=0)




#reduced_g1k15 = reduced_g1k15.drop('Unnamed: 0.1', axis=1)



## map proportion calculated above to the 9k reduced_g1k15 rows by canton 
reduced_canton_percent = []
reduced_canton_prop = []

for ind1, row1 in reduced_g1k15.iterrows():
    for ind2, row2 in canton_perm_Canadians_bornabroad.iterrows():
        if row1["cantons"] == row2["Canton"]:
            reduced_canton_percent.append(row2["Percentage of Perm Residents who are Canadian"])
            reduced_canton_prop.append(row2["Proportion of Perm Residents who are Canadian"])



## append to df
reduced_g1k15["Percentage of Nonperm Residents who are Canadian"] = reduced_canton_percent
reduced_g1k15["Proportion of Nonperm Residents who are Canadian"] = reduced_canton_prop


## save 
## "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv"
reduced_g1k15.to_csv(args.output_file)

