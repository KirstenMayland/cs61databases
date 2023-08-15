## Implementation of Database

### Preprocessing of Data
Changed missing data in the 3 .cvs files to 'NULL' for the text attributes and 0 for the int attributes. NULL and O then both indicate that the data at that point is untracked.

### Import data
Created the schema 'russia_losses' in my local MySQL instance and then imported the 3 .csv files into the schema using the Table Data Import Wizard feature.

### MySQL preparation of data
###### Corrected data according to corrections .csv file   
1) Updated 'equip_loss' table to add or subtract from attributes past a specific date based on info from the 'equip_loss_correction' table
2) Deleted 'equip_loss_correction' table after

###### Cleaned Up Data
4) Deleted 'mobile SRBM system' attribute from 'equip_loss' table (not enough data to be useful (updated twice over 522 days))
5) Added together 'military auto' and 'fuel tank' columns in 'equip_loss', merged that data into the blank beginning spots in 'vehicles and fuel tanks' (should match up)
6) Deleted the now redundant 'military auto' and 'fuel tank' columns in 'equip_loss', so there should just be 1 column ('vehicles and fuel tanks') containing all the data of the previous 3

###### Split Up and Normalized Data
7) Created 'losses' and 'vehicles_and_ft_analysis' tables and move data there

###### Removed Redunancies
8) Deleted rows in 'vehicles_and_ft_analysis' where 'greatest losses direction' IS NULL cb redundant
9) Deleted 'date' attribute from 'equip_loss' and 'personnel_loss' bc redundant

###### Connected Tables
11) Add primary and foreign keys to all tables, connecting them
12) done!/proceed to analysis

### End product
