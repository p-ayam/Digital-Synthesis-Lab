## Digital Synthesis Lab (From Excel's User Interface to MySQL Database )
<br>


This work aims at making a simple, digital solution to keep synthetic records of a large chemistry departmnet in a normalized database. 

The assumption is that a summary of every **reaction**, **reagent** and **user** is recorded on the go by the chemists in a commonly accessible excel file as the user-end (`/Data/lab.xlsx`).


<img src="https://github.com/p-ayam/Digital-Synthesis-Lab/blob/master/pictures/excel_reaction.jpg" alt="alt text" width="1000" height="whatever">
<img src="https://github.com/p-ayam/Digital-Synthesis-Lab/blob/master/pictures/excel_reagent.jpg" alt="alt text" width="1000" height="whatever">
<img src="https://github.com/p-ayam/Digital-Synthesis-Lab/blob/master/pictures/excel_user.jpg" alt="alt text" width="1000" height="whatever">

A collection of python codes (`main.py` and `writexl.py`) **extract, transform and load (ETL)** the data to a normalized MySQL Workbench database (`laboratory.sql`) that contains 5 tables: `reaction`, `reagents`, `users`, `reactions_reagents` and `reactions_users` with the following schema:

The data from the reactions, the reagents and the users that are collected in the Excel file (`lab.xlsx`) could be deleted on the go to keep a lean file size.

Apart from the ETL process, additional features like **Views** and **Functions** are defined for the database that allow for an overall statistical overview of the
reactions, reagents and users. These calculations are performed in the database, making use of the entire dataset available from the beginning. The result of these calculations
will be updated in the Excel file's **Overview** sheet as following:
* The Overview sheet shows an updated perspective of the number of reactions that use a certain chemical reagent or the number of people who use this reagent (View=`reagent_user`). 
```
CREATE VIEW `reagent_use` AS
    SELECT 
        `chem`.`Reagent_id` AS `REAGENT_ID`,
        `chem`.`Location_ID` AS `LOCATION_ID`,
        COUNT(`rr`.`Reaction_id`) AS `NO_REACTIONS`,
        COUNT(DISTINCT `ru`.`User_id`) AS `NO_USERS`
    FROM
        (((`reagents` `chem`
        JOIN `reactions_reagents` `rr` ON ((`chem`.`Reagent_id` = `rr`.`Reagent_id`)))
        JOIN `reactions` `rea` ON ((`rr`.`Reaction_id` = `rea`.`Reaction_id`)))
        JOIN `reactions_users` `ru` ON ((`rr`.`Reaction_id` = `ru`.`Reaction_id`)))
    GROUP BY `chem`.`Reagent_id`
    ORDER BY `chem`.`Reagent_id`
```
* It also shows the number of the reactions that chemists have performed and the due dates in which they were carried out (View=`user_metrics`).
```
CREATE VIEW `user_metrics` AS
    SELECT 
        `u`.`user_id` AS `user_id`,
        CONCAT(`u`.`First_Name`, ' ', `u`.`Family_Name`) AS `Full_Name`,
        COUNT(`ru`.`Reaction_id`) AS `No_Reactions`,
        GROUP_CONCAT(DISTINCT `rea`.`Date`
            ORDER BY `rea`.`Date` DESC
            SEPARATOR ', ') AS `REACTION_DATES`
    FROM
        ((`users` `u`
        JOIN `reactions_users` `ru` ON ((`u`.`user_id` = `ru`.`User_id`)))
        JOIN `reactions` `rea` ON ((`rea`.`Reaction_id` = `ru`.`Reaction_id`)))
    GROUP BY `u`.`user_id`
    ORDER BY `u`.`user_id`
```
* The Overview sheet also shows the average number of chemical reagents that have been used in the reactions, the average number of chemists working on the syntheses, as well as the average temperature and yeild of the reactions (View=`reactions_overview`).
```
CREATE VIEW `reactions_overview` AS
    SELECT 
        (COUNT(`rr`.`Reagent_id`) / COUNT(DISTINCT `rr`.`Reaction_id`)) AS `Avg_No_Chem_per_Reaction`,
        (SELECT 
                (COUNT(`ru`.`User_id`) / COUNT(DISTINCT `ru`.`Reaction_id`))
            FROM
                `reactions_users` `ru`) AS `Avg_No_User_per_Reaction`,
        (SELECT 
                (AVG(`reactions`.`Temperature`) - 273.15)
            FROM
                `reactions`) AS `AVG_TEMP_DEG_C`,
        (SELECT 
                AVG(`reactions`.`Yield`)
            FROM
                `reactions`) AS `AVG_YIELD_PER_CENT`
    FROM
        `reactions_reagents` `rr`
```



```diff
- [test text in red]
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```