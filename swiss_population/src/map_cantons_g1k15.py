
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np


# In[ ]:

reduced_g1k15 = pd.read_csv("../data/clean_data/shpdfg1k15_adjustedcoords.csv")


# In[ ]:

## read in canton names as they are stored in the 2016_canton_....csv files 

canton_names = pd.read_csv("../data/clean_data/2016_canton_allpop_cit_cleaned.csv", usecols=["Canton"]).Canton.unique()


# In[ ]:

canton_names = canton_names[1:]


# In[ ]:

canton_group = [val for val in range(1,27)]


# In[ ]:

## map g1k15 group values to corresponding canton 

canton_dict = {}

for i in range(len(canton_names)):
    canton_dict[str(canton_group[i])] = canton_names[i]


# In[ ]:

g1k15_cantons = []

for ind, row in reduced_g1k15.iterrows():
    g1k15_cantons.append(canton_dict[str(row["KTNR"])])


# In[ ]:

reduced_g1k15["cantons"] = g1k15_cantons


# In[ ]:

reduced_g1k15.to_csv("../data/clean_data/reduced_g1k15_withcities.csv")

