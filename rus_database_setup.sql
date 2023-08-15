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

