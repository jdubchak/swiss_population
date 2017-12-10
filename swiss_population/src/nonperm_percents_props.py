
# coding: utf-8

# #### This script calculates the proportions and percentages of Canadians / all countries of Non Permanent Residents living in Switzerland in 2016. 

# In[1]:

import pandas as pd
import numpy as np


# In[4]:

canton_nonperm_birthpl_cit = pd.read_csv("../data/clean_data/2016_canton_nonperm_birthpl_cit_cleaned.csv", index_col=0)


# In[9]:

canton_nonperm_birthpl_cit_Canada = canton_nonperm_birthpl_cit[["Year", "Commune", "District", "Canton", "Population type",
                           "Place of birth", "Citizenship - Total", "Canada", "Switzerland"]]


# In[34]:

canton_nonperm_Canadians_bornabroad = canton_nonperm_birthpl_cit_Canada.loc[(canton_nonperm_birthpl_cit_Canada["Place of birth"] == "Abroad") & 
                                     (canton_nonperm_birthpl_cit_Canada.District.isnull())][["Year", "Canton", 
                                                                                             "Population type", "Place of birth", 
                                                                                             "Citizenship - Total", "Canada"]]
    


# In[38]:

canadian_props = []
canadian_percent = []

for ind, row in canton_nonperm_Canadians_bornabroad.iterrows():
    canadian_props.append(row["Canada"]/row["Citizenship - Total"])
    canadian_percent.append((row["Canada"]/row["Citizenship - Total"])*100)


# In[41]:

canton_nonperm_Canadians_bornabroad["Proportion of Nonperm Residents who are Canadian"] = canadian_props
canton_nonperm_Canadians_bornabroad["Percentage of Nonperm Residents who are Canadian"] = canadian_percent


# In[43]:

canton_nonperm_Canadians_bornabroad.to_csv("../data/clean_data/2016_canton_nonperm_Canadians_bornabroad.csv")


# In[64]:

reduced_g1k15 = pd.read_csv("../data/clean_data/reduced_g1k15_withcities.csv", index_col=0)


# In[65]:

## remove extra unnamed index col
reduced_g1k15 = reduced_g1k15.drop('Unnamed: 0.1', axis=1)


# In[70]:

reduced_g1k15.head(2)


# In[69]:

canton_nonperm_Canadians_bornabroad.head(2)


# In[71]:

reduced_canton_percent = []
reduced_canton_prop = []

for ind1, row1 in reduced_g1k15.iterrows():
    for ind2, row2 in canton_nonperm_Canadians_bornabroad.iterrows():
        if row1["cantons"] == row2["Canton"]:
            reduced_canton_percent.append(row2["Percentage of Nonperm Residents who are Canadian"])
            reduced_canton_prop.append(row2["Proportion of Nonperm Residents who are Canadian"])


# In[73]:

reduced_g1k15["Percentage of Nonperm Residents who are Canadian"] = reduced_canton_percent
reduced_g1k15["Proportion of Nonperm Residents who are Canadian"] = reduced_canton_prop


# In[75]:

reduced_g1k15.to_csv("../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv")

