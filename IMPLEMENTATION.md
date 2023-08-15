## Implementation of Database

### Preprocessing of Data
Changed missing data in the 3 .cvs files to 'NULL' for the text attributes and 0 for the int attributes. NULL and O then both indicate that the data at that point is untracked.

### Import data
Created the schema 'russia_losses' in my local MySQL instance and then imported the 3 .csv files into the schema using the Table Data Import Wizard feature.

### MySQL preparation of data
1) Updated 'equip_loss' table to accommodate corrections from the 'equip_loss_correction' table
2) Deleted 'equip_loss_correction' table after
3) Deleted 'mobile SRBM system' attribute from 'equip_loss' table (not enough data to be useful (updated twice over 522 days))
4) Added together 'military auto' and 'fuel tank' columns in 'equip_loss', merged that data into the blank beginning spots in 'vehicles and fuel tanks' (should match up)
5) Deleted the now redundant 'military auto' and 'fuel tank' columns in 'equip_loss', so there should just be 1 column ('vehicles and fuel tanks') containing all the data of the previous 3  
6) Created 'losses' and 'vehicles_and_ft_analysis' tables and move data there
7) Deleted rows in 'vehicles_and_ft_analysis' where 'greatest losses direction' IS NULL
8) Deleted 'date' attribute from 'equip_loss' and 'personnel_loss' bc redundant
9) Add primary and foreign keys to all tables, connecting them
10) done!/proceed to analysis
