## Jordan Dubchak 2017 

## This script maps canton names to their respective groupings in the shp[["g1k15"]] data frame from ggswissmaps. 

# coding: utf-8

import argparse 
parser = argparse.ArgumentParser()
parser.add_argument("--input_file", help="This is the adjustedcoords csv file.")
parser.add_argument("--output_file", help="This is the reduced_g1k15_withcantons file.")
args = parser.parse_args()

import pandas as pd
import numpy as np


 
## input: "../data/clean_data/shpdfg1k15_adjustedcoords.csv"
reduced_g1k15 = pd.read_csv(args.input_file)


 

## read in canton names as they are stored in the 2016_canton_....csv files 

canton_names = pd.read_csv("../data/clean_data/2016_canton_allpop_cit_cleaned.csv", usecols=["Canton"]).Canton.unique()


 
## eliminate the NaN value
canton_names = canton_names[1:]


 
## canton values are in order, create range for length of them 
canton_group = [val for val in range(1,27)]


 

## map g1k15 group values to corresponding canton 

canton_dict = {}

for i in range(len(canton_names)):
    canton_dict[str(canton_group[i])] = canton_names[i]


 
## loop through the 9k rows of reduced_g1k15 and map the canton to the row
g1k15_cantons = []

for ind, row in reduced_g1k15.iterrows():
    g1k15_cantons.append(canton_dict[str(int(row["KTNR"]))])


 
## apend this list to the df as a new col 
reduced_g1k15["cantons"] = g1k15_cantons


 
## output: "../data/clean_data/reduced_g1k15_withcantons.csv"
reduced_g1k15.to_csv(args.output_file)

