## JD 2017 

## This script maps canton names to their respective groupings in the shp[["g1k15"]] data frame from ggswissmaps. 

# coding: utf-8

 

import pandas as pd
import numpy as np


 

reduced_g1k15 = pd.read_csv("../data/clean_data/shpdfg1k15_adjustedcoords.csv")


 

## read in canton names as they are stored in the 2016_canton_....csv files 

canton_names = pd.read_csv("../data/clean_data/2016_canton_allpop_cit_cleaned.csv", usecols=["Canton"]).Canton.unique()


 

canton_names = canton_names[1:]


 

canton_group = [val for val in range(1,27)]


 

## map g1k15 group values to corresponding canton 

canton_dict = {}

for i in range(len(canton_names)):
    canton_dict[str(canton_group[i])] = canton_names[i]


 

g1k15_cantons = []

for ind, row in reduced_g1k15.iterrows():
    g1k15_cantons.append(canton_dict[str(row["KTNR"])])


 

reduced_g1k15["cantons"] = g1k15_cantons


 

reduced_g1k15.to_csv("../data/clean_data/reduced_g1k15_withcities.csv")

