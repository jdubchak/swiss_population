

# ### This file is intended to automate spreading the Canton/District/Commune column into 3 different columns



## these files, located in the data/ directory, all contain the "Canton (-) / District (>>) / Commune (......)" column 

files_wCDCcol = ["2016_canton_perm_cit", "2016_canton_allpop_cit", "2016_canton_nonperm_birthpl_cit", 
                 "2016_canton_perm_birthpl_cit"]


def file_input(filename):
    '''
    Read in file to memory and output a data frame.

    Input: a filename, not containing the path to the data directory. 
    Output: a dataframe 
    '''
    
    import pandas as pd
    filename = "../data/raw_data/" + filename + ".csv"
    file = pd.read_csv(filename, encoding="latin-1", sep=" ", low_memory=False, skiprows=1)
    return file 


def clean_CDC(filename):
    '''
    Input: a filename, not containing the path to the data directory. 
    Output: a larger, cleaned, dataframe, containing 3 additional columns: Canton, District and Commune 
    
    Calls file_input, which reads in the file and outputs a dataframe  
    '''

    df = file_input(filename)
    
    Canton = [] 
    District = []
    Commune = []

    for ind, row in df[["Canton (-) / District (>>) / Commune (......)"]].iterrows():
        if row[0] == "Switzerland":
            Canton.append("")
            District.append("")
            Commune.append("")
        elif row[0][0] == "-":
            Canton.append(row[0][2:])
            District.append("")
            Commune.append("")
            canton_row_before = row[0][2:]
        else:
            Canton == Canton.append(canton_row_before)
            if row[0][0] == ">":
                District.append(row[0][3:])
                Commune.append("")
                district_row_before = row[0][3:]
            else:
                District == District.append(district_row_before)
                if row[0][0] == ".":
                    Commune.append(row[0][11:])
                    comm_row_before = row[0][11:]
                else:
                    Commune == Commune.append(comm_row_before)
    ## add lists to dataframe 
    df["Commune"] = Commune
    df["District"] = District
    df["Canton"] = Canton
    
    return df 


def reorder_cols(filename):
    '''
    Input: a filename, not containing the path to the data directory. 
    Output: a dataframe with the columns rearranged to have Commune, District, and Canton in positions 2-5. 
    
    Calls clean_CDC, which outputs a cleaner dataframe where Commune, District and Canton are each unique columns. 
    
    Code from Fabio Lamanna, https://stackoverflow.com/questions/33216180/move-columns-within-pandas-data-frame
    '''
    df = clean_CDC(filename)
    
    colnames = df.columns.tolist()
    ## reorganize columns: Year remains the first column, the second to 5th columns are Commune, District and Canton
    ## and the remaining columns keep the same order 
    colnames = colnames[0:1] + colnames[-3:] + colnames[1:-3]
    
    df = df[colnames]
    return df 


def rm_acc_chars(filename):
    '''
    "Remove Accent Characters" 
    
    Input: a filename, not containing the path to the data directory. 
    Output: a dataframe with the columns rearranged to have cleaned Commune, District, and Canton in positions 2-5,
            with the District accent characters recoded to english characters.  
            
    Calls reorder_cols(filename), which calls clean_CDC(filename), which calls input_file(filename)
    '''
    df = reorder_cols(filename)
    
    df.Canton = df.Canton.replace({"Zürich": 'Zurich', "Graubünden / Grigioni / Grischun": "Graubunden / Grigioni / Grischun", 
                                           "Neuchâtel":"Neuchatel","Genève":"Geneve"})
    return df



def write_file(filename):
    '''
    Input: a filename, not containing the path to the data directory. 
    Output: a cleaned file, written to the data/clean_data/ directory as a .csv  
    
    Difference between the input file and the output file of this function: the columns have been rearranged to 
            have clean the "Canton (-) / District (>>) / Commune (......)" column to 3 columns:
            Commune, District, and Canton. These three columns were moved to positions 2-5 in the dataframe,
            and the District accent characters recoded to english characters
    
    Calls rm_acc_chars(filename), reorder_cols(filename), which calls clean_CDC(filename), which calls input_file(filename)
    '''
    df = rm_acc_chars(filename)
    path = "../data/clean_data/" + filename + "_cleaned.csv"
    df.to_csv(path)



for file in files_wCDCcol:
    write_file(file)

