import pandas as pd

all_files = ["2016_canton_allpop_cit.csv", "2016_canton_nonperm_cit.csv", "2016_canton_perm_birthpl_cit.csv", 
"2016_canton_perm_resperm_sex_age_canada.csv", "2016_canton_nonperm_birthpl_cit.csv", "2016_canton_nonperm_resperm_sex_age_canada.csv",
"2016_canton_perm_cit.csv"]

print("This script will produce the head of each raw data file.")
print("Note: There are 7 files in the data/ directory.")
print("Each file contains different levels and combinations of variables (i.e. permanent/non permanent residents).")
print("For this reason, the default value argument of head to print 6 rows will be overridden to only output 2 rows.")

count = 0

for file in all_files:
	file_loc = "../data/" + file
	print("Printing the head of:", file)
	print(pd.read_csv(file_loc, encoding="latin-1", sep=" ", low_memory=False, skiprows=1).head(2))
	print("\n")
	count += 1 
	if count == len(all_files):
		print("File ", count, "of ", len(all_files), ". Printing complete.")