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
ALTER TABLE vehicles_and_ft_analysis MODIFY `greatest losses direction` VARCHAR(200);
ALTER TABLE vehicles_and_ft_analysis
ADD CONSTRAINT PK_vehicles_and_ft_analysis PRIMARY KEY (day, `greatest losses direction`);

-- established foreign keys
ALTER TABLE equip_loss
ADD CONSTRAINT FK_equip_loss FOREIGN KEY (day) REFERENCES rus_war_timeline (day);
ALTER TABLE personnel_loss
ADD CONSTRAINT FK_personnel_loss FOREIGN KEY (day) REFERENCES rus_war_timeline (day);
ALTER TABLE vehicles_and_ft_analysis
ADD CONSTRAINT FK_vehicles_and_ft_analysis FOREIGN KEY (day) REFERENCES rus_war_timeline (day);

-- add day 1 values so that day 2 per day losses can be calculated
INSERT INTO equip_loss (day, aircraft, helicopter, tank, APC, `field artillery`, MRL, 
drone, `naval ship`, `anti-aircraft warfare`, `special equipment`, `vehicles and fuel tanks`, `cruise missiles`) VALUES 
(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO personnel_loss (day, personnel, personnel_about, POW) VALUES (1, 0, "about", 0);

-- normalize vehicles_and_ft_analysis table
DELIMITER //
CREATE PROCEDURE splits (d int, losses VARCHAR(200), dl varchar(8))
BEGIN
INSERT INTO vehicles_and_ft_analysis (day, `greatest losses direction`) VALUES (d, trim(substring_index(losses, dl, 1)));
INSERT INTO vehicles_and_ft_analysis (day, `greatest losses direction`) VALUES (d, trim(substring_index(losses, dl, -1)));
DELETE FROM vehicles_and_ft_analysis WHERE day = d AND `greatest losses direction` = losses;
END
; //
DELIMITER ;


CALL splits(63, "Kurakhove and Izyum", 'and');
CALL splits(64, "Zaporizhzhia and Izyum", 'and');
CALL splits(70, "Izyum, Novopavlivsk", ',');
CALL splits(72, "Lyman and Kurakhove", 'and');
CALL splits(77, "Novopavlivsk, Kurakhove and Sievierodonetsk", ',');
CALL splits(77, "Kurakhove and Sievierodonetsk", 'and');
CALL splits(81, "Kurakhove and Avdiivka", 'and');
CALL splits(82, "Bakhmut and Zaporizhzhia", 'and');
CALL splits(83, "Lyman and Zaporizhzhia", 'and');
CALL splits(84, "Sloviansk, Kryvyi Rih and Zaporizhzhia", ',');
CALL splits(84, "Kryvyi Rih and Zaporizhzhia", 'and');
CALL splits(85, "Sloviansk, Kryvyi Rih and Zaporizhzhia", ',');
CALL splits(85, "Kryvyi Rih and Zaporizhzhia", 'and');
CALL splits(94, "Avdiivka and Kryvyi Rih", 'and');
CALL splits(97, "Kryvyi Rih and Zaporizhzhia", 'and');
CALL splits(98, "Kryvyi Rih and Bakhmut", 'and');
CALL splits(107, "Kharkiv and Bakhmut", 'and');
CALL splits(108, "Sievierodonetsk and Bakhmut", 'and');
CALL splits(109, "Sievierodonetsk and Bakhmut", 'and');
CALL splits(112, "Bakhmut and Sievierodonetsk", 'and');
CALL splits(115, "Sloviansk, Bakhmut and Kryvyi Rih", ',');
CALL splits(115, "Bakhmut and Kryvyi Rih", 'and');
CALL splits(116, "Bakhmut and Zaporizhzhia", 'and');
CALL splits(117, "Bakhmut and Zaporizhzhia", 'and');
CALL splits(118, "Bakhmut and Avdiivka", 'and');
CALL splits(119, "Sloviansk, Bakhmut and Avdiivka", ',');
CALL splits(119, "Bakhmut and Avdiivka", 'and');
CALL splits(121, "Sloviansk and Bakhmut", 'and');
CALL splits(122, "Bakhmut and Kurakhove", 'and');
CALL splits(123, "Bakhmut and Kurakhove", 'and');
CALL splits(124, "Bakhmut and Kurakhove", 'and');
CALL splits(130, "Kramatorsk and Bakhmut", 'and');
CALL splits(131, "Sloviansk and Donetsk", 'and');
CALL splits(132, "Sloviansk and Donetsk", 'and');
CALL splits(133, "Sloviansk and Donetsk", 'and');
CALL splits(134, "Avdiivka and Bakhmut", 'and');
CALL splits(149, "Kryvyi Rih and Bakhmut", 'and');
CALL splits(150, "Kramatorsk, Kryvyi Rih and Bakhmut", ',');
CALL splits(150, "Kryvyi Rih and Bakhmut", 'and');
CALL splits(159, "Donetsk and Kryvyi Rih", 'and');
CALL splits(160, "Bakhmut and Kryvyi Rih", 'and');
CALL splits(161, "Bakhmut and Donetsk", 'and');
CALL splits(162, "Bakhmut and Donetsk", 'and');
CALL splits(167, "Bakhmut and Donetsk", 'and');
CALL splits(171, "Bakhmut and Kryvyi Rih", 'and');
CALL splits(175, "Kharkiv and Donetsk", 'and');
CALL splits(179, "Donetsk and Mykolaiv", 'and');
CALL splits(188, "Donetsk and Kurakhove", 'and');
CALL splits(189, "Donetsk and Kurakhove", 'and');
CALL splits(190, "Donetsk and Kurakhove", 'and');
CALL splits(191, "Donetsk and Kurakhove", 'and');
CALL splits(192, "Donetsk and Kryvyi Rih", 'and');
CALL splits(193, "Donetsk and Kryvyi Rih", 'and');
CALL splits(198, "Kharkiv and Donetsk", 'and');
CALL splits(199, "Kharkiv and Donetsk", 'and');
CALL splits(200, "Kharkiv and Donetsk", 'and');
CALL splits(201, "Kryvyi Rih and Donetsk", 'and');
CALL splits(202, "Kharkiv and Donetsk", 'and');
CALL splits(203, "Kharkiv and Donetsk", 'and');
CALL splits(204, "Kryvyi Rih and Mykolaiv", 'and');
CALL splits(205, "Bakhmut and Donetsk", 'and');
CALL splits(209, "Bakhmut and Donetsk", 'and');
CALL splits(211, "Kramatorsk and Donetsk", 'and');
CALL splits(212, "Kramatorsk and Donetsk", 'and');
CALL splits(213, "Kramatorsk and Donetsk", 'and');
CALL splits(214, "Kramatorsk and Donetsk", 'and');
CALL splits(215, "Kramatorsk and Donetsk", 'and');
CALL splits(216, "Kramatorsk and Donetsk", 'and');
CALL splits(217, "Kramatorsk and Donetsk", 'and');
CALL splits(218, "Kramatorsk and Donetsk", 'and');
CALL splits(219, "Kramatorsk and Donetsk", 'and');
CALL splits(220, "Kramatorsk and Bakhmut", 'and');
CALL splits(221, "Kramatorsk and Bakhmut", 'and');
CALL splits(222, "Kramatorsk and Bakhmut", 'and');
CALL splits(223, "Kramatorsk and Kryvyi Rih", 'and');
CALL splits(224, "Kramatorsk and Kryvyi Rih", 'and');
CALL splits(225, "Kramatorsk, Avdiivka and Kryvyi Rih", ',');
CALL splits(225, "Avdiivka and Kryvyi Rih", 'and');
CALL splits(226, "Kramatorsk and Kryvyi Rih", 'and');
CALL splits(227, "Donetsk, Bakhmut and Kramatorsk", ',');
CALL splits(227, "Bakhmut and Kramatorsk", 'and');
CALL splits(229, "Kryvyi Rih and Kramatorsk", 'and');
CALL splits(230, "Bakhmut, Avdiivka and Kramatorsk", ',');
CALL splits(230, "Avdiivka and Kramatorsk", 'and');
CALL splits(231, "Bakhmut and Avdiivka", 'and');
CALL splits(232, "Kramatorsk and Kryvyi Rih", 'and');
CALL splits(233, "Kramatorsk and Bakhmut", 'and');
CALL splits(235, "Kryvyi Rih and Bakhmut", 'and');
CALL splits(236, "Bakhmut and Avdiivka", 'and');
CALL splits(238, "Bakhmut and Kramatorsk", 'and');
CALL splits(249, "Donetsk and Lyman", 'and');
CALL splits(250, "Avdiivka and Lyman", 'and');
CALL splits(251, "Avdiivka and Bakhmut", 'and');
CALL splits(252, "Avdiivka and Lyman", 'and');
CALL splits(254, "Lyman and Avdiivka", 'and');
CALL splits(255, "Lyman and Avdiivka", 'and');
CALL splits(256, "Lyman and Avdiivka", 'and');
CALL splits(257, "Lyman, Bakhmut and Avdiivka", ',');
CALL splits(257, "Bakhmut and Avdiivka", 'and');
CALL splits(258, "Bakhmut and Avdiivka", 'and');
CALL splits(259, "Bakhmut and Avdiivka", 'and');
CALL splits(260, "Lyman and Avdiivka", 'and');
CALL splits(266, "Lyman, Avdiivka and Bakhmut", 'and');
CALL splits(266, "Lyman, Avdiivka", ',');
CALL splits(268, "Lyman and Avdiivka", 'and');
CALL splits(272, "Bakhmut and Lyman", 'and');
CALL splits(273, "Avdiivka, Bakhmut and Lyman", ',');
CALL splits(273, "Bakhmut and Lyman", 'and');
CALL splits(274, "Avdiivka, Bakhmut and Lyman", ',');
CALL splits(274, "Bakhmut and Lyman", 'and');
CALL splits(275, "Bakhmut and Lyman", 'and');
CALL splits(277, "Bakhmut, Lyman and Avdiivka", ',');
CALL splits(277, "Lyman and Avdiivka", 'and');
CALL splits(282, "Bakhmut and Avdiivka", 'and');
CALL splits(284, "Bakhmut and Lyman", 'and');
CALL splits(285, "Bakhmut and Lyman", 'and');
CALL splits(290, "Bakhmut and Lyman", 'and');
CALL splits(298, "Lyman and Bakhmut", 'and');
CALL splits(304, "Kupiansk, Avdiivka and Bakhmut", ',');
CALL splits(304, "Avdiivka and Bakhmut", 'and');
CALL splits(306, "Kupiansk, Avdiivka and Bakhmut", ',');
CALL splits(306, "Avdiivka and Bakhmut", 'and');
CALL splits(307, "Bakhmut and Lyman", 'and');
CALL splits(309, "Lyman and Bakhmut", 'and');
CALL splits(310, "Lyman and Bakhmut", 'and');
CALL splits(312, "Lyman and Bakhmut", 'and');
CALL splits(313, "Lyman, Bakhmut and Avdiivka", ',');
CALL splits(313, "Bakhmut and Avdiivka", 'and');
