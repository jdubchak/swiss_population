
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np


# In[30]:

canton_perm_birthpl_cit = pd.read_csv("../data/clean_data/2016_canton_perm_birthpl_cit_cleaned.csv", index_col=0)


# In[31]:

canton_perm_birthpl_cit_Canada = canton_perm_birthpl_cit[["Year", "Commune", "District", "Canton", "Population type", "Place of birth",
                        "Citizenship - Total", "Canada", "Switzerland"]]


# In[32]:

canton_perm_birthpl_cit_Canada.head()


# In[33]:

canton_perm_Canadians_bornabroad = canton_perm_birthpl_cit_Canada.loc[(canton_perm_birthpl_cit_Canada["Place of birth"] == "Abroad") & 
                                     (canton_perm_birthpl_cit_Canada.District.isnull())][["Year", "Canton", 
                                                                                             "Population type", "Place of birth", 
                                                                                             "Citizenship - Total", "Canada"]]
    


# In[34]:

canadian_props = []
canadian_percent = []

for ind, row in canton_perm_Canadians_bornabroad.iterrows():
    canadian_props.append(row["Canada"]/row["Citizenship - Total"])
    canadian_percent.append((row["Canada"]/row["Citizenship - Total"])*100)


# In[35]:

canton_perm_Canadians_bornabroad["Proportion of Perm Residents who are Canadian"] = canadian_props
canton_perm_Canadians_bornabroad["Percentage of Perm Residents who are Canadian"] = canadian_percent


# In[36]:

reduced_g1k15 = pd.read_csv("../data/clean_data/reduced_g1k15_withcities.csv", index_col=0)


# In[37]:

reduced_g1k15 = reduced_g1k15.drop('Unnamed: 0.1', axis=1)


# In[38]:

reduced_canton_percent = []
reduced_canton_prop = []

for ind1, row1 in reduced_g1k15.iterrows():
    for ind2, row2 in canton_perm_Canadians_bornabroad.iterrows():
        if row1["cantons"] == row2["Canton"]:
            reduced_canton_percent.append(row2["Percentage of Perm Residents who are Canadian"])
            reduced_canton_prop.append(row2["Proportion of Perm Residents who are Canadian"])


# In[39]:

reduced_g1k15["Percentage of Nonperm Residents who are Canadian"] = reduced_canton_percent
reduced_g1k15["Proportion of Nonperm Residents who are Canadian"] = reduced_canton_prop


# In[41]:

reduced_g1k15.to_csv("../data/clean_data/reduced_g1k15_canton_perm_canadians.csv")

