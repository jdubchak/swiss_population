print("This script will produce the head of each raw data file.")
print("Note: There are 7 files in the data/ directory.")
print("Each file contains different levels and combinations of variables (i.e. permanent/non permanent residents).")
print("For this reason, the default value argument of head to print 6 rows will be overridden to only output 2 rows.")

print("Printing head of file 1 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_allpop_cit.csv"))))

print("Printing head of file 2 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_nonperm_cit.csv"))))

print("Printing head of file 3 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_perm_birthpl_cit.csv"))))

print("Printing head of file 4 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_perm_resperm_sex_age_canada.csv"))))

print("Printing head of file 5 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_nonperm_birthpl_cit.csv"))))

print("Printing head of file 6 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_nonperm_resperm_sex_age_canada.csv"))))

print("Printing head of file 7 of 7.")
print(head(suppressWarnings(readr::read_csv("../data/2016_canton_perm_cit.csv"))))
print("Printing Complete.")