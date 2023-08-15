## Implementation of Database

### Preprocessing of Data
Changed missing data in the 3 .cvs files to 'NULL' for the text attributes and 0 for the int attributes. NULL and 0 then both indicate that the data at that point is untracked. I used Microsoft Excel for the prepocessing.

### Import data
Created the schema 'russia_losses' in my local MySQL instance and then imported the 3 .csv files into the schema using the Table Data Import Wizard feature.

### MySQL Preparation of data
###### Corrected data according to corrections .csv file   
1) Updated 'equip_loss' table to add or subtract from attributes past a specific date based on info from the 'equip_loss_correction' table
2) Deleted 'equip_loss_correction' table after corrections were applied

###### Cleaned Up Data
3) Deleted 'mobile SRBM system' attribute from 'equip_loss' table (not enough data to be useful (updated twice over 522 days))
4) Added together 'military auto' and 'fuel tank' columns in 'equip_loss', merged that data into the blank beginning spots in 'vehicles and fuel tanks' (should match up)
5) Deleted the now redundant 'military auto' and 'fuel tank' columns in 'equip_loss', so there should just be 1 column ('vehicles and fuel tanks') containing all the data of the previous 3
6) Renamed 'personnel*' attribute in 'personnel loss' to 'personnel_about'

###### Split Up Tables
7) Created 'rus_war_timeline' and 'vehicles_and_ft_analysis' tables and copied corresponding data there

###### Removed Redunancies and Normalized Data
8) Deleted rows in 'vehicles_and_ft_analysis' where 'greatest losses direction' IS NULL bc redundant
9) Deleted 'date' attribute from 'equip_loss' and 'personnel_loss' bc redundant
10) Deleted 'greatest losses direction' attribute from 'equip_loss' bc redundant

###### Connected Tables
11) Add primary and foreign keys to all tables, connecting them
12) done!/proceed to analysis

### End product


### SQL code
The code used to implement the above database is in [rus_database_setup.sql](rus_database_setup.sql) or dilineated down below.
```sql
CREATE SCHEMA `russia_losses` ;

-- Created tables 'equip_loss', 'equip_loss_correction', and 'personnel_loss' through importing csv files

-- Updated 'equip_loss' table to add or subtract from attributes 
-- past a specific date based on info from the 'equip_loss_correction' table
UPDATE equip_loss el
SET el.APC = el.APC + (SELECT elc.APC FROM equip_loss_correction elc WHERE elc.day = 231),
el.`field artillery` = el.`field artillery` + (SELECT elc.`field artillery` FROM equip_loss_correction elc WHERE elc.day = 231),
el.drone = el.drone + (SELECT elc.drone FROM equip_loss_correction elc WHERE elc.day = 231),
el.`naval ship` = el.`naval ship` + (SELECT elc.`naval ship` FROM equip_loss_correction elc WHERE elc.day = 231)
WHERE el.day >= 231;

UPDATE equip_loss el
SET el.aircraft = el.aircraft + (SELECT elc.aircraft FROM equip_loss_correction elc WHERE elc.day = 458),
el.helicopter = el.helicopter + (SELECT elc.helicopter FROM equip_loss_correction elc WHERE elc.day = 458),
el.tank = el.tank + (SELECT elc.tank FROM equip_loss_correction elc WHERE elc.day = 458),
el.APC = el.APC + (SELECT elc.APC FROM equip_loss_correction elc WHERE elc.day = 458),
el.`field artillery` = el.`field artillery` + (SELECT elc.`field artillery` FROM equip_loss_correction elc WHERE elc.day = 458),
el.MRL = el.MRL + (SELECT elc.MRL FROM equip_loss_correction elc WHERE elc.day = 458),
el.drone = el.drone + (SELECT elc.drone FROM equip_loss_correction elc WHERE elc.day = 458),
el.`vehicles and fuel tanks` = el.`vehicles and fuel tanks` + (SELECT elc.`vehicles and fuel tanks` FROM equip_loss_correction elc WHERE elc.day = 458),
el.`cruise missiles` = el.`cruise missiles` + (SELECT elc.`cruise missiles` FROM equip_loss_correction elc WHERE elc.day = 458)
WHERE el.day >= 458;

-- Deleted 'equip_loss_correction' table after corrections were applied
DROP TABLE equip_loss_correction;

--  Deleted 'mobile SRBM system' attribute from 'equip_loss' table
-- (not enough data to be useful (updated twice over 522 days))
ALTER TABLE equip_loss
DROP COLUMN `mobile SRBM system`;

-- Added together 'military auto' and 'fuel tank' columns in 'equip_loss', merged that
-- data into the blank beginning spots in 'vehicles and fuel tanks' (should match up)
UPDATE equip_loss el
SET el.`vehicles and fuel tanks` = el.`vehicles and fuel tanks` + el.`military auto` + el.`fuel tank`;

-- Deleted the now redundant 'military auto' and 'fuel tank' columns in 'equip_loss',
-- so there should just be 1 column('vehicles and fuel tanks') containing all the data of the previous 3
ALTER TABLE equip_loss
DROP COLUMN `military auto`;
ALTER TABLE equip_loss
DROP COLUMN `fuel tank`;

-- Renamed 'personnel*' attribute in 'personnel loss' to 'personnel_about'
ALTER TABLE personnel_loss
RENAME COLUMN `personnel*` TO personnel_about;

-- Created 'rus_war_timeline' and 'vehicles_and_ft_analysis' tables
-- and copied corresponding data there
CREATE TABLE rus_war_timeline
AS (SELECT date, day FROM equip_loss);
CREATE TABLE vehicles_and_ft_analysis
AS (SELECT day, `greatest losses direction` FROM equip_loss);

-- Deleted rows in 'vehicles_and_ft_analysis' where 'greatest losses direction' IS NULL bc redundant
DELETE FROM vehicles_and_ft_analysis WHERE `greatest losses direction` IS NULL;

-- Deleted redunant attributes
ALTER TABLE equip_loss
DROP COLUMN date;
ALTER TABLE personnel_loss
DROP COLUMN date;
ALTER TABLE equip_loss
DROP COLUMN `greatest losses direction`;

-- established primary keys
ALTER TABLE rus_war_timeline
ADD CONSTRAINT PK_rus_war_timeline PRIMARY KEY (day);
ALTER TABLE equip_loss
ADD CONSTRAINT PK_equip_loss PRIMARY KEY (day);
ALTER TABLE personnel_loss
ADD CONSTRAINT PK_personnel_loss PRIMARY KEY (day);
ALTER TABLE vehicles_and_ft_analysis
ADD CONSTRAINT PK_vehicles_and_ft_analysis PRIMARY KEY (day);

-- established foreign keys
ALTER TABLE equip_loss
ADD CONSTRAINT FK_equip_loss FOREIGN KEY (day) REFERENCES rus_war_timeline (day);
ALTER TABLE personnel_loss
ADD CONSTRAINT FK_personnel_loss FOREIGN KEY (day) REFERENCES rus_war_timeline (day);
ALTER TABLE vehicles_and_ft_analysis
ADD CONSTRAINT FK_vehicles_and_ft_analysis FOREIGN KEY (day) REFERENCES rus_war_timeline (day);
```

