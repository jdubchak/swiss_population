## JD Dec 2017
# coding: utf-8

## This file reads in 2016_canton_nonperm_birthpl_cit_cleaned.csv and generates the percentage and proportion of Canadian 
## non permanent residents in Switzerland by canton. 

import pandas as pd
import numpy as np
import argparse 

parser = argparse.ArgumentParser()
parser.add_argument("--input_file", help="../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv")
parser.add_argument("--output_file", help="../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv")
args = parser.parse_args()

## "../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv"
canton_nonperm_birthpl_cit = pd.read_csv(args.input_file, index_col=0)



## reduce cols 
canton_nonperm_birthpl_cit_Canada = canton_nonperm_birthpl_cit[["Year", "Commune", "District", "Canton", "Population type", "Place of birth",
                        "Citizenship - Total", "Canada", "Switzerland"]]



## filter for canadian expats 
canton_nonperm_Canadians_bornabroad = canton_nonperm_birthpl_cit_Canada.loc[(canton_nonperm_birthpl_cit_Canada["Place of birth"] == "Abroad") & 
                                     (canton_nonperm_birthpl_cit_Canada.District.isnull())][["Year", "Canton", 
                                                                                             "Population type", "Place of birth", 
                                                                                             "Citizenship - Total", "Canada"]]


 
## calculate total number of non perm swiss residents born in canada 
all_canadians_count = canton_nonperm_Canadians_bornabroad.iloc[0]["Canada"]



## calculate proportion of canadians in canton/ total canadians for non perm residents 
canadian_props = []
canadian_percent = []

for ind, row in canton_nonperm_Canadians_bornabroad.iterrows():
    canadian_props.append(row["Canada"]/all_canadians_count)
    canadian_percent.append((row["Canada"]/all_canadians_count)*100)



## append to df 
canton_nonperm_Canadians_bornabroad["Proportion of Nonperm Residents who are Canadian in Canton"] = canadian_props
canton_nonperm_Canadians_bornabroad["Percentage of Nonperm Residents who are Canadian in Canton"] = canadian_percent

 



## read in main file 
reduced_g1k15 = pd.read_csv("../data/clean_data/reduced_g1k15_withcantons.csv", index_col=0)




#reduced_g1k15 = reduced_g1k15.drop('Unnamed: 0.1', axis=1)



## map props to 9k rows in reduced_g1k15 by canton 
reduced_canton_percent = []
reduced_canton_prop = []

for ind1, row1 in reduced_g1k15.iterrows():
    for ind2, row2 in canton_nonperm_Canadians_bornabroad.iterrows():
        if row1["cantons"] == row2["Canton"]:
            reduced_canton_percent.append(row2["Percentage of Nonperm Residents who are Canadian in Canton"])
            reduced_canton_prop.append(row2["Proportion of Nonperm Residents who are Canadian in Canton"])



## append to df 
reduced_g1k15["Percentage of Nonperm Residents who are Canadian in Canton"] = reduced_canton_percent
reduced_g1k15["Proportion of Nonperm Residents who are Canadian in Canton"] = reduced_canton_prop

 

## save 
## "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv"
reduced_g1k15.to_csv("../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv")

