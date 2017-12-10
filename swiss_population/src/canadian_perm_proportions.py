## JD Dec 2017

## This file reads in 2016_canton_perm_birthpl_cit_cleaned.csv and generates the percentage and proportion of Canadian 
## permanent residents in Switzerland by canton.

# coding: utf-8



import pandas as pd
import numpy as np




canton_perm_birthpl_cit = pd.read_csv("../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv", index_col=0)


 

canton_perm_birthpl_cit_Canada = canton_perm_birthpl_cit[["Year", "Commune", "District", "Canton", "Population type", "Place of birth",
                        "Citizenship - Total", "Canada", "Switzerland"]]




canton_perm_birthpl_cit_Canada.head()


 

canton_perm_Canadians_bornabroad = canton_perm_birthpl_cit_Canada.loc[(canton_perm_birthpl_cit_Canada["Place of birth"] == "Abroad") & 
                                     (canton_perm_birthpl_cit_Canada.District.isnull())][["Year", "Canton", 
                                                                                             "Population type", "Place of birth", 
                                                                                             "Citizenship - Total", "Canada"]]


 

all_canadians_count = canton_perm_Canadians_bornabroad.iloc[0]["Canada"]


 

canadian_props = []
canadian_percent = []

for ind, row in canton_perm_Canadians_bornabroad.iterrows():
    canadian_props.append(row["Canada"]/all_canadians_count)
    canadian_percent.append((row["Canada"]/all_canadians_count)*100)


 

canton_perm_Canadians_bornabroad["Proportion of Perm Residents who are Canadian in Canton"] = canadian_props
canton_perm_Canadians_bornabroad["Percentage of Perm Residents who are Canadian in Canton"] = canadian_percent


 

reduced_g1k15 = pd.read_csv("../data/clean_data/reduced_g1k15_withcities.csv", index_col=0)


 

reduced_g1k15 = reduced_g1k15.drop('Unnamed: 0.1', axis=1)


 

reduced_canton_percent = []
reduced_canton_prop = []

for ind1, row1 in reduced_g1k15.iterrows():
    for ind2, row2 in canton_perm_Canadians_bornabroad.iterrows():
        if row1["cantons"] == row2["Canton"]:
            reduced_canton_percent.append(row2["Percentage of Perm Residents who are Canadian in Canton"])
            reduced_canton_prop.append(row2["Proportion of Perm Residents who are Canadian in Canton"])


 

reduced_g1k15["Percentage of Perm Residents who are Canadian in Canton"] = reduced_canton_percent
reduced_g1k15["Proportion of Perm Residents who are Canadian in Canton"] = reduced_canton_prop


 

reduced_g1k15.to_csv("../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv")

